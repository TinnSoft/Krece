<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    InvoiceSaleOrder,
    Payment,
    Tax,
    ResolutionNumber,
    Resolution,
    Category,
    PaymentMethod,
    PaymentHistory,
    CategoryPayment
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use Illuminate\Support\Facades\DB;

class PaymentIn_Controller extends Controller
{
    
    public function index()
    {
        return view('payment-in.index');
    }
    
    public function getPaymentList()
    {
         $categoryPayment=DB::table('payment')
        ->Join('category_payment', 'payment.id', '=', 'category_payment.payment_id')
        ->Join('contact', 'contact.id', '=', 'payment.customer_id')
        ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
        ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')
        ->where('payment.isDeleted',0)
        ->where('payment.type_id','=','in')
        ->where('category_payment.account_id',Auth::user()->account_id)
        ->select('payment.id as payment_id',
        'payment.date',
        'payment.resolution_id',
        'payment.status_id',
        'payment_method.name as payment_method', 
        'contact.name as contact',
        'contact.id as contact_id',
        DB::raw('SUM((category_payment.unit_price * category_payment.quantity)+IFNULL(category_payment.tax_total,0)) as total'),
        'payment.observations','payment.public_id',
        DB::raw('1 as IsCategory')
        )
        ->groupBy('payment.id','payment.date','payment.resolution_id','payment_method.name','contact.name',
        'payment.observations','payment.public_id','payment.status_id','contact.id')
        ->orderby('payment.id','desc');

       $payment =  DB::table('invoice_sale_order')
        ->Join('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
        ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
        ->Join('contact', 'contact.id', '=', 'payment.customer_id')
        ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
        ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')
        ->where('payment.isDeleted',0)
        ->where('invoice_sale_order.isDeleted',0)
        ->where('payment.type_id','=','in')
        ->where('invoice_sale_order.account_id',Auth::user()->account_id)
        ->select('payment.id as payment_id',
        'payment.date',
        'payment.resolution_id',
        'payment.status_id',
        'payment_method.name as payment_method', 
        'contact.name as contact',
        'contact.id',
        DB::raw('SUM(payment_history.amount) as total'),
        'payment.observations',
        'payment.public_id',
        DB::raw('0 as IsCategory')
        )
        ->groupBy('payment.id',
        'payment.date',
        'payment.resolution_id',
        'payment_method.name',
        'contact.name',
        'payment.observations',
        'payment.public_id',
        'payment.status_id',
        'contact.id')
        ->orderby('invoice_sale_order.id','desc')
        ->union($categoryPayment)
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
        return view('payment-in.create');
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
        $PaymentCounter=0;
        //Determina el tipo de proceso,
        //1. si el array payment_in_to_category se encuentra, entonces es una operación de asociación a una factura existente
        //2. Si se encuentra el array payment_in_to_category, entonces es una operación de asociación de pagos a categorias
         $isCategory=false;
        if(isset($data['payment_in_to_category'])) {
            $isCategory=false;
            $historical = [];
            foreach($data['payment_in_to_category'] as $item) {
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
        }
        
        
         //operación de categoría
        $categoryListInput=[];
        if(isset($data['payment_in_to_category'])) {
            $isCategory=true;
            foreach($data['payment_in_to_category'] as $item) {
                if ($item['unit_price']>0 && $item['category_id']>0)
                {
                    $categoryListInput[]=$item;
                    $PaymentCounter= $PaymentCounter+1;
                }
            }
        }
        
        if ( $isCategory==false)
        {
            if(!$data['payment_in_to_category']) {
                return response()
                ->json([
                'payment_empty' => ['seleccione un cliente que tenga un pago']
                ], 422);
            };
        }

        if ( $PaymentCounter==0)
        {
            return response()
            ->json([
            'amount_empty' =>  ['revise los valores ingresados']
            ], 422);
        }
        
        
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
        if ( $isCategory==false)
        {
            foreach($data['payment_in_to_category'] as $item) {
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
            //cuando una factura de compra tiene un pago asociado, esta debe pasar a estado cerrado
           $this->update_invoice_status($invoice_id,6);
        }

        if ( $isCategory==true)
        {
            if ($categoryListInput!=null)
            {
                $categoryList_save= collect($categoryListInput)->transform(function($categoryListInput) {
                    $baseprice=$categoryListInput['quantity'] * $categoryListInput['unit_price'];
                    $taxTotal=null;
                    if(isset($categoryListInput['tax_amount'])) {
                        if($categoryListInput['tax_amount']>0)
                        {
                            $taxTotal=($baseprice * $categoryListInput['tax_amount'])/100;
                        };
                    };
                    
                    $categoryListInput['total'] = $baseprice;
                    $categoryListInput['account_id']=Auth::user()->account_id;
                    $categoryListInput['user_id']=Auth::user()->id;
                    $categoryListInput['tax_total']=$taxTotal;
                    $categoryListInput['payment_id']=0;
                    
                    return new CategoryPayment($categoryListInput);
                });
                foreach($categoryList_save as $item) {
                    $item['payment_id']=$payment->id;
                }
                
                $payment->category_payment()->saveMany($categoryList_save);
            }
        }

        //Incrementa el numero de resolución
        ResolutionNumber::where('key', 'in-come')
        ->increment('number');
        
        event(new RecordActivity('Create','Se ingresó el ingreso número: '
        .$payment->resolution_id.' para el cliente '.$payment->contact->name,
        'Payment','/payment-in/'.$payment->public_id));
        
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
            return redirect('/payment/in')->with($notification);
        }
        $isCategory=false;
        $detail=$this->getPaymentDetail($payment->id);        
        $total=Helper::formatMoney(PaymentHistory::where('payment_id',$payment->id)->sum('amount'));
      
         if ($detail->isEmpty())
        {
            $detail=$this->getCategoryPayment($payment->id);
            if (! $detail->isEmpty())
            {
                foreach($detail as $item)
                {
                    $item->unit_price=Helper::formatMoney($item->unit_price);
                    $item->total=Helper::formatMoney($item->total);
                }
                $isCategory=true;
                $total=Helper::formatMoney($detail->sum('total'));
            }
        }

        return view('payment-in.show', compact('payment','detail','total','total','isCategory'));
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
            return redirect('/payment-in')->with($notification);
        }
        $payment['date']= Helper::setCustomDateFormat(Carbon::parse($payment['date']));
        $isCategory=false;
        $detail=$this->getPaymentDetail($payment->id);
         $categoryList=collect([]);
        if ($detail->isEmpty())
        {
            $categoryList=$this->getCategoryPayment($payment->id);
            if (! $categoryList->isEmpty())
            {
                $isCategory=true;
            }            
        }
        return view('payment-in.edit', compact('payment','detail','isCategory','categoryList'));
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
        
          

        if(isset($data['payment_in_to_category'])) {
            foreach($data['payment_in_to_category'] as $item) {
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
        }
        
         $categoryListInput=[];
        if(isset($data['payment_in_to_category'])) {
            
            foreach($data['payment_in_to_category'] as $item) {
                if ($item['unit_price']>0 && $item['category_id']>0)
                {
                    $categoryListInput[]=$item;
                }
            }
            
            
            if ($categoryListInput!=null)
            {
                $categoryList_save= collect($categoryListInput)->transform(function($categoryListInput) {
                    $baseprice=$categoryListInput['quantity'] * $categoryListInput['unit_price'];
                    $taxTotal=null;
                    if(isset($categoryListInput['tax_amount'])) {
                        if($categoryListInput['tax_amount']>0)
                        {
                            $taxTotal=($baseprice * $categoryListInput['tax_amount'])/100;
                        };
                    };
                    
                    $categoryListInput['total'] = $baseprice;
                    $categoryListInput['account_id']=Auth::user()->account_id;
                    $categoryListInput['user_id']=Auth::user()->id;
                    $categoryListInput['tax_total']=$taxTotal;
                    $categoryListInput['payment_id']=0;
                    
                    return new CategoryPayment($categoryListInput);
                });
                foreach($categoryList_save as $item) {
                    $item['payment_id']=$payment->id;
                }
                
                CategoryPayment::where('payment_id', $payment->id)->delete();
                $payment->category_payment()->saveMany($categoryList_save);
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
        $payment = Payment::with('contact','payment_method','bank_account')
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();
        
        $subtotal=0;
        $total=0;
        $taxes=[];
        $isCategory=false;
        $detail=[];

        //1. buscar si tiene pagos asociados por factura
        $payment_detail=$this->getPaymentDetail($payment->id);
       
        foreach($payment_detail as $item)
        {
            $detail = collect([
            ['total' => Helper::formatMoney( ($item ->total_pending_by_payment2)),
            'total2' =>  ($item ->total_pending_by_payment2),
            'quantity' => 1,
            'concept'=>'Pago a factura de proveedor']
            ]);
        }
        
        if(!collect($detail)->isEmpty())
        {
            $total=Helper::formatMoney($detail->sum('total2'));
        }
        
        $subtotal=$total;
       
        //2. Si no tiene pagos asociados por factura entonces buscar si tiene pagos a categorias
        if ($payment_detail->isEmpty())
        {
            $payment_detail=$this->getCategoryPayment($payment->id);
            if (! $payment_detail->isEmpty())
            {
                $taxes=$this->getTotalTaxes($payment->id);
                $subtotal=Helper::formatMoney($payment_detail->sum('total'));
                $isCategory=true;
                $total=Helper::formatMoney($payment_detail->sum('total') + $payment_detail->sum('tax_total'));
                
                foreach($payment_detail as $item)
                {
                    //$item->unit_price=Helper::formatMoney($item->unit_price);
                    //$item->total=Helper::formatMoney($item->total);
                    $detail[] =collect( 
                    ['total' => Helper::formatMoney($item->total)
                    , 'quantity' =>  $item->quantity,
                    'concept'=> $item->category->name
                    ]);
                }
                $detail = collect($detail);
                          
            }
        }
        
        $mypdf = PDF::loadView('pdf.payment-out', ['payment' => $payment,
        'detail' => $detail,
        'taxes' => $taxes,
        'isCategory'=>$isCategory,
        'total'=>$total,
        'subtotal'=>$subtotal
        ]);
        
        $filename = "Payment-out_"."{$payment->public_id}.pdf";
        
        if($request->get('opt') === 'download') {
            return $pdf->download($filename);
        }
        
        event(new RecordActivity('Print','Se ha impreso el pdf para el comprobante de egreso No: '
        .$payment->resolution_id,
        'Payment-out','/Payment-out/'.$payment->public_id));
        
        return $mypdf->stream();
    }
    
    public static function update_invoice_status($invoice_id, $status_id)
    {
        InvoiceSaleOrder::where('id', $invoice_id)
        ->update(['status_id' => $status_id]);
    }
    
    
    public static function getPaymentDetail($payment_id)
    {
        //se llama desde la funcion view
        $payment_historical=
        DB::table('invoice_sale_order')
        ->Join('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
        ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
        ->where('invoice_sale_order.account_id',Auth::user()->account_id)
        ->where('invoice_sale_order.isDeleted',0)
        ->where('payment.isDeleted',0)
        ->where('payment.id',$payment_id)
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

     public function getBaseInfoToCategorySection(){
        $baseInfo = [
        'category' => Helper::category_outcome(),
        'taxes'=>Helper::taxes(),
        ];
        
        return response()->json($baseInfo);
    }

      public static function getCategoryPayment($payment_id)
    {
        $categoryPayment=CategoryPayment::with('category','taxes')
        ->select('id','payment_id','category_id','unit_price','tax_id',DB::raw('IFNULL(tax_amount,0) as tax_amount'),
        DB::raw('IFNULL(tax_total,0) as tax_total'), 'quantity','observations',
        DB::raw('SUM(unit_price * quantity) as total'))
        ->where('account_id',Auth::user()->account_id)
        ->where('payment_id',$payment_id)
        ->groupBy('id','payment_id','category_id','unit_price','tax_id','tax_total','tax_amount',
        'quantity','observations','tax_total')
        ->get();
        
        return  $categoryPayment;
        
    }

      public static function update_state(Request $request,$id)
    {
        
        $data = $request->all();
        $data['status_id']= (int)$data['status_id'];
        
        $item = Payment::findOrFail($id);
        
        $item->update($data);
        
        event(new RecordActivity('Update','Se actualizó el estado del pago número: '
        .$item->resolution_id.' para el cliente '.$item->contact->name,
        'Payment-in','/Payment-in/'.$item->public_id));
        
        return response()
        ->json([
        'updated' => true
        ]);
    }
}