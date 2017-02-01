<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    protected $table = 'user';
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'name','last_name','email'
    ];
}
