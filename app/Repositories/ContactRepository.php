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
}