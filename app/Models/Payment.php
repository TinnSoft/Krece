<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;
use App\Models\PaymentMethod;
use App\Models\PaymentHistory;
use App\Models\CategoryPayment;
use App\Utilities\DatesTranslator;
use Auth;
use App\Events\RecordActivity;

class Payment extends Model
{
	
	use DatesTranslator;
	
	
	protected $table = 'payment';
	
	
	protected $fillable=[
	'public_id','customer_id','account_id','user_id','isInvoice','status_id','bank_account_id','type_id','parent_id',
	'currency_code','observations','notes','date','isDeleted','resolution_id','payment_method_id','payment_id','deleted_at'
	];
	
	protected $dates = ['deleted_at'];
	
	public function category_payment()
	{
		
		return $this->hasMany(CategoryPayment::class);
		
	}
	
	public function contact()
	{
		
		return $this->hasOne(Contact::class, 'id', 'customer_id')->select(array('id', 'name','address','city','nit','phone1','public_id'));
		
	}	
	
	
	public function payment_method()
	{
		
		return $this->hasOne(PaymentMethod::class, 'id', 'payment_method_id')->select(array('id', 'name'));
		
	}
	
	
	public function currency()
	{
		
		return $this->hasOne(Currency::class, 'code_id','currency_code')->select(array('code_id as code', 'code_id'));
		
	}

	public function bank_account()
	{
		
		return $this->hasOne(BankAccount::class, 'id','bank_account_id')->select(array('id', 'bank_account_name'));
		
	}
	 
	
	public function account()
	{
		return $this->hasOne(Account::class,'id','account_id')->select(array('id','name','address','phone','identification','city','logo','email'));
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
	'currency_code','observations','notes','date','isDeleted','resolution_id','payment_method_id','id');
	}

}

