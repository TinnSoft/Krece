<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    protected $table = 'company';
    protected $dates = ['deleted_at'];
    
    protected $fillable = [
        'email','name','identification','address','phone','website','regime_id','logo',
        'decimal_precision','decimal_separator','city'
    ];



     public function company_regime()
    {
      return $this->hasOne(CompanyRegime::class,'id','regime_id');
    }

   
}
