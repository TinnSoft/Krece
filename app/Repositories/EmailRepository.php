<?php

namespace App\Repositories;
use Auth;
use App\Models\Account;
use Illuminate\Support\Facades\DB;
use App\Contracts\IEmailRepository;
use App\Utilities\Helper;
use Carbon\Carbon;

class EmailRepository implements IEmailRepository
{
    public function TemplateEmailToCustomer($process_type, $id)
        {
            $_text1=null;
            $_text2=null;

            switch ($process_type)
            {
                case 1; //estimate
                    $_text1='la cotización # ';
                    $_text2='Cotización # ';
                    break;
                case 2; //Invoice
                    $_text1='la factura de venta';
                    break;           
                    
            };

            $accountDetail=Account::where('id',Auth::user()->id)->select('email','phone','name')->first();

            $to='';
            $subject=$_text2.$id;

            $body='Cordial saludo, <br/><br/>';
            $body .= 'En este correo adjuntamos <strong>'.$_text1.$id.'</strong> con fecha '.Helper::setCustomDateFormat(Carbon::now());
            $body .='. Agradecemos por utilizar los servicios de '.$accountDetail->name.' .';
            $body .= '<br>';
            $body .= 'Cualquier inquietud le atenderemos en el teléfono '.$accountDetail->phone.'.';
            $body .= '<br/><br/>';
            $body .= 'Si desea reportar alguna novedad, por favor hacerlo al correo: <strong> '.$accountDetail->email.'</strong>';
            $body .= '<br/><br/>';
            $body .= 'Atentamente,';
            $body .= '<br/><br/>';
            $body .= $accountDetail->name;
            $body .= '<br/><br/>';

            
            $additional_emails='';

            $emailTemplate=[
                'to'=>$to,
                'subject'=>$subject,
                'body'=>$body,
                'additional_emails'=>$additional_emails
            ];

            return $emailTemplate;
        }
}