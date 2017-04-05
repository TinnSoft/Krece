<?php

namespace App\Repositories;
use Auth;
use DB;
use App\Contracts\IContactsRepository;

class ContactsRepository implements IContactsRepository
{
    public function getRemisionList($filter_value, $filter_field)
    {
        return
            DB::table('remision')
            ->join('contact', 'remision.customer_id', '=', 'contact.id')
            ->join('remision_status', 'remision_status.id', '=', 'remision.status_id')
            ->where('remision.account_id',Auth::user()->account_id)
            ->where('remision.status_id',1)
            ->where('remision.isDeleted',0)
            ->where('remision.'.$filter_field,$filter_value)
            ->select('remision.resolution_id',
            'contact.name',
            'remision.date',
            'remision.due_date',
            'remision_status.description as status_description',
            'remision.status_id',
            'remision.total',
            'remision.public_id'
            )
            ->get();
    }

    public function getEstimateList($filter_value, $filter_field)
    {
        return
            DB::table('estimate')
            ->join('contact', 'estimate.customer_id', '=', 'contact.id')
            ->where('estimate.account_id',Auth::user()->account_id)
            ->where('estimate.isDeleted',0)
            ->where('estimate.'.$filter_field,$filter_value)
            ->select('estimate.resolution_id',
            'contact.name',
            'estimate.date',
            'estimate.due_date',
            'estimate.total',
            'estimate.public_id'
            )
            ->get();
    }

    public function getInvoiceList($filter_value,$filter_field)
    {       
        $tablename='invoice_sale_order';
        return $this->getInvoiceListByCustomer($filter_value,$filter_field,$tablename);
    }

    public function getBillList($filter_value,$filter_field)
    {
        $tablename='bill';
        return $this->getInvoiceListByCustomer($filter_value,$filter_field,$tablename);
    }

    public function getCreditNoteList($filter_value, $filter_field)
    {
        return
            DB::table('credit_note')
            ->join('contact', 'credit_note.customer_id', '=', 'contact.id')
            ->where('credit_note.account_id',Auth::user()->account_id)
            ->where('credit_note.isDeleted',0)
            ->where('credit_note.'.$filter_field,$filter_value)
            ->select('credit_note.resolution_id',
            'contact.name',
            'credit_note.date',
            'credit_note.total',
            'credit_note.public_id'
            )
            ->get();
    }

     public function getDebitNoteList($filter_value,$filter_field)
    {
          return
            DB::table('debit_note')
            ->join('contact', 'debit_note.customer_id', '=', 'contact.id')
            ->where('debit_note.account_id',Auth::user()->account_id)
            ->where('debit_note.isDeleted',0)
            ->where('debit_note.'.$filter_field,$filter_value)
            ->select('debit_note.resolution_id',
            'contact.name',
            'debit_note.date',
            'debit_note.total',
            'debit_note.public_id'
            )
            ->get();
    }

    public function getPOList($filter_value,$filter_field)
    {
        return
            DB::table('purchase_order')
            ->join('contact', 'purchase_order.customer_id', '=', 'contact.id')
            ->join('purchase_order_status', 'purchase_order_status.id', '=', 'purchase_order.status_id')
            ->where('purchase_order.account_id',Auth::user()->account_id)
            ->where('purchase_order.isDeleted',0)
            ->where('purchase_order.'.$filter_field,$filter_value)
            ->select('purchase_order.resolution_id',
            'contact.name',
            'purchase_order.date',
            'purchase_order.due_date',
            'purchase_order.total',
            'purchase_order.public_id',
            'purchase_order.status_id',
            'purchase_order_status.description as status_description'
            )
            ->get();
    }
    
    //Query dinámico
    //Retorna el listado de facturas de venta o compra junto a los pagos realizados
    //basado en el id del cliente seleccionado en el front
    public static function getInvoiceListByCustomer($filter_value,$filter_field, $table)
    {
        $invoiceWithPayments=
            DB::table($table)
            ->join('contact', $table.'.customer_id', '=', 'contact.id')
            ->join($table.'_status', $table.'_status.id', '=', $table.'.status_id')
            ->leftJoin('payment_history', 'payment_history.'.$table.'_id', '=', $table.'.id')
            ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')            
            ->where($table.'.account_id',Auth::user()->account_id)
            ->where($table.'.isDeleted',0)
            ->where($table.'.status_id',1)
            ->where('payment.isDeleted',0)
            ->where('payment.status_id',1)
            ->where($table.'.'.$filter_field,$filter_value)
            ->select($table.'.resolution_id',
                'contact.name',
                $table.'.date',
                $table.'.due_date',
                $table.'.total',
                DB::raw("sum(IFNULL(payment_history.amount,0)) as total_payed"),
                DB::raw($table.".total-sum(IFNULL(payment_history.amount,0)) as pending_to_pay"),
                $table.'.public_id',
                $table.'.status_id',
                $table.'_status.description as status_description'
            )
            ->groupBy($table.'.resolution_id',
                'contact.name',
                $table.'.date',
                $table.'.due_date',
                $table.'.total',
                $table.'.public_id',
                $table.'.status_id',
                $table.'_status.description'
                )
            ->get();

            $invoiceWithoutPayments=
            DB::table($table)
            ->join('contact', $table.'.customer_id', '=', 'contact.id')
            ->join($table.'_status', $table.'_status.id', '=', $table.'.status_id')
            ->leftJoin('payment_history', 'payment_history.'.$table.'_id', '=', $table.'.id')
             ->leftJoin('payment', 'payment.id', '=', 'payment_history.payment_id')            
            ->where($table.'.account_id',Auth::user()->account_id)
            ->where($table.'.isDeleted',0)
            ->where('payment_history.amount',null)
            ->where($table.'.'.$filter_field,$filter_value)
            ->select($table.'.resolution_id',
                'contact.name',
                $table.'.date',
                $table.'.due_date',
                $table.'.total',
                DB::raw("sum(IFNULL(payment_history.amount,0)) as total_payed"),
                DB::raw($table.".total-sum(IFNULL(payment_history.amount,0)) as pending_to_pay"),
                $table.'.public_id',
                $table.'.status_id',
                $table.'_status.description as status_description'
            )
            ->groupBy($table.'.resolution_id',
                'contact.name',
                $table.'.date',
                $table.'.due_date',
                $table.'.total',
                $table.'.public_id',
                $table.'.status_id',
                $table.'_status.description'
                ) 
            ->get();

            $invoiceWithoutPayments=$invoiceWithPayments->merge($invoiceWithoutPayments);
            $invoiceWithoutPayments->all();
            
            $invoiceWithoutPayments=$invoiceWithoutPayments->sortByDesc('resolution_id');
            $invoiceWithoutPayments = $invoiceWithoutPayments->values()->all();

            return $invoiceWithoutPayments;
    }
}