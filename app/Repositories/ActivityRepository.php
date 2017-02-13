<?php

namespace App\Repositories;
use Auth;
use Illuminate\Support\Facades\DB;

class ActivityRepository
{
    public function create($model)
    {
        
       DB::transaction(function() use ($model) {
          
           DB::table('activity_log')->insert(
                ['account_id' => Auth::user()->account_id, 
                'user_id' => Auth::user()->id,
                'detail'=>$model->detail,
                'process_type'=>$model->transactionType,
                'model'=>$model->model,
                'route'=>$model->route
                ]
            );
      
      
    });   
    }
}