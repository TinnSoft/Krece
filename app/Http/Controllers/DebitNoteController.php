<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    DebitNoteDetail,
    DebitNote,
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
use Illuminate\Support\Facades\DB;
use App\Contracts\IPdfRepository;

class DebitNoteController extends Controller
{
    protected $iPdfRepo;
    
    public function __construct(IPdfRepository $iPdfRepo)
    {
        $this->iPdfRepo = $iPdfRepo;
    }
    
    public function index()
    {
        
        return view('debit-note.index');
    }
    
    public function getDebitNoteList()
    {
        $debitnote = DebitNote::with('contact')
        ->GetAll(0)
        ->orderBy('created_at', 'desc')
        ->GetSelectedFields()
        ->get();
        
        return response()->json($debitnote);
    }
    
    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
        
        $baseInfo=[
        'public_id' => Helper::PublicId(DebitNote::class),
        'contacts' => Helper::providers(),
        'currency'=>Helper::currencylist(),
        'productlist'=>Helper::category_outcome(),
        'default_Currency'=>Helper::default_currency(),
            'taxes'=>Helper::taxes(),
            'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'debit_note')
            ];
            
            return response()->json($baseInfo);
            
    }
    
    public function create()
    {
        return view('debit-note.create');
    }
    
    public function store(Request $request)
    {
        $this->validate($request, [
        'customer_id' => 'required',
        'date' => 'required',
        'detail.*.unit_price' => 'required|numeric|min:0',
        'detail.*.quantity' => 'required|integer|min:1',
        'detail.*.category_id' => 'required',
        ]);
        
        
        
        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
            return new DebitNoteDetail($detail);
        });
        
        
        
        if($products->isEmpty()) {
            return response()
            ->json([
            'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
        $data = $request->except('detail','contact','currency');
        
        $data['public_id'] = Helper::PublicId(DebitNote::class);
        $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'debit_note')['number'];
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['date']=Helper::dateFormatter($data['date']);
        
        if (!$data['currency_code'])
        {
            $data['currency_code']=CURRENCY_CODE_DEFAULT;
        }
        
        
        $debitnote = DebitNote::create($data);
        $debitnote->detail()->saveMany($products);
        
        //Incrementa el numero de resolución
        ResolutionNumber::where('key', 'debit_note')
        ->increment('number');
        
        event(new RecordActivity('Create','Se creó la Nota Débito número: '
        .$debitnote->resolution_id.' para el cliente '.$debitnote->contact->name,
        'DebitNote','/debit-note/'.$debitnote->public_id));
        
        return response()
        ->json([
        'created' => true,
        'id' => $debitnote->public_id
        ]);
    }
    
    public function show($id)
    {
        $debitnote = DebitNote::with('detail')
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();
        if (!$debitnote)
        {
            $notification = array(
            'message' => 'No se encontró ninguna referencia de cotizacion creadas!',
            'alert-type' => 'error'
            );
            return redirect('/debit-note')->with($notification);
        }
        
        $debitnote=Helper::_InvoiceFormatter($debitnote);
        
        $taxes=Helper::getTotalTaxes($debitnote->public_id,'debit_note','debit_note_detail');
        
        return view('debit-note.show', compact('debitnote','taxes'));
    }
    
    
    public function edit($id)
    {
        $debitnote = DebitNote::with(['detail','contact','currency'])
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();
        
        if (!$debitnote)
        {
            $notification = array(
            'message' => 'No se encontró ninguna referencia de cotizacion creadas!',
            'alert-type' => 'error'
            );
            return redirect('/debit-note')->with($notification);
        }
        
        $debitnote['date']= Helper::setCustomDateFormat(Carbon::parse($debitnote['date']));
        
        
        return view('debit-note.edit', compact('debitnote'));
    }
    
    
    public function update(Request $request, $id)
    {
        
        $this->validate($request, [
        'customer_id' => 'required',
        'date' => 'required',
        'detail.*.unit_price' => 'required|numeric|min:0',
        'detail.*.quantity' => 'required|integer|min:1',
        'detail.*.category_id' => 'required',
        ]);
        
        $debitnote = DebitNote::findOrFail($id);
        
        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
            return new DebitNoteDetail($detail);
        });
        
        
        
        if($products->isEmpty()) {
            return response()
            ->json([
            'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
        $data = $request->except('detail','contact','list_price','currency');
        
        $data['user_id'] = Auth::user()->id;
        $data['date']=Helper::dateFormatter($data['date']);
        $debitnote->update($data);
        
        DebitNoteDetail::where('debit_note_id', $debitnote->id)->delete();
        $debitnote->detail()->saveMany($products);
        
        event(new RecordActivity('Update','Se actualizó la Nota Debito número: '
        .$debitnote->resolution_id.' para el cliente '.$debitnote->contact->name,
        'DebitNote','/debit-note/'.$debitnote->public_id));
        
        return response()
        ->json([
        'updated' => true,
        'id' => $debitnote->public_id
        ]);
    }
    
    public function destroy($id)
    {
        
        $debitnote = DebitNote::GetByPublicId(0,$id)
        ->firstOrFail();
        
        $debitnote['isDeleted']=1;
        $debitnote['deleted_at']=$now = Carbon::now();
        $debitnote->save();
        
        return response()
        ->json([
        'deleted' => true
        ]);
    }
    
    public function pdf($id, Request $request)
    {
        $mypdf=$this->iPdfRepo->create(DebitNote::class, $id);
        
        $filename = "NotaDebito_"."{$id}.pdf";
        
        if($request->get('opt') === 'download') {
            return $pdf->download($filename);
        }
        
        event(new RecordActivity('Print','Se ha impreso el pdf de la Nota Débito No: '
        .$id,
        'DebitNote','/debit-note/'.$id));
        
        return $mypdf->stream();
        
    }
    
    
}