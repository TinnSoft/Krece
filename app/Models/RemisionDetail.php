<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class RemisionDetail extends Model
{   
   
    protected $table = 'remision_detail';
    protected $fillable=['unit_price','quantity','total','product_id','description','user_id','discount','tax_amount','remision_id'];
     protected $dates = ['deleted_at'];

    public function remision()
    {
        return $this->belongsTo(Remision::class);
    }

        public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id')->select(array('id', 'name'));        
    }

    
}
