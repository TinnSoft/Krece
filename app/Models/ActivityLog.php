<?php

namespace App\Models;

use Carbon\Carbon;

use Illuminate\Database\Eloquent\Model;


class ActivityLog extends Model
{
	
	protected $table = 'activity_log';
	
	
	protected $fillable = [
	'account_id','user_id', 'created_at','detail','route','model','process_type'
	];
	
	
	protected $dates = ['created_at'];
	
	
	public function user()
	{
		
		return $this->hasOne(User::class,'id','user_id')->select('id','email');
		
	}
	
	public function getCreatedAtAttribute($value)
	{
		
		$carbonDate = new Carbon($value);
		
		return $carbonDate->diffForHumans();
		
	}
	
}
