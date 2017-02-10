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
   public static function setCustomDateFormat($dateval)
    {            
        $day=$dateval->day;
        $month=$dateval->month;
        $year=$dateval->year;
        return $day.'/'. $month.'/'.$year;   
    }
}