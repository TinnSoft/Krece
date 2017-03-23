<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Retention extends Model
{
    protected $table = 'retention';
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'account_id','user_id','name','value','description','type_id','public_id'
    ];
   
     public function retention_type()
    {
        return $this->belongsTo(RetentionType::class,'type_id','id')->select(array('id', 'name'));
    }   
    
}
