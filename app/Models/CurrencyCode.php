<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CurrencyCode extends Model
{
    protected $table = 'currency_code';
    protected $dates = ['deleted_at'];
    
}