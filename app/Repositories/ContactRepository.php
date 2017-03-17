<?php

namespace App\Repositories;
use Auth;
use Illuminate\Support\Facades\DB;

class ContactRepository
{
    public function getRemisionList($customer_id)
    {
        return
            DB::table('remision')
            ->join('contact', 'remision.customer_id', '=', 'contact.id')
            ->join('remision_status', 'remision_status.id', '=', 'remision.status_id')
            ->where('remision.account_id',Auth::user()->account_id)
            ->where('remision.status_id',1)
            ->where('remision.isDeleted',0)
            ->where('remision.customer_id',$customer_id)
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

    public function getEstimateList($customer_id)
    {
        return
            DB::table('estimate')
            ->join('contact', 'estimate.customer_id', '=', 'contact.id')
            ->where('estimate.account_id',Auth::user()->account_id)
            ->where('estimate.isDeleted',0)
            ->where('estimate.customer_id',$customer_id)
            ->select('estimate.resolution_id',
            'contact.name',
            'estimate.date',
            'estimate.due_date',
            'estimate.total',
            'estimate.public_id'
            )
            ->get();
    }
    public function getInvoiceList($customer_id)
    {
        return
            DB::table('invoice_sale_order')
            ->join('contact', 'invoice_sale_order.customer_id', '=', 'contact.id')
            ->join('invoice_sale_order_status', 'invoice_sale_order_status.id', '=', 'invoice_sale_order.status_id')
            ->leftjoin('payment_history', function ($join) {
                $join->on('payment_history.invoice_sale_order_id', '=', 'invoice_sale_order.id');
            })
             ->leftjoin('payment', 'payment.id', '=', 'payment_history.payment_id')            
            ->where('invoice_sale_order.account_id',Auth::user()->account_id)
            ->where('invoice_sale_order.isDeleted',0)
            ->where('invoice_sale_order.status_id',1)
            ->where('invoice_sale_order.customer_id',$customer_id)
            ->select('invoice_sale_order.resolution_id',
                'contact.name',
                'invoice_sale_order.date',
                'invoice_sale_order.due_date',
                'invoice_sale_order.total',
                DB::raw("CASE WHEN payment.status_id='1' and payment.isDeleted=0 THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_payed"),
                DB::raw("CASE WHEN payment.status_id='1' and payment.isDeleted=0 THEN invoice_sale_order.total-sum(IFNULL(payment_history.amount,0)) ELSE invoice_sale_order.total END as pending_to_pay"),
                'invoice_sale_order.public_id',
                'invoice_sale_order.status_id',
                'invoice_sale_order_status.description as status_description'
            )
            ->groupBy('invoice_sale_order.resolution_id',
                'contact.name',
                'invoice_sale_order.date',
                'invoice_sale_order.due_date',
                'invoice_sale_order.total',
                'invoice_sale_order.public_id',
                'invoice_sale_order.status_id',
                'invoice_sale_order_status.description',
                'payment.status_id',
                 'payment.isDeleted'
                )      
            ->get();
    }

    public function getBillList($customer_id)
    {
        return
            DB::table('bill')
            ->join('contact', 'bill.customer_id', '=', 'contact.id')
            ->leftjoin('payment_history', function ($join) {
                $join->on('payment_history.bill_id', '=', 'bill.id');
            })
             ->leftjoin('payment', 'payment.id', '=', 'payment_history.payment_id')    
            ->where('bill.account_id',Auth::user()->account_id)
            ->where('bill.isDeleted',0)
            ->where('bill.customer_id',$customer_id)
            ->select('bill.resolution_id',
            'contact.name',
            'bill.date',
            'bill.due_date',
            'bill.total',
            DB::raw("CASE WHEN payment.status_id='1' and payment.isDeleted=0 THEN sum(IFNULL(payment_history.amount,0)) ELSE 0 END as total_payed"),
            DB::raw("CASE WHEN payment.status_id='1' and payment.isDeleted=0 THEN bill.total-sum(IFNULL(payment_history.amount,0)) ELSE bill.total END as pending_to_pay"),
            'bill.public_id',
            'bill.status_id'
            )
             ->groupBy('bill.resolution_id',
            'contact.name',
            'bill.date',
            'bill.due_date',
            'bill.total',
             'bill.public_id',
            'bill.status_id',
            'payment.isDeleted',
            'payment.status_id'
                )      
            ->get();
    }

    public function getCreditNoteList($customer_id)
    {
        return
            DB::table('credit_note')
            ->join('contact', 'credit_note.customer_id', '=', 'contact.id')
            ->where('credit_note.account_id',Auth::user()->account_id)
            ->where('credit_note.isDeleted',0)
            ->where('credit_note.customer_id',$customer_id)
            ->select('credit_note.resolution_id',
            'contact.name',
            'credit_note.date',
            'credit_note.total',
            'credit_note.public_id'
            )
            ->get();
    }

     public function getDebitNoteList($customer_id)
    {
          return
            DB::table('debit_note')
            ->join('contact', 'debit_note.customer_id', '=', 'contact.id')
            ->where('debit_note.account_id',Auth::user()->account_id)
            ->where('debit_note.isDeleted',0)
            ->where('debit_note.customer_id',$customer_id)
            ->select('debit_note.resolution_id',
            'contact.name',
            'debit_note.date',
            'debit_note.total',
            'debit_note.public_id'
            )
            ->get();
    }

    public function getPOList($customer_id)
    {
        return
            DB::table('purchase_order')
            ->join('contact', 'purchase_order.customer_id', '=', 'contact.id')
            ->join('purchase_order_status', 'purchase_order_status.id', '=', 'purchase_order.status_id')
            ->where('purchase_order.account_id',Auth::user()->account_id)
            ->where('purchase_order.isDeleted',0)
            ->where('purchase_order.customer_id',$customer_id)
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
    
}