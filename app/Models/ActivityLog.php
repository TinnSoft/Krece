<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ActivityLog extends Model
{
    protected $table = 'activity_log';
    
    protected $fillable = [
        'account_id','user_id', 'created_at','detail','route','model','process_type'
    ];

   


}
