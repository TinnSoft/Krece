<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;
use App\Models\Seller;
use App\Models\ListPrice;
use App\Models\Resolution;
use App\Utilities\DatesTranslator;
use Auth;



class InvoiceSaleOrder extends Model
{
	
	use DatesTranslator;
	
	
	protected $table = 'invoice_sale_order';
	
	
	protected $fillable=[
	'public_id','customer_id','description','account_id','user_id','sub_total','total_discounts','total_taxes',
	'seller_id','currency_code','observations','notes','date','due_date','list_price_id','total','isDeleted','resolution_id',
	'status_id','payment_terms_id','category_id','total_payed','balance','resolution_id_ref'
	];
	
	protected $dates = ['deleted_at'];
	
	
	public function detail()
	{
		
		return $this->hasMany(InvoiceSaleOrderDetail::class)->with('product','taxes');
		
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
		return $this->hasOne(Account::class,'id','account_id')->with('account_regime')
		->select(array('id','name','address','phone','identification','city','logo','regime_id'));
	}

	public function resolution()
	{
		return $this->hasOne(Resolution::class,'id','resolution_id_ref')
		->select(array('id','invoice_text'));
	}

	public function payment_terms()
	{
		return $this->hasOne(PaymentTerms::class,'id','payment_terms_id')->select(array('id','name','days'));
	}
	
	public function scopeAccountID($query,$isDeleted)
	{		
		return $query->where('account_id',  Auth::user()->account_id)
				->where('status_id','<>',2)
                ->where('isDeleted',$isDeleted);
	}
	
	  public function scopeGetByPublicId($query,$isDeleted,$id)
    {
        return $query->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',$isDeleted)
				->where('status_id','<>',2)
                 ->where('public_id',  $id);
    }

	 public function scopeGetSelectedFields($query)
    {
        return $query->select('id','account_id','public_id','seller_id','list_price_id','customer_id','currency_code',
                    'sub_total','total_discounts','total_taxes','total','date','due_date','notes','observations','exchange_rate',
                    'created_at','updated_at','resolution_id','status_id','payment_terms_id','resolution_id_ref');
	}

}

