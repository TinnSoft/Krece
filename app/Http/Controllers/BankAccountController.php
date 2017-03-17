<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    BankAccountType,
    BankAccount,
    ResolutionNumber,
    Category,
    Payment
    };
use Illuminate\Support\Facades\DB;
use App\Utilities\Helper;
use App\Repositories\PaymentRepository;
use App\Events\RecordActivity;

class BankAccountController extends Controller
{

    protected $paymentRepo;

    public function __construct(PaymentRepository $paymentRepo)
    {
        $this->paymentRepo = $paymentRepo;
    }

    public function index()
    {
      
        return view('bank_account.index');
  
    }
    public function bankList()
    {
        $baseInfo=[
        'bank'=>Helper::bank_account()
        ];        
        return response()->json($baseInfo);
    }

    public function bank_transaction_history($bank_id)
    {
      return $this->paymentRepo->getTransactions($bank_id,'bank_account_id');
    }
    
    public function CreateBankTransference(Request $request)
    {

        $data=$request->all();
        $dataIN=$request->all();
        //No debe adicionarse transferencias entre la misma cuenta
        if ($data['account_from']==$data['account_to'])
        {
            return response()
            ->json([
                'created' => true
            ]);
        }
        
        $data['payment_out_to_category']=[];
         
         $category_id=Category::where('account_id',Auth::user()->account_id)
                                    ->where('name','=','Transferencias bancarias')
                                    ->select('id')
                                    ->take(1)
                                    ->get();

         $category_id= $category_id[0]->id;
        
        $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'out-come')['number'];
        $data['isInvoice'] = 0;
        $data['payment_method_id'] = 3;
        $data['currency_code']=CURRENCY_CODE_DEFAULT;
        $data['bank_account_id']=$data['account_from'];

        //registrar pago en tabla payments  de tipo EGreso      
        $detailPayment=$data['payment_out_to_category'];
        $detailPayment['category_id']=$category_id;
        $detailPayment['unit_price']=$data['amount'];
        $detailPayment['quantity']=1;
        $detailPayment['observations']=$data['observations'];
        $detailPayment2[]=$detailPayment;
        
        $payment=$this->paymentRepo->storeCategoryPayment(
                    $data,
                    $detailPayment2,
                    Payment::class,                   
                    PAYMENT_OUTCOME_TYPE
                );

        if($payment) //retornar errores por validación
            {               
                $hasErrorr=collect($payment)->get('original');
                if ($hasErrorr)
                {
                     return response()
                        ->json([
                            'created' => false
                        ]);
                }               
            }   
       

        $parentID=$payment->id;
        

        //Actualiza parent id del egreso
        Payment::where('id', $parentID)
          ->update(['parent_id' => $parentID]);

         //registrar entrada en tabla payments  de tipo INGreso   
        $dataIN['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'in-come')['number'];
        $dataIN['isInvoice'] = 0;
        $dataIN['payment_method_id'] = 3;
        $dataIN['currency_code']=CURRENCY_CODE_DEFAULT;
        $dataIN['bank_account_id']=$dataIN['account_to'];   
        $dataIN['payment_in_to_category']=[];
        $detailPaymentIN=$dataIN['payment_in_to_category'];
        $detailPaymentIN['category_id']=$category_id;
        $detailPaymentIN['unit_price']=$dataIN['amount'];
        $detailPaymentIN['quantity']=1;
        $detailPaymentIN['observations']=$dataIN['observations'];
        $detailPaymentIN2[]=$detailPaymentIN;
        
            $payment=$this->paymentRepo->storeCategoryPayment(
                    $dataIN,
                    $detailPaymentIN2,
                    Payment::class,                   
                    PAYMENT_INCOME_TYPE
                );

          if($payment) //retornar errores por validación
            {               
                $hasErrorr=collect($payment)->get('original');
                if ($hasErrorr)
                {
                     return response()
                        ->json([
                            'created' => false
                        ]);
                }               
            }   
        
        //Actualiza parent id del ingreso
         Payment::where('id', $payment->id)
          ->update(['parent_id' => $parentID]);

        //Incrementar los consecutivos de la resolución
        ResolutionNumber::where('key', 'out-come')->increment('number');
        ResolutionNumber::where('key', 'in-come')->increment('number');

        $AccountNameFrom = BankAccount::where('account_id',  Auth::user()->account_id)
                            ->where('id',$data['account_from'])->select('bank_account_name')->get()[0]->bank_account_name;

         $AccountNameTo = BankAccount::where('account_id',  Auth::user()->account_id)
                            ->where('id',$data['account_to'])->select('bank_account_name')->get()[0]->bank_account_name;
        
        //Guardar historial
        event(new RecordActivity('Create','Se realizó una transferencia desde la cuenta'. $AccountNameFrom .', hacia la cuenta '.$AccountNameTo,
        'BankAccount',null));

        //actualiza el monto del banco al que va dirijida la transferencia
        DB::table('bank_account')
        ->where('id', $data['account_to'])
        ->increment('initial_balance', $data['amount']);

         //actualiza el monto del banco origen de la transferencia 
        DB::table('bank_account')
        ->where('id', $data['account_from'])
        ->decrement('initial_balance', $data['amount']);

        return response()
            ->json([
                'created' => true
            ]);
        
    }

     public function BankAccountIndex()
    {
       $accountlist = BankAccount::with('bank_account')
                ->where('account_id',  Auth::user()->account_id)
                 ->where('isDeleted',  0)
               ->orderBy('created_at', 'desc')
               ->select('id', 'account_id','public_id',
               'user_id','bank_account_type_id','bank_account_name','bank_account_number','isDefault',
               'initial_balance',
               'description','id'
               )->get(); 

        return response()->json($accountlist);  
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
            'bank_account_type_id' => 'required',              
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
      

        $account = BankAccount::where('account_id',  Auth::user()->account_id)
        ->select('id','bank_account_type_id','bank_account_name','initial_balance')
        ->find($id);
                 
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
            'bank_account_type_id' => 'required',              
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

    //Eliminar las transacciones de transferencia realizadas en la seccion bancos
    //se elimina de la tabla payment,
    //Se suprimen los valores de los pagos realizados y se le devuelven al saldo inicial
    public function deleteBankTransaction($id)
    {
         $bank = Payment::findOrFail($id);

            $bank['isDeleted']=1;
            $bank['deleted_at']=$now = Carbon::now();
            $bank->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }
}
