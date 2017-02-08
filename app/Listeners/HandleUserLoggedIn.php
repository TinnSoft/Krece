<?php

namespace App\Listeners;

use App\Events\UserLoggedIn;
use App\Events\SettingsChanged;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\Account;
use App\Models\User;
use Auth;
use Carbon\Carbon;

class HandleUserLoggedIn
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
         $this->updateLoginInfo(); 
         event(new SettingsChanged());
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
  

}
