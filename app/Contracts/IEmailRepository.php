<?php
namespace App\Contracts;


interface IEmailRepository  
{
    public function TemplateEmailToCustomer($process_type, $id);


}