<?php

namespace App\Repositories;

use App\Utilities\Helper;
use App\Contracts\IPdfRepository;
use PDF;
use App\Models\{
    Account,
    Estimate,
    InvoiceSaleOrder,
    Payment
};
use Auth;
use App\Repositories\PaymentRepository;

class PdfRepository implements IPdfRepository
{
    
    protected $paymentRepo;

    public function __construct(PaymentRepository $paymentRepo)
    {
        $this->paymentRepo = $paymentRepo;
    }

    //Genera el pdf base que se exporta por cada vista
    //$model=nombre del modelo
    //public_id= id del documento
    //view= nombre de la vista que muestra el pdf
    
    public function create($model, $public_id)
    {
        $withArray=[];
        //nombres de las variables del array que se van a exportar
        $array1_name=null;
        $array2_name=null;
        
        //Nombres de las tablas del header y del detalle
        $table_header_name=null;
        $table_detail_name=null;
        
        $view=null;
        $isPayment=false;

        switch (class_basename($model))
        {
            case 'Estimate';
                $withArray=['account','detail','list_price','seller'];
                $array1_name='estimate';
                $array2_name='taxes';
                $table_header_name='estimate';
                $table_detail_name='estimate_detail';
                $view='pdf.estimate';

                break;

             case 'CreditNote';
                $withArray=['account','detail','list_price'];
                $array1_name='creditnote';
                $array2_name='taxes';
                $table_header_name='credit_note';
                $table_detail_name='credit_note_detail';
                $view='pdf.credit-note';

                break;

            case 'Remision';
                $withArray=['account','detail','list_price','seller'];
                $array1_name='remision';
                $array2_name='taxes';
                $table_header_name='remision';
                $table_detail_name='remision_detail';
                $view='pdf.remision';

                break;
            
            case 'InvoiceSaleOrder';
                $withArray=['account','detail','list_price','seller','resolution','payment_terms'];
                $array1_name='invoice';
                $array2_name='taxes';
                $table_header_name='invoice_sale_order';
                $table_detail_name='invoice_sale_order_detail';
                $view='pdf.invoice';

                break;

            case 'PurchaseOrder';
                $withArray=['account','detail'];
                $array1_name='po';
                $array2_name='taxes';
                $table_header_name='purchase_order';
                $table_detail_name='purchase_order_detail';
                $view='pdf.purchase-order';

                break;

            case 'Payment';
                return $this->paymentPDF($model, $public_id);

                break;
            
             case 'Bill';
                $withArray=['account','detail'];
                $array1_name='bill';
                $array2_name='taxes';
                $table_header_name='bill';
                $table_detail_name='bill_detail';
                $view='pdf.bill';

                break;

             case 'DebitNote';
                $withArray=['account','detail'];
                $array1_name='debitnote';
                $array2_name='taxes';
                $table_header_name='debit_note';
                $table_detail_name='debit_note_detail';
                $view='pdf.debit-note';

                break;

            default;
            
            break;
    
        };

        $data = $model::with( $withArray)
        ->GetByPublicId(0,$public_id)
        ->GetSelectedFields()
        ->first();

        $data=Helper::_InvoiceFormatter($data);
        $taxes=Helper::getTotalTaxes($data->public_id,$table_header_name,$table_detail_name);

        return PDF::loadView($view, [$array1_name => $data, $array2_name=>$taxes]);

    }

    private function paymentPDF($model, $id)
    {   
        $paymentType=$model::where('account_id',Auth::user()->account_id)->where('public_id',$id)->select('type_id')->first();
        
        $tableName=null;
        $view=null;
        if ($paymentType['type_id']=='in')
        {
            $view=PAYMENT_LOCAL_VIEW_IN;
            $tableName='invoice_sale_order';
        }
        else
        {
            $view=PAYMENT_LOCAL_VIEW_OUT;
            $tableName='bill';
        }

        $payment = $model::with('contact','payment_method','bank_account')
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();

        $subtotal=0;
        $total=0;
        $taxes=[];
        $isCategory=false;
        $detail=[];

         //1. buscar si tiene pagos asociados por factura
        $payment_detail=$this->paymentRepo->PaymentHistoryById($tableName,$payment->id);
       
        foreach($payment_detail as $item)
        {
            if ($paymentType['type_id']=='in')
            {
                $detail = collect([
                ['total' => Helper::formatMoney( ($item ->payed)), //total_pending_by_payment2
                'total2' =>  ($item ->payed),
                'quantity' => 1,
                'concept'=>'Pago a factura de venta No '.$item->resolution_id]
                ]);
            }
            else
            {
                $detail = collect([
                ['total' => Helper::formatMoney( ($item ->total_pending_by_payment2)),
                'total2' =>  ($item ->total_pending_by_payment2),
                'quantity' => 1,
                'concept'=>'Pago a factura de proveedor']
                ]);
            }
        }
        
        
        if(!collect($detail)->isEmpty())
        {
            $total=Helper::formatMoney($detail->sum('total2'));
        }
        
        $subtotal=$total;
       
        //2. Si no tiene pagos asociados por factura entonces buscar si tiene pagos a categorias
        if ($payment_detail->isEmpty())
        {
            $payment_detail=$this->paymentRepo->ListOfCategoriesByPayment($payment->id);   ;
            if (! $payment_detail->isEmpty())
            {   
                $taxes=$this->paymentRepo->getTotalTaxesOfCategoryByPayment($payment->id); 

                $subtotal=Helper::formatMoney($payment_detail->sum('total'));
                $isCategory=true;
                $total=Helper::formatMoney($payment_detail->sum('total') + $payment_detail->sum('tax_total'));
                
                foreach($payment_detail as $item)
                {
                    $detail[] =collect( 
                    ['total' => Helper::formatMoney($item->total)
                    , 'quantity' =>  $item->quantity,
                    'concept'=> $item->category->name
                    ]);
                }
                $detail = collect($detail);
                          
            }
        }
        
        return PDF::loadView('pdf.'.$view, 
            ['payment' => $payment,
                'detail' => $detail,
                'taxes' => $taxes,
                'isCategory'=>$isCategory,
                'total'=>$total,
                'subtotal'=>$subtotal
            ]);
        
    }
}