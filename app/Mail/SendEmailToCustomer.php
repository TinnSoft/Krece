<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\Estimate;
use App\Utilities\Helper;
use PDF;
use Auth;
use App\Contracts\IPdfRepository;

class SendEmailToCustomer extends Mailable
{
    use Queueable, SerializesModels;
    
    public $body;
    
    public $subject;
    
    public $tries = 5;
    
    public $timeout = 120;
    
    protected $iPdfRepo;
    
    protected $public_id, $model;
    /**
    * Create a new message instance.
    *
    * @return void
    */
    public function __construct($body, $subject,$public_id,$model, IPdfRepository $iPdfRepo)
    {
        $this->body=$body;
        $this->subject=$subject;
        $this->iPdfRepo=$iPdfRepo;
        $this->public_id=$public_id;
        $this->model=$model;
    }
    
    /**
    * Build the message.
    *
    * @return $this
    */
    public function build()
    {
       
        $mypdf=$this->iPdfRepo->create($this->model, $this->public_id);
        
        return $this->markdown('emails.emailToCustomer')
                    ->subject('Envío de '.$this->subject)
                    ->attachData($mypdf->output(), 'documento.pdf');
    }
}