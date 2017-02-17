<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    InvoiceSaleOrderDetail,
    InvoiceSaleOrder,
    Payment,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber,
    Resolution,
    Category,
    PaymentMethod,
    PaymentHistory
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use Illuminate\Support\Facades\DB;

class PaymentController extends Controller
{

    public function index()
    {
        return view('payment.index');  
    }

    public function getPaymentList()
    {
        //Obtener las cotizaciones creadas hasta la fecha       
        $invoice = Payment::with('contact')
               ->GetAll(0)
               ->orderBy('created_at', 'desc')
                ->GetSelectedFields()
               ->get();

         return response()->json($invoice);
    }

    public function getInvoicePendingtoPay_data($customer_id)
    {
       

           $PendingByPayment=   DB::table('invoice_sale_order')
            ->leftJoin('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
            ->where('invoice_sale_order.account_id',Auth::user()->account_id) 
             ->where('invoice_sale_order.customer_id',$customer_id)  
              ->where('invoice_sale_order.isDeleted',0)           
            ->select('invoice_sale_order.id','invoice_sale_order.resolution_id',
            'invoice_sale_order.total','invoice_sale_order.public_id','invoice_sale_order.total as total2',
            DB::raw('SUM(payment_history.amount) as total_payed'),DB::raw('"" as total_pending_by_payment'))
            ->groupBy('invoice_sale_order.id','invoice_sale_order.resolution_id',
            'invoice_sale_order.public_id','total','payment_history.amount')
            ->orderby('invoice_sale_order.resolution_id','desc')
            ->get();

        foreach($PendingByPayment as $item) 
        {      
            $item->total_pending_by_payment=Helper::formatMoney($item->total - $item->total_payed);   
            $item->total_payed=Helper::formatMoney($item->total_payed);
            $item->total=Helper::formatMoney($item->total);
            
        }

        $dataToReturn=['PendingByPayment'=> $PendingByPayment,
                        'crediNote'=>'0'];

        return response()->json($dataToReturn); 

    }
    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
        $paymentmethod=PaymentMethod::select('id','name')->where('isActive',1)->get();
        $baseInfo=[
                'public_id' =>Helper::PublicId(Payment::class),
                'contacts' => Helper::contacts(),
               'currency'=>Helper::currencylist(),
               'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'in-come'), 
               'paymentmethod'=> $paymentmethod,
               'bank'=>Helper::bank_account()
            ];

     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('payment.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',
            'payment_method_id' => 'required',
            'bank_account_id' => 'required',     
            //'pending_payment_in.*.amount_receipt' => 'max:total2'
        ]);

       
        $data = $request->except('contact' ,'resolution','resolution_number','payment_method','bank_account');  
        
       
         if(!$data['pending_payment_in']) {
            return response()
            ->json([
                'payment_empty' => ['']
            ], 422);
        };
      
 
        $data['public_id'] = Helper::PublicId(Payment::class);     
        $data['resolution_id'] = (int)$data['resolution_id'];     
        $data['isInvoice'] = (int)$data['isInvoice'];       
        $data['status_id'] = 1;     
        $data['type_id'] = 'in';    
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
         if (!$data['currency_code'])
        {
            $data['currency_code']="COP";
        }
        
        $payment = Payment::create($data);
     
         $historical = [];
         $items=[];
         foreach($data['pending_payment_in'] as $item) {
            if(isset($item['id'])) {
                $historical['amount']=$item['total2'];
                $historical['invoice_sale_order_id']=$item['id'];
                $historical['account_id']=Auth::user()->account_id;
                $historical['user_id']=Auth::user()->id;
                PaymentHistory::create($historical);
                $items[]= new PaymentHistory($historical);

            }
        }
   
           
        //$paymenthistory = PaymentHistory::create($items);

     

     
        //Incrementa el numero de resolución
       ResolutionNumber::where('key', 'in-come')
                ->increment('number');
       
       event(new RecordActivity('Create','Se creó el pago número: ' 
			.$payment->resolution_id.' para el cliente '.$payment->contact->name,
			'Payment','/payment/'.$payment->public_id));	

        return response()
            ->json([
                'created' => true,
                'id' => $payment->public_id
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

        return view('invoice.show', compact('invoice','taxes'));
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
}
