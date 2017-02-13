<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    InvoiceDetail,
    Invoice,
    InvoiceDocumentType,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber,
    Resolution
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;

class InvoiceController extends Controller
{

    public function index()
    {
        return view('invoice.index');  
    }

    public function getInvoiceList()
    {
        //Obtener las cotizaciones creadas hasta la fecha       
        $invoice = Invoice::with('contact')
               ->GetAll(0)
               ->orderBy('created_at', 'desc')
                ->GetSelectedFields()
               ->get();

         return response()->json($invoice);
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {

        $defaultCurrency=null;

        $resolutionID=Resolution::select('next_invoice_number')
                                ->where('isDefault',1)
                                ->where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->where('isActive',1)
                                ->first();

        $numeration_for_saleOrder=Resolution::select('id','name','prefix','next_invoice_number','auto_increment')
                                ->where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->where('isActive',1)
                                ->get()
                                ->toArray();

        $baseInfo=[
                'public_id' =>Helper::PublicId(Invoice::class),
                'contacts' => Helper::contacts(),
               'sellers'=>Helper::sellers(),
               'listprice'=>Helper::listPrice(),
               'currency'=>Helper::currencylist(),
               'productlist'=>Helper::productlist(),
               'taxes'=>Helper::taxes(),
               'resolution_id'=>$resolutionID,
               'list_price'=>Helper::listprice_default(), 
               'default_Currency'=>$defaultCurrency,
               'paymentTerms'=>Helper::PaymentTerms(),
               'numerationList_sale_order'=>$numeration_for_saleOrder
            ];

     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('invoice.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'documentType_id' => 'required',            
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',    
        ]);

        $products = collect($request->detail)->transform(function($detail) {
            $detail['total'] = $detail['quantity'] * $detail['unit_price'];
            $detail['user_id'] =  Auth::user()->id;
            return new InvoiceDetail($detail);
        });
        

        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };

        
        $data = $request->except('detail','documentType','list_price','currency','contact','seller');       
        
        $data['public_id'] = Helper::PublicId(Invoice::class);
        $data['document_type_id'] =  (int)$data['documentType_id'];
        $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'invoice')['number'];
        $data['status_id'] = 1;        
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
        
        //Default
        if (!$data['currency_code'])
        {
            $data['currency_code']="COP";
        }

        $invoice = Invoice::create($data);
        $invoice->detail()->saveMany($products);
     
        //Incrementa el numero de cotización
        ResolutionNumber::where('key', 'invoice')
                ->increment('number');
       
       event(new RecordActivity('Create','Se creó la remisión número: ' 
			.$invoice->resolution_id.' para el cliente '.$invoice->contact->name,
			'Invoice','/invoice/'.$invoice->public_id));	

        return response()
            ->json([
                'created' => true,
                'id' => $invoice->public_id
            ]);
    }

    public function show($id)
    {
          $invoice = Invoice::with('detail','list_price','seller','payment_terms')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();     

        if (!$invoice)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de invoice creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/invoice')->with($notification);
        }
       
        $invoice=Helper::_InvoiceFormatter($invoice);

        return view('invoice.show', compact('invoice'));
    }



    public function edit($id)
    {
        
        $invoice = Invoice::with(['detail','contact','list_price','currency','seller','payment_terms'])
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();

        
         if (!$invoice)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/invoice')->with($notification);
        }


        $invoice['date']= Helper::setCustomDateFormat(Carbon::parse($invoice['date']));
        $invoice['due_date']= Helper::setCustomDateFormat(Carbon::parse($invoice['due_date']));
        
        if (request()->get('convert')=='clone')
        {
            $PublicId = Helper::PublicId(Invoice::class);
            $invoice['public_id']= $PublicId;
            $invoice['date']=Helper::setCustomDateFormat(Carbon::now());
            $invoice['due_date']=Helper::setCustomDateFormat(Carbon::now()->addDays(30));
            $invoice['notes']=null;
            return view('invoice.clone', compact('invoice'));
        }

         return view('invoice.edit', compact('invoice'));
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
       
        $invoice = Invoice::findOrFail($id);

        $products = collect($request->detail)->transform(function($detail) {
        $detail['total'] = $detail['quantity'] * $detail['unit_price'];
        $detail['user_id'] =  Auth::user()->id;
            return new InvoiceDetail($detail);
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
        $invoice->update($data);
       
        InvoiceDetail::where('invoice_id', $invoice->id)->delete();
        $invoice->detail()->saveMany($products);

        event(new RecordActivity('Update','Se actualizó la remisión número: ' 
			.$invoice->resolution_id.' para el cliente '.$invoice->contact->name,
			'Invoice','/invoice/'.$invoice->public_id));	

        return response()
            ->json([
                'updated' => true,
                'id' => $invoice->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $invoice = Invoice::GetByPublicId(0,$id)
                ->firstOrFail();   
            
            $invoice['isDeleted']=1;
            $invoice['deleted_at']=$now = Carbon::now();
            $invoice->save();
            
            event(new RecordActivity('Delete','Se eliminó la remisión número: ' 
			.$invoice->resolution_id,
			'Invoice',null));	

            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function pdf($id, Request $request)
    {
        Carbon::setLocale('es');

         $invoice = Invoice::with('account','detail','list_price','seller')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
                
        $invoice=Helper::_InvoiceFormatter($invoice);
        
        $mypdf = PDF::loadView('pdf.invoice', ['invoice' => $invoice]);
        $filename = "Invoice_"."{$invoice->public_id}.pdf";

         if($request->get('opt') === 'download') {
            return $pdf->download($filename);            
        }
        
        event(new RecordActivity('Print','Se ha impreso el pdf de la invoice No: ' 
			.$invoice->resolution_id,
			'Invoice','/invoice/'.$invoice->public_id));	

        return $mypdf->stream();
    }
    
    public function update_state(Request $request,$id)
    {
        
            $data = $request->all(); 
            $data['status_id']= (int)$data['status_id'];             

            $item = Invoice::findOrFail($id);
              
            $item->update($data);

            event(new RecordActivity('Update','Se actualizó el estado de la remisión número: ' 
			.$invoice->resolution_id.' para el cliente '.$invoice->contact->name,
			'Invoice','/invoice/'.$invoice->public_id));	

            return response()
            ->json([
                'updated' => true                           
            ]);
    }

}
