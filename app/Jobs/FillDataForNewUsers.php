<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use App\Models\User;
use App\Utilities\DataFillNewUsers;

class FillDataForNewUsers implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $fillNewuser, $user;

    public $tries = 5;

    public $timeout = 120;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct(DataFillNewUsers $fillNewuser, User $user)
    {
        $this->fillNewuser = $fillNewuser;
        $this->user=$user;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $this->fillNewuser->fill($this->user);
    }
}
