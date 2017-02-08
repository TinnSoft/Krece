<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Account extends Model
{
    protected $table = 'account';
    protected $dates = ['deleted_at'];
    
    protected $fillable = [
        'email','name'
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

     public function company()
    {
        return $this->hasOne(Company::class,'id','company_id')->select(array( 'id','name','identification','address',
                      'phone','website','email','regime_id','logo',
                      'decimal_precision','decimal_separator','city'));
    }
}
