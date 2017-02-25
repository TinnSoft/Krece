<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Category;
use App\Models\Tax;
use Illuminate\Support\Facades\DB;
use Auth;

class BillDetail extends Model
{   
   
    protected $table = 'bill_detail';
    protected $fillable=['unit_price','quantity','total','description',
    'user_id','discount','tax_amount','bill_id','name'
    ,'category_id','tax_id','total_tax'];

     protected $dates = ['deleted_at'];

    public function invoice()
    {
        return $this->belongsTo(Bill::class);
    }

        public function category()
    {
        return $this->hasOne(Category::class, 'id', 'category_id')->where('account_id',Auth::User()->account_id)->select(array('id', 'name'));        
    }

        public function taxes()
    {
        return $this->hasOne(Tax::class, 'id', 'tax_id')->select(array(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value','id'));        
    }

}
