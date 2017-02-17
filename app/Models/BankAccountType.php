<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Auth;
class BankAccountType extends Model
{   
   
    protected $table = 'bank_account_type';

     public function bank()
    {
        return $this->hasMany(BankAccount::class,'bank_account_type_id','id')
            ->where('account_id',  Auth::user()->account_id)
            ->where('isDeleted',  0)
            ->orderBy('created_at', 'asc')
            ->select('id','bank_account_type_id','bank_account_name');
        
    }
}
