<?php

namespace App\Utilities;
use Auth;
use Jenssegers\Date\Date;
use Carbon\Carbon;

trait DatesTranslator
{
    public function getCreatedAtAttribute($date)
    {
        return new Date($date);
        
    }
     public function getUpdatedAtAttribute($date)
    {
        return new Date($date);
    }
}