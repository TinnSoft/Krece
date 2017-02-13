<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;


class EstimateWasUpdated
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    
    public $transactionType, $detail, $model, $route;
    
    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($transactionType, $detail, $model, $route)
    {
        $this->transactionType = $transactionType;
        $this->detail = $detail;
        $this->model = $model;
        $this->route = $route;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('channel-name');
    }
}
