<?php

namespace App\Listeners;

use App\Events\UserLoggedIn;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\Account;
use App\Models\User;
use Auth;
use Carbon\Carbon;

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
    public function handle(UserLoggedIn $event)
    {
         //$user = Auth::user();        
         $this->setLogo();  
         $this->updateLoginInfo(); 
    }

    public static function updateLoginInfo()
    {
        $userdata = User::where('id',  Auth::user()->id)  
                    ->find(1);
        if($userdata)
        {
            $userdata->last_login = Carbon::now();
            $userdata->save();
        }
    }
    //Adiciona el logo de la compañia en el objeto session
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
