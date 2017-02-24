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

class DebitNoteController extends Controller
{

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
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
       
         if (!$data['currency_code'])
        {
            $data['currency_code']="COP";
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

        $taxes=$this->getTotalTaxes($debitnote->public_id);
       
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
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
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
        Carbon::setLocale('es');

         $debitnote = DebitNote::with('account','detail')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
                
       $debitnote=Helper::_InvoiceFormatter($debitnote);    
        
        $mypdf = PDF::loadView('pdf.debit-note', ['debitnote' => $debitnote,'taxes' => $this->getTotalTaxes($debitnote->public_id)]);
        $filename = "NotaDebito_"."{$debitnote->public_id}.pdf";

         if($request->get('opt') === 'download') {
            return $pdf->download($filename);            
        }

         event(new RecordActivity('Print','Se ha impreso el pdf de la Nota Débito No: ' 
			.$debitnote->resolution_id,
			'DebitNote','/debit-note/'.$debitnote->public_id));	
        
        return $mypdf->stream();

    }

    public static function getTotalTaxes($public_id)
    {
        $taxes=
        DB::table('debit_note')
            ->join('debit_note_detail', 'debit_note.id', '=', 'debit_note_detail.debit_note_id')
             ->join('tax', 'debit_note_detail.tax_id', '=', 'tax.id')
            ->where('debit_note.account_id',Auth::user()->account_id) 
             ->where('debit_note.public_id',$public_id)  
              ->where('debit_note_detail.tax_amount','>',0)             
            ->select(DB::raw("CONCAT(tax.name,' (',debit_note_detail.tax_amount,'%)') AS name"), 
            DB::raw('SUM(debit_note_detail.total_tax) as total'))
            ->groupBy('tax.name','debit_note_detail.tax_amount')
            ->get();

            return  Helper::_taxesFormatter($taxes);
    }
}
