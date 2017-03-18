<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    CreditNoteDetail,
    CreditNote,
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

class CreditNoteController extends Controller
{

    public function index()
    {
        return view('credit-note.index');  
    }

    public function getCreditNoteList()
    {
        //Obtener las cotizaciones creadas hasta la fecha       
        $creditnote = CreditNote::with('contact')
               ->GetAll(0)
               ->orderBy('created_at', 'desc')
                ->GetSelectedFields()
               ->get();

         return response()->json($creditnote);
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
       
        $baseInfo=[
                'public_id' => Helper::PublicId(CreditNote::class),
                'contacts' => Helper::contacts(),
               'listprice'=>Helper::listPrice(),
               'currency'=>Helper::currencylist(),
               'productlist'=>Helper::productlist(),
               'default_Currency'=>Helper::default_currency(),
               'list_price'=>Helper::listprice_default(), 
               'taxes'=>Helper::taxes(),
               'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'credit_note')
            ];
             
     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('credit-note.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',         
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',    
        ]);

        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100); 
            return new CreditNoteDetail($detail);
        });
        

        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };

        $data = $request->except('detail','contact','seller','list_price','currency');      
         
        $data['public_id'] = Helper::PublicId(CreditNote::class);
        $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'credit_note')['number'];
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Helper::dateFormatter($data['date']);
       
         if (!$data['currency_code'])
        {
            $data['currency_code']="COP";
        }
     
        $creditnote = CreditNote::create($data);
        $creditnote->detail()->saveMany($products);
        
        //Incrementa el numero de cotización
        ResolutionNumber::where('key', 'credit_note')
                ->increment('number');
       
        event(new RecordActivity('Create','Se creó la Nota Crédito número: ' 
			.$creditnote->resolution_id.' para el cliente '.$creditnote->contact->name,
			'CreditNote','/credit-note/'.$creditnote->public_id));	

        return response()
            ->json([
                'created' => true,
                'id' => $creditnote->public_id
            ]);
    }

    public function show($id)
    {          
          $creditnote = CreditNote::with('detail','list_price')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();        

        if (!$creditnote)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/credit-note')->with($notification);
        }
        
        $creditnote=Helper::_InvoiceFormatter($creditnote);

        $taxes=$this->getTotalTaxes($creditnote->public_id);

        return view('credit-note.show', compact('creditnote','taxes'));
    }


    public function edit($id)
    {        
        $creditnote = CreditNote::with(['detail','contact','list_price','currency'])
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();
        
         if (!$creditnote)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/credit-note')->with($notification);
        }

        $creditnote['date']= Helper::setCustomDateFormat(Carbon::parse($creditnote['date']));
        
        
         return view('credit-note.edit', compact('creditnote'));
    }

    
    public function update(Request $request, $id)
    {  

        $this->validate($request, [     
            'customer_id' => 'required',               
            'date' => 'required',        
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',    
        ]);
       
        $creditnote = CreditNote::findOrFail($id);

        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100); 
            return new CreditNoteDetail($detail);
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
        $creditnote->update($data);
       
        CreditNoteDetail::where('credit_note_id', $creditnote->id)->delete();
        $creditnote->detail()->saveMany($products);

         event(new RecordActivity('Update','Se actualizó la Nota Crédito número: ' 
			.$creditnote->resolution_id.' para el cliente '.$creditnote->contact->name,
			'CreditNote','/credit-note/'.$creditnote->public_id));	

        return response()
            ->json([
                'updated' => true,
                'id' => $creditnote->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $creditnote = CreditNote::GetByPublicId(0,$id)
                ->firstOrFail();   
            
            $creditnote['isDeleted']=1;
            $creditnote['deleted_at']=$now = Carbon::now();
            $creditnote->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function pdf($id, Request $request)
    {
         $creditnote = CreditNote::with('account','detail','list_price')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
                
       $creditnote=Helper::_InvoiceFormatter($creditnote);
    
        
        $mypdf = PDF::loadView('pdf.credit-note', ['creditnote' => $creditnote,'taxes' => $this->getTotalTaxes($creditnote->public_id)]);
        $filename = "NotaCredito_"."{$creditnote->public_id}.pdf";

         if($request->get('opt') === 'download') {
            return $pdf->download($filename);            
        }

         event(new RecordActivity('Print','Se ha impreso el pdf de la Nota Crédito No: ' 
			.$creditnote->resolution_id,
			'CreditNote','/credit-note/'.$creditnote->public_id));	
        
        return $mypdf->stream();

    }

    public static function getTotalTaxes($public_id)
    {
        $taxes=
        DB::table('credit_note')
            ->join('credit_note_detail', 'credit_note.id', '=', 'credit_note_detail.credit_note_id')
             ->join('tax', 'credit_note_detail.tax_id', '=', 'tax.id')
            ->where('credit_note.account_id',Auth::user()->account_id) 
             ->where('credit_note.public_id',$public_id)  
              ->where('credit_note_detail.tax_amount','>',0)             
            ->select(DB::raw("CONCAT(tax.name,' (',credit_note_detail.tax_amount,'%)') AS name"), 
            DB::raw('SUM(credit_note_detail.total_tax) as total'))
            ->groupBy('tax.name','credit_note_detail.tax_amount')
            ->get();

            return  Helper::_taxesFormatter($taxes);
    }
}
