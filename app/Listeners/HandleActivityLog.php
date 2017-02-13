<?php

namespace App\Listeners;

use App\Events\SettingsChanged;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\Account;
use Auth;
use App\Repositories\ActivityRepository;
use App\Events\RecordActivity;

class HandleActivityLog
{
    /**
     * Create the event listener.
     *
     * @return void
     */
     protected $activityRepo;

    public function __construct(ActivityRepository $activityRepo)
    {
        $this->activityRepo = $activityRepo;
    }

    /**
     * Handle the event.
     *
     * @param  SomeEvent  $event
     * @return void
     */

     public function handle(RecordActivity $event)
    {    
        
         $this->activityRepo->create(
            $event   
            );       
    }

}
