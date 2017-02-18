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
        $payment =  DB::table('invoice_sale_order')            
            ->Join('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
            ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
            ->Join('contact', 'contact.id', '=', 'payment.customer_id')
            ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
            ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')  
            ->where('payment.isDeleted',0)  
             ->where('invoice_sale_order.isDeleted',0)  
            ->where('invoice_sale_order.account_id',Auth::user()->account_id)
            ->select('payment.date','payment.resolution_id','payment.status_id',
            'payment_method.name as payment_method', 'contact.name as contact','contact.id',
                 DB::raw('SUM(payment_history.amount) as total'),'payment.observations','payment.public_id'
                 )
            ->groupBy('payment.date','payment.resolution_id','payment_method.name','contact.name', 
               'payment.observations','payment.public_id','payment.status_id','contact.id')
            ->orderby('invoice_sale_order.resolution_id','desc')
            ->get();


         return response()->json($payment);
    }

    public function getInvoicePendingtoPay_data($customer_id)
    {
       

           $PendingByPayment=   DB::table('invoice_sale_order')
            ->leftJoin('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
            ->where('invoice_sale_order.account_id',Auth::user()->account_id) 
             ->where('invoice_sale_order.customer_id',$customer_id)  
              ->where('invoice_sale_order.isDeleted',0)           
            ->select('invoice_sale_order.id','invoice_sale_order.resolution_id', 'payment_history.invoice_sale_order_id',
            'invoice_sale_order.total','invoice_sale_order.public_id','invoice_sale_order.total as total2',
            DB::raw('SUM(payment_history.amount) as total_payed'),DB::raw('"" as total_pending_by_payment'),DB::raw('"" as total_pending_by_payment2'))
            ->groupBy('invoice_sale_order.id','invoice_sale_order.resolution_id', 'payment_history.invoice_sale_order_id',
            'invoice_sale_order.public_id','total','total_pending_by_payment')
            ->orderby('invoice_sale_order.resolution_id','desc')
            ->get();

        foreach($PendingByPayment as $item) 
        {  
            $item->total_pending_by_payment2=  $item->total - $item->total_payed;     
            $item->total_pending_by_payment=Helper::formatMoney($item->total - $item->total_payed);   
            $item->total_payed=Helper::formatMoney($item->total_payed);
            $item->total=Helper::formatMoney($item->total);
        }
        
       
        $PendingByPayment = $PendingByPayment->filter(function ($item) {
            return $item->total_pending_by_payment2>0;
        })->values();

        $dataToReturn=['PendingByPayment'=> $PendingByPayment,
                        'crediNote'=>'0'];

        return response()->json($dataToReturn); 

    }

     public function getInvoicePendingtoPay_data_edit($customer_id)
    {
       

           $PendingByPayment=   DB::table('invoice_sale_order')
            ->leftJoin('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
            ->where('invoice_sale_order.account_id',Auth::user()->account_id) 
             ->where('invoice_sale_order.customer_id',$customer_id)  
              ->where('invoice_sale_order.isDeleted',0)           
            ->select('invoice_sale_order.id','invoice_sale_order.resolution_id', 'payment_history.invoice_sale_order_id',
            'invoice_sale_order.total','invoice_sale_order.public_id','invoice_sale_order.total as total2',
            DB::raw('SUM(payment_history.amount) as total_payed'),DB::raw('"" as total_pending_by_payment'),DB::raw('"" as total_pending_by_payment2'))
            ->groupBy('invoice_sale_order.id','invoice_sale_order.resolution_id', 'payment_history.invoice_sale_order_id',
            'invoice_sale_order.public_id','total','total_pending_by_payment')
            ->orderby('invoice_sale_order.resolution_id','desc')
            ->get();

        foreach($PendingByPayment as $item) 
        {  
            $item->total_pending_by_payment2=  $item->total - $item->total_payed;     
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
        ]);

     
        $data = $request->except('contact' ,'resolution','resolution_number','payment_method','bank_account','currency');  
      

        //validar que los montos ingresados no sean mayores a los del total habilitado
        $historical = [];
         foreach($data['pending_payment_in'] as $item) {
            if(isset($item['amount_receipt'])) {
                if ($item['amount_receipt']>$item['total_pending_by_payment2'])
                {
                     return response()
                        ->json([
                            'amount_error' =>  ['revise los valores ingresados']
                        ], 422);
                }
            }
         }

       
         if(!$data['pending_payment_in']) {
            return response()
            ->json([
                'payment_empty' => ['seleccione un cliente que tenga un pago']
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
       
        $invoice_id=null;          
         foreach($data['pending_payment_in'] as $item) {
            if(isset($item['amount_receipt'])) {
                $historical['amount']=$item['amount_receipt'];
                $historical['invoice_sale_order_id']=$item['id'];
                $invoice_id=$item['id'];
                $historical['account_id']=Auth::user()->account_id;
                $historical['user_id']=Auth::user()->id;
                $historical['payment_id']=$payment->id;
              
                if($historical['amount']>0)
                {
                    PaymentHistory::create($historical);
                }
            }
        }
        
        //cuando una factura tiene un pao asociado, esta debe pasar a estado cerrado
        $this->update_invoice_status($invoice_id,6);

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
          $payment = Payment::with('contact','payment_method','bank_account')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();    

        if (!$payment)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de pago creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/payment')->with($notification);
        }
       
        $detail=$this->getPaymentDetail($payment->customer_id);

         $total=Helper::formatMoney(PaymentHistory::where('payment_id',$payment->id)->sum('amount'));

        return view('payment.show', compact('payment','detail','total'));
    }

    public function edit($id)
    {
        
       $payment = Payment::with('contact','payment_method','bank_account')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();  

         if (!$payment)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/payment')->with($notification);
        }
        $payment['date']= Helper::setCustomDateFormat(Carbon::parse($payment['date']));
        
        $detail=$this->getPaymentDetail($payment->customer_id);

        return view('payment.edit', compact('payment','detail'));
    }

    
    public function update(Request $request, $id)
    {        
              
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',
            'payment_method_id' => 'required',
            'bank_account_id' => 'required',                 
        ]);
       
        $payment = Payment::findOrFail($id);
        
        $data = $request->except('contact' ,'resolution','resolution_number','payment_method','bank_account','currency');  
        $data['user_id'] = Auth::user()->id;  
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $payment->update($data);
      
         foreach($data['pending_payment_in'] as $item) {
            if(isset($item['amount_receipt'])) {
                if($item['amount_receipt']>0)
                {
                     PaymentHistory::where('payment_id', $payment->id)        
                         ->update(
                             [
                                'account_id' =>Auth::user()->account_id,                                
                                'user_id' => Auth::user()->id,
                                'invoice_sale_order_id' =>$item['id'],
                                 'amount' =>$item['amount_receipt'],
                             ]);
                }
            }
        }

      
       event(new RecordActivity('Update','Se actualizó el pago número: ' 
			.$payment->resolution_id.' para el cliente '.$payment->contact->name,
			'Payment','/payment/'.$payment->public_id));	

        return response()
            ->json([
                'updated' => true,
                'id' => $payment->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $payment = Payment::GetByPublicId(0,$id)
                ->firstOrFail();   
            

            $payment['isDeleted']=1;
            $payment['deleted_at']=$now = Carbon::now();
            $payment->save();
            
            event(new RecordActivity('Delete','Se eliminó el pago número: ' 
			.$payment->resolution_id,
			'Payment',null));	

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
    
    public static function update_invoice_status($invoice_id, $status_id)
    {
        InvoiceSaleOrder::where('id', $invoice_id)        
          ->update(['status_id' => $status_id]);
    }
   

    public static function getPaymentDetail($customer_id)
    {
        //se llama desde la funcion view
        $payment_historical=
       DB::table('invoice_sale_order')            
            ->Join('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
            ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
            ->where('invoice_sale_order.account_id',Auth::user()->account_id)
              ->where('invoice_sale_order.isDeleted',0) 
              ->where('payment.isDeleted',0)    
              ->where('payment.customer_id',$customer_id)          
            ->select('invoice_sale_order.id','invoice_sale_order.resolution_id', 'payment_history.invoice_sale_order_id',
            'invoice_sale_order.total','invoice_sale_order.public_id','invoice_sale_order.total as total2',
            'invoice_sale_order.date','invoice_sale_order.due_date',
            DB::raw('SUM(payment_history.amount) as total_payed'),DB::raw('"" as total_pending_by_payment'))
            ->groupBy('invoice_sale_order.id','invoice_sale_order.resolution_id', 'payment_history.invoice_sale_order_id',
            'invoice_sale_order.public_id','total','total_pending_by_payment','invoice_sale_order.date','invoice_sale_order.due_date')
            ->orderby('invoice_sale_order.resolution_id','desc')
            ->get();

            foreach($payment_historical as $item) 
            {  
                $item->total_pending_by_payment2=  $item->total - $item->total_payed;     
                $item->total_pending_by_payment=Helper::formatMoney($item->total - $item->total_payed);   
                $item->total_payed=Helper::formatMoney($item->total_payed);
                $item->total=Helper::formatMoney($item->total);
                $item->date= Helper::setCustomDateFormat(Carbon::parse( $item->date));
                 $item->due_date= Helper::setCustomDateFormat(Carbon::parse( $item->due_date));
            }

            return  $payment_historical;
    }
}
