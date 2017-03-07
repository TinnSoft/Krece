<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\Tax;
use Illuminate\Support\Facades\DB;

class RemisionDetail extends Model
{
    
    protected $table = 'remision_detail';
    protected $fillable=['unit_price','quantity','total','product_id','name',
    'description','user_id','discount','tax_amount','remision_id','tax_id','total_tax'];
    protected $dates = ['deleted_at'];
    
    public function remision()
    {
        return $this->belongsTo(Remision::class);
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