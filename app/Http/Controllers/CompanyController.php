<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    Company,
    CompanyRegime,
    Account
};

class CompanyController extends Controller
{
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required',
            'regime_id'=>'required|exists:company_regime,id'
        ]);

        $data = $request->all();  
       
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;   

        if ($data['isProvider']==true)
        {
            $data['isProvider']=1;
        }
         if ($data['isCustomer']==true)
        {
            $data['isCustomer']=1;
        }
        
       $contact = Contact::create($data);
        $contact->contact_others()->saveMany($items);

     
        return response()
            ->json([
                'created' => true,
                'id' => $contact->public_id
            ]);
    }


    public function edit($id)
    {
        
          $company = Account::with('company')
         ->where('id',  Auth::user()->account_id)  
         ->select('company_id')      
         ->first();

         $companyRegime = CompanyRegime::select( 'id','value')->get();    
        
         if (!$company->company)
        {
            $notification = array(
                'message' => 'No se encontró ninguna coincidencia en nuestra base de datos!', 
                'alert-type' => 'error'
            );
        }
  
         return view('company.edit', compact('company','companyRegime'));
         
    }

    public function update(Request $request, $id)
    {        
         
         $this->validate($request, [     
            'name' => 'required',
            'regime_id'=>'required|exists:company_regime,id'
        ]);
        
        $company = Company::findOrFail($id);
        $data = $request->all();       
        
        //$header = $this->toBase64($request->file('logo'));

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
    
        
        return response()
            ->json([
                'updated' => true          
            ]);
    }
     private function update_logo(Request $request)
    {
        $filename=null;
        if ($request->hasFile('avatar'))
        {
            $logo=$request->file('logo');            
            $filename=time().'.'.$logo->getClientOriginalExtension();
            Image::make($logo)->resize(178,51)->save(public_path('/uploads/logos/'.$filename));           
        }
        return $filename;
        //$data = File::get($file->path());
        //$base64 = 'data:image/' . $file->extension() . ';base64,' . base64_encode($data);
        //return $base64;
    }
   
}
