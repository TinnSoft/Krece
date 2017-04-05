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
use App\Repositories\PaymentRepository;
use App\Contracts\IEmailRepository;
use App\Contracts\IPdfRepository;

class PaymentIn_Controller extends Controller
{
    protected $paymentRepo;
    
    protected $emailRepo;
    
    protected $iPdfRepo;
    
    public function __construct(PaymentRepository $paymentRepo, IEmailRepository $emailRepo, IPdfRepository $iPdfRepo)
    {
        $this->paymentRepo = $paymentRepo;
        $this->emailRepo = $emailRepo;
        $this->iPdfRepo = $iPdfRepo;
    }
    
    public function index()
    {
        //dd($this->paymentRepo->amountPendingToPay('invoice_sale_order',105));
        return view(PAYMENT_LOCAL_VIEW_IN.'.index');
    }
    
    public function getPaymentList()
    {
        return $this->paymentRepo->ListOfPayments('invoice_sale_order',PAYMENT_INCOME_TYPE);
    }
    
    public function getInvoicePendingtoPay_data($customer_id)
    {
        
        $dataToReturn=['PendingByPayment'=> $this->paymentRepo->ListOfPendingsToPay('invoice_sale_order',$customer_id),
        'debitNote'=>'0'];
        
        return response()->json($dataToReturn);
        
    }
    
    public function getInvoicePendingtoPay_data_edit($customer_id)
    {
        $dataToReturn=['PendingByPayment'=> $this->paymentRepo->ListOfPendingsToPay_edit('invoice_sale_order',$customer_id),
        'debitNote'=>'0'];
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
        return view(PAYMENT_LOCAL_VIEW_IN.'.create');
    }
    
    
    public function store(Request $request)
    {
        $this->validate($request, [
        //'customer_id' => 'required',
        'date' => 'required',
        'payment_method_id' => 'required',
        'bank_account_id' => 'required',
        ]);
        
        
        $data = $request->except('contact' ,'resolution','resolution_number','payment_method','bank_account','currency');
        
        if($data['isInvoice']==null)
        {
            return response()
            ->json([
            'transaction_error' => ['Seleccione un transacción válida']
            ], 422);
        };
        
        
        //Pago asociado a una factura
        if(isset($data['pending_payment_in']))
        {
            $detailPayment=$data['pending_payment_in'];
            
            $payment=$this->paymentRepo->storePaymentByInvoice(
            $data,
            $detailPayment,
            Payment::class,
            PaymentHistory::class,
            PAYMENT_INCOME_TYPE,
            InvoiceSaleOrder::class,
            INVOICE_STATUS_CLOSE
            );
            
        }
        else if(isset($data['payment_in_to_category']))  //Pago asignado a una categoría
        {
            $detailPayment=$data['payment_in_to_category'];
            
            $payment=$this->paymentRepo->storeCategoryPayment(
            $data,
            $detailPayment,
            Payment::class,
            PAYMENT_INCOME_TYPE
            );
            
        }
        else{
            return response()
            ->json([
            'created' => false
            ]);
        }
        
        if($payment) //retornar errores por validación
        {
            $hasErrorr=collect($payment)->get('original');
            if ($hasErrorr)
            {
                return $payment; //este objeto contiene errores que se muestran al cliente
            }
        }
        
        //Incrementa el numero de resolución
        ResolutionNumber::where('key', 'in-come')
        ->increment('number');
        
        event(new RecordActivity('Create','Se ha creado el ingreso número: '
        .$payment->resolution_id.' para el cliente '.$payment->contact->name,
        'Payment',PAYMENT_LOCAL_VIEW_EVENT_IN.$payment->public_id));
        
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
            return redirect(PAYMENT_LOCAL_VIEW_EVENT_IN)->with($notification);
        }
        $isCategory=false;
       
        $detail=$this->paymentRepo->PaymentHistoryById('invoice_sale_order',$payment->id);
    
        
        $total=Helper::formatMoney(PaymentHistory::where('payment_id',$payment->id)->sum('amount'));
        
        if ($detail->isEmpty())
        {
            $detail=$this->paymentRepo->ListOfCategoriesByPayment($payment->id);
            if (! $detail->isEmpty())
            {
                $total=Helper::formatMoney($detail->sum('total_with_taxes'));
                foreach($detail as $item)
                {
                    $item->unit_price=Helper::formatMoney($item->unit_price);
                    $item->total=Helper::formatMoney($item->total);
                }
                $isCategory=true;
                
            }
        }
        
        return view(PAYMENT_LOCAL_VIEW_IN.'.show', compact('payment','detail','total','total','isCategory'));
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
            return redirect(PAYMENT_LOCAL_VIEW_EVENT_IN)->with($notification);
        }
        
        
        $payment['date']= Helper::setCustomDateFormat(Carbon::parse($payment['date']));
        $isCategory=false;
        $detail=$this->paymentRepo->PaymentHistoryById('invoice_sale_order',$payment->id);
        $categoryList=collect([]);
        if ($detail->isEmpty())
        {
            $categoryList=$this->paymentRepo->ListOfCategoriesByPayment($payment->id);   ;
            if (! $categoryList->isEmpty())
            {
                $isCategory=true;
            }
        }
        return view(PAYMENT_LOCAL_VIEW_IN.'.edit', compact('payment','detail','isCategory','categoryList'));
    }
    
    
    public function update(Request $request, $id)
    {
        
        $this->validate($request, [
        //'customer_id' => 'required',
        'date' => 'required',
        'payment_method_id' => 'required',
        'bank_account_id' => 'required',
        ]);
        
        $payment = Payment::findOrFail($id);
        
        $data = $request->except('contact' ,'resolution','resolution_number','payment_method','bank_account','currency');
        $data['user_id'] = Auth::user()->id;
        $data['date']=Helper::dateFormatter($data['date']);
        
        $payment->update($data);
        
        
        
        if(isset($data['pending_payment_in'])) {
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
        }
        
        
        
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
        return $this->paymentRepo->destroy($id,Payment::class);
        
    }
    
    public function pdf($id, Request $request)
    {
        
        $mypdf=$this->iPdfRepo->create(Payment::class, $id);
        
        $filename = PAYMENT_LOCAL_VIEW_IN."_"."{$id}.pdf";
        
        if($request->get('opt') === 'download') {
            return $mypdf->download($filename);
        }
        
        event(new RecordActivity('Print','Se ha impreso el pdf para el comprobante de ingreso No: '
        .$id,'Payment-out',PAYMENT_LOCAL_VIEW_EVENT_IN.$id));
        
        return $mypdf->stream();
    }
    
    public static function update_invoice_status($invoice_id, $status_id)
    {
        InvoiceSaleOrder::where('id', $invoice_id)
        ->update(['status_id' => $status_id]);
    }
    
    public static function getTotalTaxes($payment_id)
    {
        return  $this->paymentRepo->getTotalTaxesOfCategoryByPayment($payment_id);
    }
    
    
    public function getBaseInfoToCategorySection(){
        $baseInfo = [
        'category' => Helper::category_all(),
        'taxes'=>Helper::taxes(),
        ];
        
        return response()->json($baseInfo);
    }
    
    
    
    public function update_state(Request $request,$id)
    {
        return  $this->paymentRepo->UpdatePaymentState($request->all(),
        $id,Payment::class,PAYMENT_LOCAL_VIEW_EVENT_IN);
    }
    
    public function getTemplateEmailToCustomer($id)
    {
        return $this->emailRepo->TemplateEmailToCustomer(Payment::class,$id);
    }
    
    
}