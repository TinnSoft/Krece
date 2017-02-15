<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use Session;
use Response;
use App\Models\Account;
use App\Events\UserLoggedIn;
use App\Events\SettingsChanged;
use App\Events\RecordActivity;

class AppController extends Controller
{
    public function index()
    {
        if(Auth::check()) {                       
            return view('home',['title'=>'Bienvenido']);
        }
      
        return view('auth/login');
    }
   
    public function getLogo()
      {
        $logo=null;
       if(session()->has('logo'))
       {
            $logo=session()->get('logo');
       }
       else
       {
            event(new SettingsChanged()); 
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
       
        event(new UserLoggedIn());

        event(new RecordActivity('LogIn',Auth::user()->name.' ha iniciado sesion',
			'User','/profile/'.Auth::user()->id.'/edit'));	
        

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
