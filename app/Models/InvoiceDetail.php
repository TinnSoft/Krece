<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class InvoiceDetail extends Model
{   
   
    protected $table = 'invoice_sale_order_detail';
    protected $fillable=['unit_price','quantity','total','product_id','description','user_id','discount','tax_amount','invoice_id'];
     protected $dates = ['deleted_at'];

    public function invoice()
    {
        return $this->belongsTo(Invoice::class);
    }

        public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id')->select(array('id', 'name'));        
    }

    
}
