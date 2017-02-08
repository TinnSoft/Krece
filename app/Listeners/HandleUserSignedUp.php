<?php

namespace App\Listeners;

use App\Events\UserSignedUp;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\Account;
use Auth;

class HandleUserSignedUp
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param  SomeEvent  $event
     * @return void
     */
    public function handle(UserSignedUp $event)
    {
         //$user = Auth::user();        
         $this->setLogo();   
    }

    public static function setLogo()
    {
        $company = Account::with('company')
         ->where('id',  Auth::user()->account_id)  
         ->select('company_id')      
         ->first();
         $companylogo=null;
         if ($company)
         {
            $companylogo=$company->company->logo;        
         }       
        session(['logo' => $companylogo]);

    }

}
