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

class SendEmailToCustomer extends Mailable
{
    use Queueable, SerializesModels;

    public $body;
    public $subject;

    public $tries = 5;

    public $timeout = 120;


    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($body, $subject)
    {
        $this->body=$body;
        $this->subject=$subject;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $id=34;
        

        $withContainer=['account','detail','list_price','seller'];
        $estimate = Estimate::with($withContainer)
            ->where('account_id',  1)
                ->where('isDeleted',0)
                 ->where('public_id',  $id)
            ->GetSelectedFields()
            ->first();
           
           
        $estimate=Helper::_InvoiceFormatter($estimate);
        $taxes=Helper::getTotalTaxes($estimate->public_id,'estimate','estimate_detail');
        $mypdf = PDF::loadView('pdf.estimate', ['estimate' => $estimate, 'taxes'=>$taxes]);
        
        return $this->markdown('emails.emailToCustomer')
        ->subject('Envío de '.$this->subject)
        ->attachData($mypdf->output(), 'invoice.pdf');
    }
}
