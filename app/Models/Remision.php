<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;
use App\Models\Seller;
use App\Models\ListPrice;
use App\Utilities\DatesTranslator;
use Auth;

class Remision extends Model
{
	
	use DatesTranslator;
	
	
	protected $table = 'remision';
	
	
	protected $fillable=[
	'public_id','customer_id','description','account_id','user_id','sub_total','total_discounts','total_taxes',
	'seller_id','currency_code','observations','notes','date','due_date','list_price_id','total','isDeleted','resolution_id',
	'document_type_id','status_id'
	];
	
	protected $dates = ['deleted_at'];
	
	
	public function remisiondetail()
	{
		
		return $this->hasMany(RemisionDetail::class)->with('product');
		
	}
	
	
	public function contact()
	{
		
		return $this->hasOne(Contact::class, 'id', 'customer_id')->select(array('id', 'name','address','city','nit','phone1','public_id'));
		
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
        return $query->select('id','account_id','public_id','seller_id','list_price_id','customer_id','currency_code',
                    'sub_total','total_discounts','total_taxes','total','date','due_date','notes','observations','exchange_rate',
                    'created_at','updated_at','resolution_id','status_id','document_type_id');
	}
}

