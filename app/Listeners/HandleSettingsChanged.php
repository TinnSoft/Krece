<?php

namespace App\Listeners;

use App\Events\SettingsChanged;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\Account;
use Auth;

class HandleSettingsChanged
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
    public function handle(SettingsChanged $event)
    {     
         $this->setLogo();  
    }

    //Adiciona el logo de la compañia en el objeto session
    public static function setLogo()
    {
        $company = Account::where('id',  Auth::user()->account_id) 
        ->select('logo')
         ->first();
         $companylogo=null;
         if ($company)
         {
            $companylogo=$company->logo;   
            session(['logo' => $companylogo]);     
         }       

    }

}
