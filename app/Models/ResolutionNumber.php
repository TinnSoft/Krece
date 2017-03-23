<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ResolutionNumber extends Model
{   
    protected $dates = ['deleted_at'];
    protected $table = 'resolution_numbers';
    protected $fillable=['account_id','key','account_id','prefix','number','text'];
}
