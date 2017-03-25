<?php

namespace App\Http\Controllers\Auth;

use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\RegistersUsers;
use App\Utilities\DataFillNewUsers;
use App\Jobs\SendWelcomeEmail;
use App\Jobs\FillDataForNewUsers;

class RegisterController extends Controller
{
   
    use RegistersUsers;

    /**
     * Where to redirect users after registration.
     *
     * @var string
     */
    protected $redirectTo = '/';

    protected $fillNewuser;
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(DataFillNewUsers $fillNewuser)
    {
        $this->middleware('guest');
        $this->fillNewuser = $fillNewuser;
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:user',
            'password' => 'required|min:6|confirmed',
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return User
     */
    protected function create(array $data)
    {
        $user= User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => bcrypt($data['password']),
        ]);

        //el envio de correo y la actualizacion y carga de datos de la applicación se realizan por medio de queues
        dispatch(new FillDataForNewUsers($this->fillNewuser, $user));

        dispatch(new SendWelcomeEmail($user));
       
        return $user;
    }

   
}
