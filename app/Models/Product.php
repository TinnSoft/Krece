<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Product extends Model
{   
    protected $dates = ['deleted_at'];
    protected $table = 'product';
    protected $fillable=['public_id','user_id','account_id','name','description','reference','isActive',
    'sale_price','tax_id','category_id','list_price_id','inv_quantity_initial','inv_unit_cost','inv_type_id','inv_inStock'];

    
     public function list_price()
    {
        return $this->hasOne(ListPrice::class, 'id', 'list_price_id')->select(array('id', 'name'));
    }
    public function tax()
    {
        return $this->hasOne(Tax::class, 'id', 'tax_id')->select(DB::raw("CONCAT(name,' (',amount,'%)') as name"),'amount','id');  
    }

     public function measure_unit()
    {
        return $this->hasOne(ProductInventoryType::class, 'id', 'inv_type_id')->select(array('id', 'measure_unit'));
    }

     public function category()
    {
        return $this->hasOne(Category::class, 'id', 'category_id')->select(array('id', 'name'));
    }
}
