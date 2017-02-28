<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CategoryPayment extends Model
{
    protected $table = 'category_payment';
    protected $fillable=[
	'payment_id','user_id','account_id','category_id','unit_price','tax_id','tax_total','tax_amount','quantity','observations'
	];
    
}
