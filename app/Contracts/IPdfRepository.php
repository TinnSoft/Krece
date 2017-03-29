<?php
namespace App\Contracts;


interface IPdfRepository  
{
    public function  create($model, $public_id);
}