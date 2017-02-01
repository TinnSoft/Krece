<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Contact_others extends Model
{
    protected $table = 'contact_others';
    protected $dates = ['deleted_at'];
    
    protected $fillable = [
        'user_id','public_id','account_id','name','last_name','email','phone','phone_mobile','notify'
    ];


     public function contact()
    {
        return $this->belongsTo(Contact::class);
    }
}
