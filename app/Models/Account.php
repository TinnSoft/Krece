<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Account extends Model
{
    protected $table = 'account';
    protected $dates = ['deleted_at'];
    
    protected $fillable = [
        'email','name', 'identification','address','phone','website','regime_id','logo',
        'decimal_precision','decimal_separator','city'
    ];

     public function rules()
    {
        return [
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:account',
        ];
    }

     public function users()
    {
        return $this->hasMany(User::class);
    }

    
     public function account_regime()
    {
      return $this->hasOne(AccountRegime::class,'id','regime_id');
    }

      public function estimates()
    {
        return $this->hasMany(Estimate::class);
    }

}
