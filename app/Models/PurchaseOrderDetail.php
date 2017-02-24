<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Category;
use Illuminate\Support\Facades\DB;

class PurchaseOrderDetail extends Model
{   
   
    protected $table = 'purchase_order_detail';
    protected $fillable=['unit_price','quantity','total','category_id','description','user_id',
    'discount','tax_amount','name','tax_id','total_tax'];
     protected $dates = ['deleted_at'];

    public function po()
    {
        return $this->belongsTo(PurchaseOrder::class);
    }

        public function category()
    {
        return $this->hasOne(Category::class, 'id', 'category_id')->select(array('id', 'name'));         
    }

        public function taxes()
    {
        return $this->hasOne(Tax::class, 'id', 'tax_id')->select(array(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value','id'));        
    }
    
}
