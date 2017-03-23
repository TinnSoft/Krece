<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Utilities\DatesTranslator;


class ListPrice extends Model
{
    use DatesTranslator;

    protected $table = 'list_price';
    
    
    protected $fillable=[
        'public_id','name','type_id','account_id','user_id',
        'value','id','isEnabled','isDefault'
    ];
    protected $dates = ['deleted_at','created_at'];
    
    public function listprice_type()
    {
        return $this->hasOne(ListPriceType::class,'id','type_id');        
    }

     public function estimates()
    {
        return $this->hasMany(Estimate::class);
    }

     public function products()
    {
        return $this->hasMany(Product::class);
    }

}
