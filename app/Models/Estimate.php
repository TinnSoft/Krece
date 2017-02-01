<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;
use App\Models\Seller;
use App\Models\ListPrice;
use App\Utilities\DatesTranslator;
use Carbon\Carbon;

class Estimate extends Model
{
    use DatesTranslator;

    protected $table = 'estimate';    
    
    protected $fillable=[
        'public_id','customer_id','description','account_id','user_id',
        'seller_id','currency_code','observations','notes','date','due_date','list_price_id','total',''
    ];
    protected $dates = ['deleted_at'];
    
    public function estimatedetail()
    {
        return $this->hasMany(EstimateDetail::class)->with('product');
    }

     public function contact()
    {
        return $this->hasOne(Contact::class, 'id', 'customer_id')->select(array('id', 'name'));        
    }

     public function seller()
    {
        return $this->hasOne(Seller::class, 'id', 'seller_id')->select(array('id', 'name'));        
    }

    public function list_price()
    {
        return $this->hasOne(ListPrice::class, 'id', 'list_price_id')->select(array('id', 'name'));
    }

     public function currency()
    {
        return $this->hasOne(Currency::class, 'code_id','currency_code')->select(array('code_id as code', 'code_id'));
    }


}
