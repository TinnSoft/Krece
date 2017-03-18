<?php
namespace App\Contracts;


interface IContactsRepository  
{
    public function getRemisionList($customer_id,$filter_field);

    public function getEstimateList($customer_id,$filter_field);

    public function getInvoiceList($customer_id,$filter_field);

    public function getBillList($customer_id,$filter_field);

    public function getCreditNoteList($customer_id,$filter_field);

    public function getDebitNoteList($customer_id,$filter_field);

    public function getPOList($customer_id,$filter_field);

    public static function getInvoiceListByCustomer($customer_id,$filter_field,$table);

}