<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\Profile;

class ProfileController extends Controller
{

   
    public function BaseInfo($id)
    {  
        
               $profileList = Profile::select('id', 'name','last_name','email')              
               ->findOrFail($id);
        

         return response()->json($profileList);
    }

     public function edit($id)
    {    
         $profileList = Profile::select('id', 'name','last_name','email')              
               ->where('account_id',  Auth::user()->account_id)               
               ->where('id',  Auth::user()->id)
               ->find($id);

        if (!$profileList)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia creada en nuestra base de datos!', 
                'alert-type' => 'error'
            );
          return redirect('profile.edit')->with($notification);
        }

         return view('profile.edit', compact('profileList'));
    }


   public function update(Request $request, $id)
    {       
      
        $this->validate($request, [     
            'name' => 'required',               
            'last_name' => 'required',
            'email' => 'required|email',
        ]);
       
        $profile = Profile::findOrFail($id);    
        //$data = $request->except('profile_type'); 
        $profile->update($request->all());
        
        return response()
            ->json([
                'updated' => true,
                'id' => $profile->id              
            ]);
    }

}
