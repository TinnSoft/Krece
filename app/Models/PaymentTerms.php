<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaymentTerms extends Model
{
    protected $table = 'payment_terms';
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'account_id','public_id','user_id','name','days'
    ];
   
    
}
