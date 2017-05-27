<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\Account;
class Welcome extends Mailable
{
    use Queueable, SerializesModels;

    public $company;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($company)
    {
        $this->company=$company;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->markdown('emails.welcome')
        ->subject('Bienvenid@ a Krece')
        ->bcc('servicioalcliente@krece.co');
    }
}
