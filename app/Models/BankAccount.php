<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Utilities\DatesTranslator;
use Carbon\Carbon;

class BankAccount extends Model
{
    use DatesTranslator;

    protected $table = 'bank_account';    
    
    protected $fillable=[
        'public_id','bank_account_type_id','bank_account_name','account_id','user_id',
        'bank_account_number','initial_balance','description'
    ];
    protected $dates = ['deleted_at'];
    
    public function bank_account()
    {
        return $this->hasOne(BankAccountType::class,'id','bank_account_type_id');
    }

}
