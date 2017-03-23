<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tax extends Model
{
    protected $table = 'tax';
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'account_id','public_id','user_id','name','amount','description','type_id','isEditable'
    ];
   
     public function tax_type()
    {
        return $this->belongsTo(TaxType::class,'type_id','id')->select(array('id', 'name'));
    }   
    
}
