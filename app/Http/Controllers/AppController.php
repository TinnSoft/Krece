<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Auth;
use Session;
use Response;
use App\Models\Account;
use App\Models\InvoiceSaleOrder;
use App\Models\InvoiceSupplierOrder;
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
      
        //dd($this->graph_info());

             return view('main.dashboard',
                ['title'=>'Bienvenido',
                "historical"=>$this->userActivity_some(),
               "income"=>$this->income_consolidate(),
               "outcome"=>$this->outcome_consolidate(),
               "month_list"=>$this->graph_info()
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
        $totalMonth= InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereMonth('created_at', '=', date('m'))
                                ->sum('total');
        
         $totalYear= InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereYear('created_at', '=', date('Y'))
                                ->sum('total');

        $totalDay= InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereDay('created_at', '=', date('d'))
                                ->sum('total');

        $totalWeek= InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->where('created_at','>=',Carbon::now()->subWeeks(1)->toDateString())                           
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
        $totalMonth= InvoiceSupplierOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereMonth('created_at', '=', date('m'))
                                ->sum('total');
        
         $totalYear= InvoiceSupplierOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereYear('created_at', '=', date('Y'))
                                ->sum('total');

        $totalDay= InvoiceSupplierOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereDay('created_at', '=', date('d'))
                                ->sum('total');

        $totalWeek= InvoiceSupplierOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->where('created_at','>=',Carbon::now()->subWeeks(1)->toDateString())   
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

        $month=InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereYear('created_at', '=', date('Y'))
                                ->select(DB::raw('Month(created_at) as month'))
                                ->groupBy('month')
                                ->get();
        $list=[];                    
        foreach ($month as $m)
        {
            $list[]= self::monthName($m->month);
        }

         $dta=InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->where('created_at','>=',Carbon::now()->subWeeks(1)->toDateString()) 
                                ->select(DB::raw('day(created_at) as day'))   
                                ->groupBy('day')                       
                                ->get();           
            
        $listWeekDays=[];                    
        foreach ($dta as $m)
        {
            $listWeekDays[]= self::dayName($m->day);
        }

        $dtamont=InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
                                ->where('isDeleted',0)
                                ->whereMonth('created_at', '=', date('m'))
                                ->select(DB::raw('day(created_at) as day'))   
                                ->groupBy('day')                       
                                ->get();           
            
        $listmonthDays=[];                    
        foreach ($dtamont as $m)
        {
            $listmonthDays[]= $m->day;
        }

        $data= collect([
            "yearByMonth"=>$list,
            "weekByDayName_income"=> $listWeekDays,
            "monthByDay_income"=> $listmonthDays
         ]); 
        
        
        return  $data;
    }

      public static function monthName($month)
    {        
        setlocale(LC_TIME, 'spanish');           
        return ucwords(strftime("%B",mktime(0, 0, 0, $month, 1, 2000)));
    }

     public static function dayName($day)
    {        
        setlocale(LC_TIME, 'spanish');           
        return ucwords(strftime("%A",mktime(0, 0, 0, 0, $day, 2000)));
    }

}
