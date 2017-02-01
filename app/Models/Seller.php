<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Seller extends Model
{
    protected $table = 'seller';
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'name','dni','user_id','account_id','work_phone','private_phone','isEnabled','isDeleted','deleted_at','public_id','observations'
    ];
    
}
