<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use App\Models\{
    AccountRegime,
    Account
};
use App\Events\SettingsChanged;
use App\Http\Controllers\AppController;
use App\Utilities\Helper;

class AccountController extends Controller
{
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required',
            'regime_id'=>'required|exists:account_regime,id'
        ]);

        $data = $request->all();  
       
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;   
        $data['isProvider']=Helper::convertBooleanToInt($data['isProvider']);
        $data['isCustomer']=Helper::convertBooleanToInt($data['isCustomer']);
               
        $contact = Contact::create($data);

        $routecall= (new AppController)->setLogo();

        return response()
            ->json([
                'created' => true
            ]);
    }


    public function edit($id)
    {      
          $company = Account::where('id',  Auth::user()->account_id)  
         ->select('name','identification','address','phone','website','city','regime_id','logo',
         'decimal_precision','decimal_separator','id','email')      
         ->first();

         
         $companyRegime = AccountRegime::select( 'id','value')->get();    
        
         if (!$company->company)
        {
            $notification = array(
                'message' => 'No se encontró ninguna coincidencia en nuestra base de datos!', 
                'alert-type' => 'error'
            );
        }
  
         return view('account.edit', compact('company','companyRegime'));         
    }

    public function update(Request $request, $id)
    {        
         
         $this->validate($request, [     
            'name' => 'required',
            'regime_id'=>'required|exists:account_regime,id'
        ]);
        
           
        $company = Account::findOrFail( Auth::user()->account_id);

        $data = $request->all();       
            
        try{
            $company->update($data);  
              
        }
        catch (\exception $e){
            return response()
            ->json([
                'updated' => false,
                'message' => "No se pudo actualizar correctamente el contacto, intente de nuevo"            
            ]);
        }
        
        
        //Actualiza la session con el nuevo logo
        try{
          event(new SettingsChanged());
        }
        catch(\exception $e){           
        }

        return response()
            ->json([
                'updated' => true          
            ]);
    }
    
   
}
