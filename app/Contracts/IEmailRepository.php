<?php
namespace App\Contracts;


interface IEmailRepository  
{
    public function TemplateEmailToCustomer($model, $id);


}