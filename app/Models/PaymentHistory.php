<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaymentHistory extends Model
{
    protected $table = 'payment_history';
    protected $fillable=[
	'account_id','user_id','invoice_sale_order_id','amount','payment_id','bill_id'
	];
}
