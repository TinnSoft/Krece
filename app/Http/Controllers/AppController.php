<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Auth;
use Session;
use Response;
use App\Models\Account;
use App\Models\InvoiceSaleOrder;
use App\Models\Bill;
use App\Models\ActivityLog;
use App\Events\UserLoggedIn;
use App\Events\SettingsChanged;
use App\Events\RecordActivity;
use App\Utilities\Helper;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class AppController extends Controller
{

    public function index()
    {
        if(Auth::check()) {      

             return view('main.dashboard',
                ['title'=>'Bienvenido',
                "historical"=>$this->userActivity_some(),
               "income"=>$this->income_consolidate(),
               "outcome"=>$this->outcome_consolidate(),
               "graph_data"=>$this->graph_info()
            ]);
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

    public static function userActivity_some()
    {
        return ActivityLog::with('user')
                ->where('account_id',Auth::user()->account_id)
                ->select('detail','route','created_at','user_id')
                ->orderBy('created_at', 'desc')
                ->take(7)
                ->get();
    }

    public static function income_consolidate()
    {
        $totalMonth= InvoiceSaleOrder::AccountID(0)
                                ->whereMonth('created_at', '=', date('m'))
                                ->sum('total');
        
         $totalYear= InvoiceSaleOrder::AccountID(0)
                                ->whereYear('created_at', '=', date('Y'))
                                ->sum('total');

        $totalDay= InvoiceSaleOrder::AccountID(0)
                                ->whereDay('created_at', '=', date('d'))
                                ->sum('total');

        $totalWeek= InvoiceSaleOrder::AccountID(0)
                                 ->where(DB::Raw('week(created_at)'), '=', Carbon::now()->weekOfYear)                       
                                ->sum('total');                     
        
         $data= collect(["day"=>$totalDay,
         "month"=> $totalMonth,
         "year"=> $totalYear,
         "week"=>$totalWeek
         ]);       
                         
        return $data;
    }

    public static function outcome_consolidate()
    {
        $totalMonth= Bill::AccountID(0)
                                ->whereMonth('created_at', '=', date('m'))
                                ->sum('total');
        
         $totalYear= Bill::AccountID(0)
                                ->whereYear('created_at', '=', date('Y'))
                                ->sum('total');

        $totalDay= Bill::AccountID(0)
                                ->whereDay('created_at', '=', date('d'))
                                ->sum('total');

        $totalWeek= Bill::AccountID(0)
                                ->where(DB::Raw('week(created_at)'), '=', Carbon::now()->weekOfYear)
                                ->sum('total');                     

         $data= collect(["day"=>$totalDay,
         "month"=> $totalMonth,
         "year"=> $totalYear,
         "week"=>$totalWeek
         ]);       
                         
        return $data;
    }

    public static function graph_info()
    {

         $dtabyWeek=InvoiceSaleOrder::AccountID(0)
                                 ->where(DB::Raw('week(created_at)'), '=', Carbon::now()->weekOfYear)
                                ->select(DB::raw('day(created_at) as day'),DB::raw('sum(total) as total'))   
                                ->groupBy('day')                       
                                ->get();    
     
         $dtabyWeek_outcome=Bill::AccountID(0)
                                 ->where(DB::Raw('week(created_at)'), '=', Carbon::now()->weekOfYear)
                                ->select(DB::raw('day(created_at) as day'),DB::raw('sum(total) as total'))   
                                ->groupBy('day')                       
                                ->get();
        
        $totalbyday_permonth= InvoiceSaleOrder::AccountID(0)
                                ->whereMonth('created_at', '=', date('m'))
                                ->select(DB::raw('day(created_at) as day'),DB::raw('sum(total) as total'))   
                                 ->groupBy('day')                       
                                ->get();

        $totalbyday_permonth_out= Bill::AccountID(0)
                                ->whereMonth('created_at', '=', date('m'))
                                ->select(DB::raw('day(created_at) as day'),DB::raw('sum(total) as total'))   
                                 ->groupBy('day')                       
                                ->get();
        
        $totalbyMonth_perYear_in= InvoiceSaleOrder::AccountID(0)
                                ->whereYear('created_at', '=', date('Y'))
                               ->select(DB::raw('month(created_at) as month'),DB::raw('sum(total) as total'))   
                                 ->groupBy('month')                       
                                ->get();

        $totalbyMonth_perYear_out= Bill::AccountID(0)
                                ->whereYear('created_at', '=', date('Y'))
                               ->select(DB::raw('month(created_at) as month'),DB::raw('sum(total) as total'))   
                                 ->groupBy('month')                       
                                ->get();

             
        //income validation
        //obtener rango de dias de la semana actual por numero
        $startDate = Carbon::now()->startOfWeek();
        $endDate = Carbon::now()->endOfWeek();

        $WeekDataArray=[];
        $WeekDataArray_out=[];
        while($startDate<= $endDate) 
          {
             
            $WeekDataArray2=$dtabyWeek->where('day',$startDate->copy()->day)->pluck('total');
             $WeekDataArray2_out=$dtabyWeek_outcome->where('day',$startDate->copy()->day)->pluck('total');  
            if (count($WeekDataArray2)>0)
            {
                $WeekDataArray[]=$WeekDataArray2[0];
            }
            else{
                 $WeekDataArray[]=0;
            }

            if (count($WeekDataArray2_out)>0)
            {
                $WeekDataArray_out[]=$WeekDataArray2_out[0];
            }
            else{
                 $WeekDataArray_out[]=0;
            }

            $startDate->addDay();
           
          }
        
          //obtener los labels para el mes actual
        $startDayMonth = Carbon::now()->startOfMonth();
        $endDayMonth = Carbon::now()->endOfMonth();
        $daysLabels=[];
        $DataByDayForMonth_in=[];
        $DataByDayForMonth_out=[];

        while($startDayMonth<= $endDayMonth) 
        {
            $data=$totalbyday_permonth->where('day',$startDayMonth->copy()->day)->pluck('total');
            $data_out=$totalbyday_permonth_out->where('day',$startDayMonth->copy()->day)->pluck('total');
              
            if (count($data)>0)
            {
                $DataByDayForMonth_in[]=$data[0];
            }
            else{
                 $DataByDayForMonth_in[]=0;
            }
               
            if (count($data_out)>0)
            {
                $DataByDayForMonth_out[]=$data_out[0];
            }
            else{
                 $DataByDayForMonth_out[]=0;
            }

            $daysLabels[]=$startDayMonth->copy()->day;
             $startDayMonth->addDay(); 
        }
       
        $DataBymont_peryear_in=[];
        $DataBymont_peryear_out=[];
       for ($i = 1; $i <= 12; $i++) 
            {
                $data_in=$totalbyMonth_perYear_in->where('month',$i)->pluck('total');
                $data_out=$totalbyMonth_perYear_out->where('month',$i)->pluck('total');

                 if (count($data_in)>0)
                    {
                        $DataBymont_peryear_in[]=$data_in[0];
                    }
                    else{
                        $DataBymont_peryear_in[]=0;
                    }
                    
                    if (count($data_out)>0)
                    {
                        $DataBymont_peryear_out[]=$data_out[0];
                    }
                    else{
                        $DataBymont_peryear_out[]=0;
                    }
            }

        $data= collect([            
            "weekData_income"=> $WeekDataArray,
            "weekData_outcome"=> $WeekDataArray_out,
            "labels_current_month"=> $daysLabels,
            "data_by_day_current_month_in"=>$DataByDayForMonth_in,
            "data_by_day_current_month_out"=>$DataByDayForMonth_out,
            "DataBymont_peryear_in"=>$DataBymont_peryear_in,
            "DataBymont_peryear_out"=>$DataBymont_peryear_out
         ]); 


        return  $data;
    }

}
