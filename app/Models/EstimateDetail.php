<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class EstimateDetail extends Model
{   
   
    protected $table = 'estimate_detail';
    protected $fillable=['unit_price','quantity','total','product_id','description','user_id','discount','tax_amount'];
     protected $dates = ['deleted_at'];

    public function estimate()
    {
        return $this->belongsTo(Estimate::class);
    }

        public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id')->select(array('id', 'name'));
        // return $this->belongsTo(Product::class, 'id', 'product_id');         
    }

    
}
