<?php namespace App\Utilities;

class Helper
{
 public static function formatMoney($value)
 {
     $valconverted=$value;
     try{
     $valconverted=number_format($value, '2', '.', ',');
     }
     catch(\exception $e){}

    return $valconverted;
 }
}