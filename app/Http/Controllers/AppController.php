<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use Session;
use Response;
use App\Models\Account;

class AppController extends Controller
{
    public function index()
    {
        if(Auth::check()) {   
            return view('home');
        }
      
        return view('auth/login');
    }
     public static function setLogo()
    {
        $company = Account::with('company')
         ->where('id',  Auth::user()->account_id)  
         ->select('company_id')      
         ->first();
         $companylogo=null;
         if ($company)
         {
            $companylogo=$company->company->logo;        
         }
        Auth::user()->setAttribute('logo',$companylogo);
        session(['logo' => $companylogo]);

    }

    public function getLogo()
      {
        $logo=null;
       if(session()->has('logo'))
       {
            $logo=session()->get('logo');
       }

       return $logo;
      }

    

    public function login(Request $request)
    {
        
        $this->validate($request, [
            'email' => 'required|email|max:255',
            'password' => 'required|between:6,25'
        ]);

        $auth = Auth::attempt($request->only('email', 'password'), true);
        
        if(!$auth) {
            return redirect()
                ->back()
                ->withInput($request->only('email'))
                ->withErrors([
                    'email' => 'Correo invalido o password incompleto!'
                ]);
        }
        $this->setLogo();  

        return redirect()
            ->intended('/');
    }

    public function logout()
    {
        Auth::logout();
        Session::flush();
        Session::regenerate();

        return redirect('/');
    }

}
