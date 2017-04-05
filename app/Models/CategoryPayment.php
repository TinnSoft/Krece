<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class CategoryPayment extends Model
{
    protected $table = 'category_payment';
    protected $fillable=[
	'payment_id','user_id','account_id','category_id','unit_price','tax_id','tax_total','tax_amount','quantity','observations','total'
	];

     public function category()
    {
        return $this->hasOne(Category::class, 'id', 'category_id')->with('type')->select(array('id', 'name','type_id'));    
    }

     public function taxes()
    {
        return $this->hasOne(Tax::class, 'id', 'tax_id')->select(array(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value','id'));        
    }

   
}
