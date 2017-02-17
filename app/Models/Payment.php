<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;
use App\Models\Seller;
use App\Models\ListPrice;
use App\Utilities\DatesTranslator;
use Auth;
use App\Events\RecordActivity;

class Payment extends Model
{
	
	use DatesTranslator;
	
	
	protected $table = 'payment';
	
	
	protected $fillable=[
	'public_id','customer_id','account_id','user_id','isInvoice','status_id','bank_account_id','type_id',
	'currency_code','observations','notes','date','isDeleted','resolution_id','payment_method_id'
	];
	
	protected $dates = ['deleted_at'];
	
	
	public function detail()
	{
		
		return $this->hasMany(EstimateDetail::class)->with('product');
		
	}
	
	
	public function contact()
	{
		
		return $this->hasOne(Contact::class, 'id', 'customer_id')->select(array('id', 'name','address','city','nit','phone1','public_id'));
		
	}
	
	
	
	public function list_price()
	{
		
		return $this->hasOne(ListPrice::class, 'id', 'list_price_id')->select(array('id', 'name'));
		
	}
	
	
	public function currency()
	{
		
		return $this->hasOne(Currency::class, 'code_id','currency_code')->select(array('code_id as code', 'code_id'));
		
	}
	
	public function account()
	{
		return $this->hasOne(Account::class,'id','account_id')->select(array('id','name','address','phone','identification','city','logo'));
	}
	
	public function scopeGetAll($query,$isDeleted)
	{
		
		return $query->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',$isDeleted);
	}
	
	  public function scopeGetByPublicId($query,$isDeleted,$id)
    {
        return $query->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',$isDeleted)
                 ->where('public_id',  $id);
    }

	 public function scopeGetSelectedFields($query)
    {
        return $query->select('public_id','customer_id','account_id','user_id','isInvoice','status_id','bank_account_id',
	'currency_code','observations','notes','date','isDeleted','resolution_id','payment_method_id');
	}

}

