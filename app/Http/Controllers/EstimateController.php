<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    EstimateDetail,
    Estimate,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use Jenssegers\Date\Date;

class EstimateController extends Controller
{
    
    public function index()
    {
        return view('estimate.index');
    }
    
    public function getEstimateList()
    {
        //Obtener las cotizaciones creadas hasta la fecha
        $estimate = Estimate::with('contact')
        ->GetAll(0)
        ->orderBy('created_at', 'desc')
        ->GetSelectedFields()
        ->get();
        
        return response()->json($estimate);
    }
    
    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
        
        $baseInfo=[
        'public_id' => Helper::PublicId(Estimate::class),
        'contacts' => Helper::contacts(),
        'sellers'=>Helper::sellers(),
        'listprice'=>Helper::listPrice(),
        'currency'=>Helper::currencylist(),
        'productlist'=>Helper::productlist(),
        'default_Currency'=>Helper::default_currency(),
            'list_price'=>Helper::listprice_default(),
                'taxes'=>Helper::taxes(),
                'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'estimate')
                ];
                
                return response()->json($baseInfo);
                
        }
        
        public function create()
        {
            return view('estimate.create');
        }
        
        public function store(Request $request)
        {
            $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',
            ]);
            
            $products = collect($request->detail)->transform(function($detail) {
                $baseprice=$detail['quantity'] * $detail['unit_price'];
                $totalDiscount= $baseprice*($detail['discount']/100);
                $detail['total'] = $baseprice- $totalDiscount;
                $detail['user_id'] =  Auth::user()->id;
                return new EstimateDetail($detail);
            });
            
            
            if($products->isEmpty()) {
                return response()
                ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
                ], 422);
            };
            
            $data = $request->except('detail','contact','seller');
            
            
            $data['public_id'] = Helper::PublicId(Estimate::class);
            $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'estimate')['number'];
            $data['account_id'] = Auth::user()->account_id;
            $data['user_id'] = Auth::user()->id;
            $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
            $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
            
            if (!$data['currency_code'])
            {
                $data['currency_code']="COP";
            }
            
            
            $estimate = Estimate::create($data);
            $estimate->detail()->saveMany($products);
            
            //Incrementa el numero de cotización
            ResolutionNumber::where('key', 'estimate')
            ->increment('number');
            
            event(new RecordActivity('Create','Se creó la Cotización número: '
            .$estimate->resolution_id.' para el cliente '.$estimate->contact->name,
            'Estimate','/estimate/'.$estimate->public_id));
            
            return response()
            ->json([
            'created' => true,
            'id' => $estimate->public_id
            ]);
        }
        
        
        public function show($id)
        {
            
            $estimate = Estimate::with('detail','list_price','seller')
            ->GetByPublicId(0,$id)
            ->GetSelectedFields()
            ->first();
            
            if (!$estimate)
            {
                $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!',
                'alert-type' => 'error'
                );
                return redirect('/estimate')->with($notification);
            }
            
            $estimate=Helper::_InvoiceFormatter($estimate);
            
            return view('estimate.show', compact('estimate'));
        }
        
        
        public function edit($id)
        {
            
            $estimate = Estimate::with(['detail','contact','list_price','currency','seller'])
            ->GetByPublicId(0,$id)
            ->GetSelectedFields()
            ->first();
            
            
            if (!$estimate)
            {
                $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!',
                'alert-type' => 'error'
                );
                return redirect('/estimate')->with($notification);
            }
            
            $estimate['date']= Helper::setCustomDateFormat(Carbon::parse($estimate['date']));
            $estimate['due_date']= Helper::setCustomDateFormat(Carbon::parse($estimate['due_date']));
            
            if (request()->get('convert')=='clone')
            {
                $PublicId = Estimate::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
                $estimate['public_id']= $PublicId;
                $estimate['date']=Helper::setCustomDateFormat(Carbon::now());
                $estimate['due_date']=null;
                $estimate['notes']=null;
                return view('estimate.clone', compact('estimate'));
            }
            
            return view('estimate.edit', compact('estimate'));
        }
        
        
        public function update(Request $request, $id)
        {
            
            $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',
            ]);
            
            $estimate = Estimate::findOrFail($id);
            
            $products = collect($request->detail)->transform(function($detail) {
                $baseprice=$detail['quantity'] * $detail['unit_price'];
                $totalDiscount= $baseprice*($detail['discount']/100);
                $detail['total'] = $baseprice- $totalDiscount;
                $detail['user_id'] =  Auth::user()->id;
                return new EstimateDetail($detail);
            });
            
            if($products->isEmpty()) {
                return response()
                ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
                ], 422);
            };
            
            $data = $request->except('detail');
            
            $data['user_id'] = Auth::user()->id;
            $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
            $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
            $estimate->update($data);
            
            EstimateDetail::where('estimate_id', $estimate->id)->delete();
            $estimate->detail()->saveMany($products);
            
            event(new RecordActivity('Update','Se actualizó la Cotización número: '
            .$estimate->resolution_id.' para el cliente '.$estimate->contact->name,
            'Estimate','/estimate/'.$estimate->public_id));
            
            return response()
            ->json([
            'updated' => true,
            'id' => $estimate->public_id
            ]);
        }
        
        public function destroy($id)
        {
            
            $estimate = Estimate::GetByPublicId(0,$id)
            ->firstOrFail();
            
            $estimate['isDeleted']=1;
            $estimate['deleted_at']=$now = Carbon::now();
            $estimate->save();
            
            event(new RecordActivity('Delete','Se eliminó la cotización número: '
            .$estimate->resolution_id,
            'Estimate',null));
            
            return response()
            ->json([
            'deleted' => true
            ]);
        }
        
        public function pdf($id, Request $request)
        {
            Carbon::setLocale('es');
            
            $estimate = Estimate::with('account','detail','list_price','seller')
            ->GetByPublicId(0,$id)
            ->GetSelectedFields()
            ->first();
            
            $estimate=Helper::_InvoiceFormatter($estimate);
            
            
            $mypdf = PDF::loadView('pdf.estimate', ['estimate' => $estimate]);
            $filename = "Cotizacion_"."{$estimate->public_id}.pdf";
            
            if($request->get('opt') === 'download') {
                return $pdf->download($filename);
            }
            
            event(new RecordActivity('Print','Se ha impreso el pdf de la cotización No: '
            .$estimate->resolution_id,
            'Estimate','/estimate/'.$estimate->public_id));
            
            return $mypdf->stream();
            
        }
    }