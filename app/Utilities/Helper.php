<?php namespace App\Utilities;

class Helper
{
 public static function formatMoney($value)
 {
    return number_format($value, '2', '.', ',');
 }
}