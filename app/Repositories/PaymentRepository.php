<?php
//SOLID 
namespace App\Repositories;
use Auth;
use Illuminate\Support\Facades\DB;
use App\Utilities\Helper;
use App\Events\RecordActivity;
use Carbon\Carbon;
use App\Models\CategoryPayment;

class PaymentRepository
{
  
    //Retorna el listado de pagos asociados al proceso de bill o invoice
    //El filtro dinámico se realiza por tipo de pago (in-eg) y la tabl que puede ser bill o invoice
     public function ListOfPayments($sourceTable, $pyment_type)
    {
        $categoryPayment=DB::table('payment')
        ->Join('category_payment', 'payment.id', '=', 'category_payment.payment_id')
        ->Join('contact', 'contact.id', '=', 'payment.customer_id')
        ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
        ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')
        ->where('payment.isDeleted',0)
        ->where('payment.type_id','=',$pyment_type)
        ->where('category_payment.account_id',Auth::user()->account_id)
        ->select('payment.id as payment_id',
        'payment.date',
        'payment.resolution_id',
        'payment.status_id',
        'payment_method.name as payment_method', 
        'contact.name as contact',
        'contact.id as contact_id',
        DB::raw('SUM((category_payment.unit_price * category_payment.quantity)+IFNULL(category_payment.tax_total,0)) as total'),
        'payment.observations',
        'payment.public_id',
        DB::raw('1 as IsCategory')
        )
        ->groupBy('payment.id','payment.date','payment.resolution_id','payment_method.name','contact.name',
        'payment.observations','payment.public_id','payment.status_id','contact.id')
        ->orderby('payment.id','desc');
        
       
        
        $payment =  DB::table($sourceTable)
        ->Join('payment_history', $sourceTable.'.id', '=', 'payment_history.'.$sourceTable.'_id')
        ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
        ->Join('contact', 'contact.id', '=', 'payment.customer_id')
        ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
        ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')
        ->where('payment.isDeleted',0)
        ->where($sourceTable.'.isDeleted',0)
        ->where('payment.type_id','=',$pyment_type)
        ->where($sourceTable.'.account_id',Auth::user()->account_id)
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
        ->orderby($sourceTable.'.resolution_id','desc')
        ->union($categoryPayment)
        ->get();
        
        
        return response()->json($payment);
    }

    //retorna las facturas de venta y/o de proveedor pendientes por pagar
    //Retorna los montos pendientes por pagar
     public function ListOfPendingsToPay($sourceTable,$customer_id)
    {
        
        $PendingByPayment=   DB::table($sourceTable)
        ->leftJoin('payment_history', $sourceTable.'.id', '=', 'payment_history.'.$sourceTable.'_id')
         ->leftJoin('payment','payment.id', '=', 'payment_history.payment_id')
        ->where($sourceTable.'.account_id',Auth::user()->account_id)
        ->where($sourceTable.'.customer_id',$customer_id)
        ->where($sourceTable.'.isDeleted',0)
        ->where('payment.isDeleted',0)
        ->where($sourceTable.'.status_id',INVOICE_STATUS_OPEN) //Estado abierto
        ->select($sourceTable.'.id',$sourceTable.'.resolution_id',
            $sourceTable.'.total',
            $sourceTable.'.public_id',
            $sourceTable.'.total as total2',
            DB::raw("CASE WHEN payment.status_id='1' and payment.isDeleted=0 THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_payed"),
            DB::raw('"" as total_pending_by_payment'),DB::raw('"" as total_pending_by_payment2')            
        )
        ->groupBy($sourceTable.'.id',
            $sourceTable.'.resolution_id',
            $sourceTable.'.public_id','total',
            'total_pending_by_payment',
            'payment.status_id',
            'payment.isDeleted'
        )
        ->orderby($sourceTable.'.resolution_id','desc')
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
        
      
        return $PendingByPayment;
        
    }

    ////retorna las facturas de venta y/o de proveedor pendientes por pagar
    //filtrado por el id de contacto específico
    //retorna diferentes columnas al query anterior
    public function ListOfPendingsToPay_edit($sourceTable,$customer_id)
    {        
        
        $PendingByPayment=   DB::table($sourceTable)
        ->leftJoin('payment_history', $sourceTable.'.id', '=', 'payment_history.'.$sourceTable.'_id')
        ->leftJoin('payment','payment.id', '=', 'payment_history.payment_id')
        ->where($sourceTable.'.account_id',Auth::user()->account_id)
        ->where($sourceTable.'.customer_id',$customer_id)
        ->where($sourceTable.'.isDeleted',0)
        ->where('payment.isDeleted',0)
        ->where($sourceTable.'.status_id',INVOICE_STATUS_OPEN) //Estado abierto
        ->select($sourceTable.'.id',
            $sourceTable.'.resolution_id', 
            'payment_history.'.$sourceTable.'_id',
            $sourceTable.'.total',
            $sourceTable.'.public_id',
            $sourceTable.'.total as total2',
            DB::raw("CASE WHEN payment.status_id='1' and payment.isDeleted=0 THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_payed"),
            DB::raw('"" as total_pending_by_payment'),
            DB::raw('"" as total_pending_by_payment2'))
        ->groupBy($sourceTable.'.id',
            $sourceTable.'.resolution_id', 
            'payment_history.'.$sourceTable.'_id',
            $sourceTable.'.public_id',
            'total',
            'total_pending_by_payment',
            'payment.status_id',
            'payment.isDeleted')
        ->orderby($sourceTable.'.resolution_id','desc')
        ->get();
        
        foreach($PendingByPayment as $item)
        {
            $item->total_pending_by_payment2=  $item->total - $item->total_payed;
            $item->total_pending_by_payment=Helper::formatMoney($item->total - $item->total_payed);
            $item->total_payed=Helper::formatMoney($item->total_payed);
            $item->total=Helper::formatMoney($item->total);
        }
        
        return $PendingByPayment;
        
    }

    //softdelete de los pagos
    public function destroy($id, $model)
    {
        
        $payment = $model::GetByPublicId(0,$id)
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

    //retorna el listado de items por categorías ingresados en un pago específico
    public function ListOfCategoriesByPayment($payment_id)
    {
        return CategoryPayment::with('category','taxes')
        ->select('id',
            'payment_id',
            'category_id',
            'unit_price',
            'tax_id',
            DB::raw('IFNULL(tax_amount,0) as tax_amount'),
            DB::raw('IFNULL(tax_total,0) as tax_total'), 
            'quantity',
            'observations',
            DB::raw('SUM(unit_price * quantity) as total'))
        ->where('account_id',Auth::user()->account_id)
        ->where('payment_id',$payment_id)
        ->groupBy('id',
            'payment_id',
            'category_id',
            'unit_price',
            'tax_id',
            'tax_total',
            'tax_amount',
            'quantity',
            'observations',
            'tax_total')
        ->get();
        
    }

      public function PaymentHistoryById($sourceTable,$payment_id)
    {
        $payment_historical=
            DB::table($sourceTable)
            ->Join('payment_history', $sourceTable.'.id', '=', 'payment_history.'.$sourceTable.'_id')
            ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
            ->where($sourceTable.'.account_id',Auth::user()->account_id)
            ->where($sourceTable.'.isDeleted',0)
            ->where('payment.isDeleted',0)
            ->where('payment.id',$payment_id)
            ->select($sourceTable.'.id',
                $sourceTable.'.resolution_id', 
                'payment_history.'.$sourceTable.'_id',
                $sourceTable.'.total',
                $sourceTable.'.public_id',
                $sourceTable.'.total as total2',
                $sourceTable.'.date',
                $sourceTable.'.due_date',
                DB::raw('SUM(payment_history.amount) as total_payed'),
                DB::raw('"" as total_pending_by_payment'))
            ->groupBy($sourceTable.'.id',
                $sourceTable.'.resolution_id', 
                'payment_history.'.$sourceTable.'_id',
                $sourceTable.'.public_id',
                'total',
                'total_pending_by_payment',
                $sourceTable.'.date',
                $sourceTable.'.due_date')
            ->orderby($sourceTable.'.resolution_id','desc')
            ->get();
        
        foreach($payment_historical as $item)
        {
            $item->total_pending_by_payment2=  $item->total - $item->total_payed;
            $item->total_pending_by_payment=Helper::formatMoney($item->total - $item->total_payed);
            //$item->total_payed=Helper::formatMoney($item->total_payed);
             $item->total_payed=$item->total_payed;
            $item->total=Helper::formatMoney($item->total);
            $item->date= Helper::setCustomDateFormat(Carbon::parse( $item->date));
            $item->due_date= Helper::setCustomDateFormat(Carbon::parse( $item->due_date));
        }
        
        return  $payment_historical;
    }

    //retorna los impuestos totales para la seccion de categorías
    public function getTotalTaxesOfCategoryByPayment($payment_id)
    {
        $taxes=
        DB::table('category_payment')
        ->join('tax', 'category_payment.tax_id', '=', 'tax.id')
        ->where('category_payment.account_id',Auth::user()->account_id)
        ->where('category_payment.payment_id',$payment_id)
        ->where('category_payment.tax_amount','>',0)
        ->select(DB::raw("CONCAT(tax.name,' (',category_payment.tax_amount,'%)') AS name"),
        DB::raw('SUM(category_payment.tax_total) as total'))
        ->groupBy('tax.name','category_payment.tax_amount')
        ->get();
        
        return  Helper::_taxesFormatter($taxes);
    }

    //Actualiza el estado de los pagos
    //1= anulado
    //0=Activo
    public function UpdatePaymentState($data,$id,$model,$localviewforevent)
    {
        $data['status_id'] = (int)$data['status_id'];        
        $item = $model::findOrFail($id);  

        $item->update($data);

        event(new RecordActivity('Update','Se actualizó el estado del pago número: '
        .$item->resolution_id.' para el cliente '.$item->contact->name,
        'Payment',$localviewforevent.$item->public_id));
        
        return response()
        ->json([
        'updated' => true
        ]);
    }

    //Guarda los registros en la tbla CategoryPayment
    //Esto luego de haber seleccionado la opción de asignar pagos a categorias
    public function storeCategoryPayment($data,$CategoryData, $model,$payment_type)
    {   
       

        //operación de categoría
        $categoryListInput=[];      
        $isCategory=true;
        $PaymentCounter=0;
            foreach($CategoryData as $item) {
                if ($item['unit_price']>0 && $item['category_id']>0)
                {
                    $categoryListInput[]=$item;
                    $PaymentCounter= $PaymentCounter+1;
                }
            }

         if($PaymentCounter==0) {
                return response()
                ->json([
                'category_empty' => ['seleccione un cliente que tenga un pago']
                ], 422);
            };    
 
        $data['public_id'] = Helper::PublicId($model);
        $data['resolution_id'] = (int)$data['resolution_id'];
        $data['isInvoice'] = (int)$data['isInvoice'];
        $data['status_id'] = PAYMENT_STATUS_APPLIED;
        $data['type_id'] = $payment_type;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['date']=Helper::dateFormatter($data['date']);
        if (!$data['currency_code'])
        {
            $data['currency_code']=CURRENCY_CODE_DEFAULT;
        }
        
        $payment = $model::create($data);
        
        $historical = [];
       
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
        
        
        return $payment;
    }

    //Almacena/crea un nuevo registro de pagos en la tabl payments y en paymenthistory,
    //En paymenthistory se relacionan los pagos asociados tanto a una factura de compra como a una de venta
    public function storePaymentByInvoice($data,$detailPayment, $model,$modelHistory, $payment_type,$modelToStatus,$status_id)
    {
        
        if(!$detailPayment) {
                return response()
                ->json([
                'payment_empty' => ['seleccione un cliente que tenga un pago']
                ], 422);
            };

        //validar que los montos ingresados no sean mayores a los del total habilitado
        $PaymentCounter=0;
        
            foreach($detailPayment as $item) {
                if(isset($item['amount_receipt'])) {
                    if ($item['amount_receipt']>$item['total_pending_by_payment2'])
                    {
                        return response()
                        ->json([
                        'amount_error' =>  ['revise los valores ingresados']
                        ], 422);
                    }
                    $PaymentCounter= $PaymentCounter+1;
                }
            }        
      
        
        if ( $PaymentCounter==0)
        {
            return response()
            ->json([
            'amount_empty' =>  ['revise los valores ingresados'],
            ], 422);
        }
        
        
        $data['public_id'] = Helper::PublicId($model);
        $data['resolution_id'] = (int)$data['resolution_id'];
        $data['isInvoice'] = (int)$data['isInvoice'];
        $data['status_id'] = PAYMENT_STATUS_APPLIED;
        $data['type_id'] = $payment_type;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['date']=Helper::dateFormatter($data['date']);
        if (!$data['currency_code'])
        {
            $data['currency_code']=CURRENCY_CODE_DEFAULT;
        }
        
        $payment = $model::create($data);
        $tablename=with(new $modelToStatus)->getTable();
        $historical = [];
        $invoice_id=null;
            foreach($detailPayment as $item) {
                if(isset($item['amount_receipt'])) {
                    $historical['amount']=$item['amount_receipt'];
                    //$historical['invoice_sale_order_id']=$item['id'];
                     $historical[$tablename.'_id']=$item['id'];
                    $invoice_id=$item['id'];
                    $historical['account_id']=Auth::user()->account_id;
                    $historical['user_id']=Auth::user()->id;
                    $historical['payment_id']=$payment->id;
                    
                    if($historical['amount']>0)
                    {
                        $modelHistory::create($historical);
                    }
                }
            }
            //cuando una factura de compra tiene un pago asociado, esta debe pasar a estado cerrado
            $this->updateModelStatus($invoice_id,$status_id,$modelToStatus,$tablename,$payment->id);        
        
        return $payment;
    }

    //Actualiza el estado de la factura respectiva
    //Lo actualiza a cerrado solo cuando el total de la deuda ha sido saldado
     public function updateModelStatus($invoice_id, $status_id,$model,$tablename, $payment_id)
    {
        $amount=$this->amountPendingToPay($tablename,$payment_id);

        if ($amount==0)
        {
            $model::where('id', $invoice_id)
            ->update(['status_id' => $status_id]);
        }
    }

    public function amountPendingToPay($tablename,$payment_id)
    {
         
        $totalAmount=0;
        $totalpending=($this->PaymentHistoryById($tablename,$payment_id));
         if (! $totalpending->isEmpty())
            {
                foreach($totalpending as $item)
                {
                    if ($item->total_pending_by_payment2>0)
                    {
                    $totalAmount=$item->total_pending_by_payment2;
                    }
                }
            }
        return $totalAmount;
    }

    //query
    //Retorna todos los movimientos realizados por bancos (entrada y salida)
    //pagos realizados de entrada y salida de dinero
    public function getTransactions($id,$column_name)
    {
         $transactionsToCategory=
            DB::table('payment')
                ->join('category_payment', 'category_payment.payment_id', '=', 'payment.id')
                ->leftjoin('contact', 'contact.id', '=', 'payment.customer_id')
                ->join('category', 'category.id', '=', 'category_payment.category_id')
                ->where('payment.account_id',Auth::user()->account_id)
                ->where('payment.'.$column_name,$id)
                ->where('payment.status_id',PAYMENT_STATUS_APPLIED)
                ->where('payment.isDeleted',0)
                ->select('payment.id','payment.public_id',
                    'payment.date',
                    'contact.name as contact_name',
                    'category.name as category_name',
                    'payment.status_id',
                    'payment.payment_method_id',
                    DB::raw("CASE WHEN payment.type_id='eg' THEN 'Categoría de Egreso' ELSE 'Categoría de Ingreso' END as detail"),
                    DB::raw("CASE WHEN payment.type_id='eg' THEN sum(IFNULL(category_payment.total,0)) ELSE 0 END as total_outcome"),
                    DB::raw("CASE WHEN payment.type_id='in' THEN sum(IFNULL(category_payment.total,0)) ELSE 0 END as total_income")
                )
                ->groupBy('payment.id','payment.date','contact.name','payment.type_id','category.name',
                'payment.status_id','payment.public_id','payment.payment_method_id');
        
        $transactionsToInvoice=
            DB::table('payment')
                ->join('payment_history', 'payment_history.payment_id', '=', 'payment.id')
                ->leftjoin('contact', 'contact.id', '=', 'payment.customer_id')
                ->join('invoice_sale_order', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
                ->where('payment.account_id',Auth::user()->account_id)
                ->where('payment.'.$column_name,$id)
                ->where('payment.status_id',PAYMENT_STATUS_APPLIED)
                ->where('payment.isDeleted',0)
                ->where('invoice_sale_order.isDeleted',0)
                ->where('invoice_sale_order.status_id',PAYMENT_STATUS_APPLIED)
                ->select('payment.id','payment.public_id',
                    'payment.date',                 
                    'contact.name as contact_name',
                    DB::raw("'' as category_name"),
                    'payment.status_id',
                    'payment.payment_method_id',
                    DB::raw("CASE WHEN payment.type_id='eg' THEN CONCAT('Factura de Compra No: ', ' ', invoice_sale_order.resolution_id)
                    ELSE CONCAT('Factura de venta No: ', ' ', invoice_sale_order.resolution_id) END as detail"),
                    DB::raw("CASE WHEN payment.type_id='eg' THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_outcome"),
                    DB::raw("CASE WHEN payment.type_id='in' THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_income")
                )
                ->groupBy('payment.id','payment.date','contact.name','payment.type_id',
                'payment.status_id','payment.public_id','payment.payment_method_id',
                'invoice_sale_order.resolution_id');

             $transactionsToBill=
                DB::table('payment')
                ->join('payment_history', 'payment_history.payment_id', '=', 'payment.id')
                ->leftjoin('contact', 'contact.id', '=', 'payment.customer_id')
                ->join('bill', 'bill.id', '=', 'payment_history.bill_id')
                ->where('payment.account_id',Auth::user()->account_id)
                ->where('payment.'.$column_name,$id)
                ->where('payment.status_id',BILL_STATUS_OPEN)
                ->where('payment.isDeleted',0)
                ->where('bill.isDeleted',0)
                ->where('bill.status_id',BILL_STATUS_OPEN)
                ->select('payment.id','payment.public_id',
                    'payment.date',                 
                    'contact.name as contact_name',
                    DB::raw("'' as category_name"),
                    'payment.status_id',
                    'payment.payment_method_id',
                    DB::raw("CASE WHEN payment.type_id='eg' THEN CONCAT('Factura de Compra No: ', ' ', bill.resolution_id)
                    ELSE CONCAT('Factura de venta No: ', ' ', bill.resolution_id) END as detail"),
                    DB::raw("CASE WHEN payment.type_id='eg' THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_outcome"),
                    DB::raw("CASE WHEN payment.type_id='in' THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_income")
                )
                ->groupBy('payment.id','payment.date','contact.name','payment.type_id',
                'payment.status_id','payment.public_id','payment.payment_method_id','bill.resolution_id')            
                //->union($transactionsToCategory)
                ->union($transactionsToInvoice)
                ->get();
        
        return  $transactionsToBill;
    }
}