<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\Tax;
use Illuminate\Support\Facades\DB;

class InvoiceSaleOrderDetail extends Model
{   
   
    protected $table = 'invoice_sale_order_detail';
    protected $fillable=['unit_price','quantity','total','product_id','description','user_id','discount','tax_amount','invoice_sale_order_id'
    ,'reference','tax_id','total_tax'];

     protected $dates = ['deleted_at'];

    public function invoice()
    {
        return $this->belongsTo(InvoiceSaleOrder::class);
    }

        public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id')->select(array('id', 'name'));        
    }

        public function taxes()
    {
        return $this->hasOne(Tax::class, 'id', 'tax_id')->select(array(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value','id'));        
    }

}
