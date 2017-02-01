<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    protected $table = 'currency';
    protected $dates = ['deleted_at'];
    
    protected $fillable=[
        'account_id','user_id','public_id','code_id','status_id'
    ];

    
    public function estimates()
    {
        return $this->hasMany(Estimate::class);
    }

   

}