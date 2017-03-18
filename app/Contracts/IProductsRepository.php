<?php
namespace App\Contracts;


interface IProductsRepository  
{
    public function getRemisionList($filter_value,$filter_field);

    public function getEstimateList($filter_value,$filter_field);

    public function getInvoiceList($filter_value,$filter_field);

    public function getBillList($filter_value,$filter_field);

    public function getCreditNoteList($filter_value,$filter_field);

    public function getDebitNoteList($filter_value,$filter_field);

    public function getPOList($filter_value,$filter_field);

    public static function getInvoiceListByCustomer($filter_value,$filter_field,$table);

}