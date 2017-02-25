<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    InvoiceSaleOrderDetail,
    InvoiceSaleOrder,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber,
    Resolution,
    Category
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use Illuminate\Support\Facades\DB;

class InvoiceSaleOrderController extends Controller
{

    public function index()
    {
        return view('invoice.index');  
    }

    public function getInvoiceList()
    {

         $invoice = DB::table('invoice_sale_order')   
                    ->Join('contact', 'invoice_sale_order.customer_id', '=', 'contact.id')
                    ->leftJoin('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')  
                    ->leftjoin('payment', function ($join) {
                        $join->on('payment.id', '=', 'payment_history.payment_id')
                            ->where('payment.isDeleted',0);
                    })         
                    ->where('invoice_sale_order.account_id',Auth::user()->account_id)
                    ->where('invoice_sale_order.isDeleted',0)   
                    ->select('invoice_sale_order.resolution_id','invoice_sale_order.status_id', 
                    'invoice_sale_order.due_date', 'contact.name as contact_name','contact.id as contact_id',
                    DB::raw('SUM(payment_history.amount) as total_payed'),'invoice_sale_order.created_at',
                    'invoice_sale_order.public_id','invoice_sale_order.total',
                    DB::raw('invoice_sale_order.total - sum(IFNULL(payment_history.amount,0)) as pending_to_pay')
                    )
                    ->groupBy('invoice_sale_order.resolution_id','invoice_sale_order.status_id', 
                    'invoice_sale_order.due_date', 'contact.name',
                    'invoice_sale_order.created_at','contact.id',
                    'invoice_sale_order.public_id','invoice_sale_order.total')
                    ->orderby('invoice_sale_order.resolution_id','desc')
                    ->get();
            
         return response()->json($invoice);
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
        
        $resolutionID=Resolution::select('next_invoice_number')
                                ->where('isDefault',1)
                                ->where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->where('isActive',1)
                                ->first();

        $numeration_for_saleOrder=Resolution::select('id','name','prefix','next_invoice_number','auto_increment','isDefault')
                                ->where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->where('isActive',1)
                                ->get()
                                ->toArray();

        $baseInfo=[
                'public_id' =>Helper::PublicId(InvoiceSaleOrder::class),
                'contacts' => Helper::contacts(),
               'sellers'=>Helper::sellers(),
               'listprice'=>Helper::listPrice(),
               'currency'=>Helper::currencylist(),
               'productlist'=>Helper::productlist(),
               'taxes'=>Helper::taxes(),
               'resolution_id'=>$resolutionID,
               'list_price'=>Helper::listprice_default(), 
               'default_Currency'=>Helper::default_currency(),
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
            'payment_terms_id' => 'required',
            'resolution_number'   =>'required_if:ResolutionIsAutoNumeric,false',         
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',    
        ]);

       
        $data = $request->except('detail','list_price','currency','contact','seller','payment_terms'
                ,'resolution','ResolutionIsAutoNumeric','resolution_id');  


        //el numero de resolución debe ser único
        $checkInvoiceNumber=InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                            ->where('resolution_id',$data['resolution_number'])->get()->count();


         if ($checkInvoiceNumber>0)
         {
                return response()
            ->json([
                'invoice_exists' => ['Ya existe una factura con el número '.$data['resolution_number'].' creado, asegúrese de ingresar ún número válido ']
            ], 422); 
         }

        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);           
            return new InvoiceSaleOrderDetail($detail);
        });
        

        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
        $categoryId=Category::select('id')
                    ->where('account_id',Auth::user()->account_id)
                    ->where('name','Ventas')
                    ->first();

        $data['public_id'] = Helper::PublicId(InvoiceSaleOrder::class);     
        $data['resolution_id'] = (int)$data['resolution_number'];      
        $data['status_id'] = 1;   
        $data['category_id'] = $categoryId['id'];       
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
     
        //Default
        if (!$data['currency_code'])
        {
            $data['currency_code']="COP";
        }
            
        $invoice = InvoiceSaleOrder::create($data);

        try
        {
        $invoice->detail()->saveMany($products);
        }
        catch(\exception $e){
              return response()
            ->json([
                'asasa' => [$e]
            ], 422);
           
        }
     
        //Incrementa el numero de cotización
        Resolution::where('account_id', Auth::user()->account_id)
                ->where('id',$request['resolution_id'])
                ->increment('next_invoice_number');
       
       event(new RecordActivity('Create','Se creó la factura de venta número: ' 
			.$invoice->resolution_id.' para el cliente '.$invoice->contact->name,
			'InvoiceSaleOrder','/invoice/'.$invoice->public_id));	

        return response()
            ->json([
                'created' => true,
                'id' => $invoice->public_id
            ]);
    }

    public function show($id)
    {
          $invoice = InvoiceSaleOrder::with('detail','list_price','seller','payment_terms')
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
        $taxes=$this->getTotalTaxes($invoice->public_id);
        $paymentHistorical=$this->getPaymentHistorical($invoice->public_id);

        return view('invoice.show', compact('invoice','taxes','paymentHistorical'));
    }

    public function edit($id)
    {
        
        $invoice = InvoiceSaleOrder::with(['detail','contact','list_price','currency','seller','payment_terms'])
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
            $PublicId = Helper::PublicId(InvoiceSaleOrder::class);
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
            'payment_terms_id' => 'required',
            'resolution_number'   =>'required_if:ResolutionIsAutoNumeric,false',         
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',    
        ]);
       
        $invoice = InvoiceSaleOrder::findOrFail($id);

        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100); 
            return new InvoiceSaleOrderDetail($detail);
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
       
        InvoiceSaleOrderDetail::where('invoice_sale_order_id', $invoice->id)->delete();
        $invoice->detail()->saveMany($products);

        event(new RecordActivity('Update','Se actualizó la factura de venta número: ' 
			.$invoice->resolution_id.' para el cliente '.$invoice->contact->name,
			'InvoiceSaleOrder','/invoice/'.$invoice->public_id));	

        return response()
            ->json([
                'updated' => true,
                'id' => $invoice->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $invoice = InvoiceSaleOrder::GetByPublicId(0,$id)
                ->firstOrFail();   
            
            $invoice['isDeleted']=1;
            $invoice['deleted_at']=$now = Carbon::now();
            $invoice->save();
            
            event(new RecordActivity('Delete','Se eliminó la factura de venta número: ' 
			.$invoice->resolution_id,
			'InvoiceSaleOrder',null));	

            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function pdf($id, Request $request)
    {
        Carbon::setLocale('es');

         $invoice = InvoiceSaleOrder::with('account','detail','list_price','seller')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
  
        $invoice=Helper::_InvoiceFormatter($invoice);
        
        $mypdf = PDF::loadView('pdf.invoice', ['invoice' => $invoice,'taxes' => $this->getTotalTaxes($invoice->public_id)]);
        $filename = "InvoiceSaleOrder_"."{$invoice->public_id}.pdf";

         if($request->get('opt') === 'download') {
            return $pdf->download($filename);            
        }
        
        event(new RecordActivity('Print','Se ha impreso el pdf de la factura de venta No: ' 
			.$invoice->resolution_id,
			'InvoiceSaleOrder','/invoice/'.$invoice->public_id));	

        return $mypdf->stream();
    }
    
    public function update_state(Request $request,$id)
    {
        
            $data = $request->all(); 
            $data['status_id']= (int)$data['status_id'];             

            $item = InvoiceSaleOrder::findOrFail($id);
              
            $item->update($data);

            event(new RecordActivity('Update','Se actualizó el estado de la factura de venta número: ' 
			.$item->resolution_id.' para el cliente '.$item->contact->name,
			'InvoiceSaleOrder','/invoice/'.$item->public_id));	

            return response()
            ->json([
                'updated' => true                           
            ]);
    }

    public static function getTotalTaxes($invoice_id)
    {
        $taxes=
        DB::table('invoice_sale_order')
            ->join('invoice_sale_order_detail', 'invoice_sale_order.id', '=', 'invoice_sale_order_detail.invoice_sale_order_id')
             ->join('tax', 'invoice_sale_order_detail.tax_id', '=', 'tax.id')
            ->where('invoice_sale_order.account_id',Auth::user()->account_id) 
             ->where('invoice_sale_order.public_id',$invoice_id)  
              ->where('invoice_sale_order_detail.tax_amount','>',0)             
            ->select(DB::raw("CONCAT(tax.name,' (',invoice_sale_order_detail.tax_amount,'%)') AS name"), 
            DB::raw('SUM(invoice_sale_order_detail.total_tax) as total'))
            ->groupBy('tax.name','invoice_sale_order_detail.tax_amount')
            ->get();

            return  Helper::_taxesFormatter($taxes);
    }

     public static function getPaymentHistorical($public_id)
    {
        $payment_historical=
            DB::table('invoice_sale_order')            
            ->Join('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
            ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
            ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
            ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')
             ->where('invoice_sale_order.public_id',$public_id)   
            ->where('invoice_sale_order.account_id',Auth::user()->account_id)
              ->where('invoice_sale_order.isDeleted',0)   
              ->where('payment.isDeleted',0)  
            ->select('payment.date','payment.resolution_id','payment.status_id', 'payment_status.description as status','payment_method.name as payment_method', 
                 DB::raw('SUM(payment_history.amount) as total_payed'),'payment.observations','payment.public_id'
                 )
            ->groupBy('payment.date','payment.resolution_id', 'payment_status.description','payment_method.name', 
               'payment.observations','payment.public_id','payment.status_id')
            ->orderby('invoice_sale_order.resolution_id','desc')
            ->get();

            foreach($payment_historical as $item) 
            {  
                $item->total_payed=Helper::formatMoney($item->total_payed);            
                $item->date= Helper::setCustomDateFormat(Carbon::parse( $item->date));
            }

            return  $payment_historical;
    }
}
