<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    BankAccountType,
    BankAccount
    };
use Illuminate\Support\Facades\DB;

class BankAccountController extends Controller
{

    public function index()
    {
        //Obtener las cotizaciones creadas hasta la fecha       
        $accountlist = BankAccount::with('bank_account')
                ->where('account_id',  Auth::user()->account_id)
                 ->where('isDeleted',  0)
               ->orderBy('created_at', 'desc')
               ->select('id', 'account_id','public_id',
               'user_id','bank_account_type','bank_account_name','bank_account_number',
               'initial_balance',
               'description','id'
               )->get();    

        return view('bank_account.index',compact('accountlist'));
  
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
        $bankaccountlist = BankAccountType::select('id', 'description') 
               ->get();
             
     return response()->json($bankaccountlist);

    }

    public function create()
    {
        return view('bank_account.create');        
    }
        
    public function store(Request $request)
    {   
            

        $this->validate($request, [     
            'bank_account_type' => 'required',              
            'bank_account_name' => 'required',
            'initial_balance' => 'required'  
        ]);

        $data = $request->except('bank_account');       

        $currentPublicId = BankAccount::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;


         $account = BankAccount::create($data);
        
        return response()
            ->json([
                'created' => true,
                'id' => $account->id
            ]);
    }

    public function show($id)
    {
        $account = BankAccount::with('bank_account')->where('account_id',  Auth::user()->account_id)->find($id);
                 
        if (!$account)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia creada en nuestra base de datos!', 
                'alert-type' => 'error'
            );

          return redirect('/bank_account')->with($notification);
        }
    
        return view('bank_account.show', compact('account'));
    }

    public function edit($id)
    {
        
        $account = BankAccount::with('bank_account')
        ->where('account_id',  Auth::user()->account_id)->find($id);        

         if (!$account)
        {
            $notification = array(
               'message' => 'No se encontró ninguna referencia creada en nuestra base de datos!', 
                'alert-type' => 'error'
            );
          return redirect('/bank_account')->with($notification);
        }

         return view('bank_account.edit', compact('account'));
         
         
    }

    public function update(Request $request, $id)
    {        
              
       $this->validate($request, [     
            'bank_account_type' => 'required',              
            'bank_account_name' => 'required',
            'initial_balance' => 'required'  
        ]);
       
        $account = BankAccount::findOrFail($id);
        
       $data = $request->except('bank_account'); 
        $data['user_id'] = Auth::user()->id;

        $account->update($data);

        return response()
            ->json([
                'updated' => true,
                'id' => $account->id              
            ]);
    }
    
    public function destroy($id)
    {
         $bank = BankAccount::findOrFail($id);

            $bank['isDeleted']=1;
            $bank['deleted_at']=$now = Carbon::now();
            $bank->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }
}
