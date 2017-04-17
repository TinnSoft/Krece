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
use App\Models\Payment;
use App\Events\UserLoggedIn;
use App\Events\SettingsChanged;
use App\Events\RecordActivity;
use App\Utilities\Helper;
use Carbon\Carbon;
use DB;

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
            "graph_data"=>$this->graph_info(),
            'pie_data'=>$this->pie_info()
            ]);
        }
        
        return view('auth/login');
    }
    
    private static function pie_info_total($isToday,$isWeek,$isMonth, $isYear)
    {
       
          $data=   DB::table('payment')
                ->join('category_payment', 'category_payment.payment_id', '=', 'payment.id')
                ->join('category','category.id','=','category_payment.category_id')
                ->where('payment.account_id',Auth::user()->account_id)
                ->where('payment.type_id','=','eg')
                ->where('payment.isDeleted',0)
                ->when($isMonth, function ($query) {
                    return $query->whereMonth('payment.created_at', '=', date('m'));
                })
                ->when($isToday, function ($query) {
                    return $query->whereDay('payment.created_at', '=', date('d'));
                })
                ->when($isYear, function ($query) {
                    return $query->whereYear('payment.created_at', '=', date('Y'));
                })
                ->when($isWeek, function ($query) {
                    return $query ->where(DB::Raw('week(payment.created_at)'), '=', Carbon::now()->weekOfYear) ;
                })
                ->select('category.name',DB::raw('SUM(category_payment.total + IFNULL(category_payment.tax_total,0)) AS total'))
                ->groupBy('category.name')
                ->orderBy('total','desc')
                ->take(5)
                ->get();

             $data_others=   DB::table('payment')
                ->join('category_payment', 'category_payment.payment_id', '=', 'payment.id')
                ->join('category','category.id','=','category_payment.category_id')
                ->where('payment.account_id',Auth::user()->account_id)
                ->where('payment.type_id','=','eg')
                ->where('payment.isDeleted',0)
                ->when($isMonth, function ($query) {
                    return $query->whereMonth('payment.created_at', '=', date('m'));
                })
                ->when($isToday, function ($query) {
                    return $query->whereDay('payment.created_at', '=', date('d'));
                })
                ->when($isYear, function ($query) {
                    return $query->whereYear('payment.created_at', '=', date('Y'));
                })
                ->when($isWeek, function ($query) {
                    return $query ->where(DB::Raw('week(payment.created_at)'), '=', Carbon::now()->weekOfYear) ;
                })
                ->select('category.name',DB::raw('SUM(category_payment.total + IFNULL(category_payment.tax_total,0)) AS total'))
                ->groupBy('category.name')
                ->orderBy('total','desc')
                ->skip(5)->take(10000)
                ->get()->sum('total');
           
            if ($data_others>0)
            {
                $data_others=['name'=>'Otros','total'=>$data_others];
                $data->push($data_others);
                $data->all();
            }
            
            if ($data->isEmpty())
            {
                return collect(['name'=>['No hay datos suficientes'], 'total'=>[0]]);
            }

            return collect(['name'=>$data->pluck('name'), 'total'=>$data->pluck('total')]);
    }

    private static function pie_info()
    {
        $mainClass=new AppController();

        $byDay=$mainClass->pie_info_total(true,false,false,false);    
        
        $byWeek=$mainClass->pie_info_total(false,true,false,false);
    
        $byMonth= $mainClass->pie_info_total(false,false,true,false);   
        
        $byYear= $mainClass->pie_info_total(false,false,false,true);
       
         $data= collect([
            "isToday"=> $byDay,
            "isWeek"=> $byWeek,
            "isMonth"=> $byMonth,
            "isYear"=> $byYear
        ]);
        
        return $data;

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
    
    private static function _total($model, $isToday,$isWeek,$isMonth, $isYear, $kindOfProcess)
    {
        //total general
        $total= $model::AccountID(0)
        ->when($isMonth, function ($query) {
            return $query->whereMonth('created_at', '=', date('m'));
        })
        ->when($isToday, function ($query) {
            return $query->whereDay('created_at', '=', date('d'));
        })
        ->when($isYear, function ($query) {
            return $query->whereYear('created_at', '=', date('Y'));
        })
        ->when($isWeek, function ($query) {
            return $query ->where(DB::Raw('week(created_at)'), '=', Carbon::now()->weekOfYear) ;
        })
        ->sum('total');
        
        //total pagos a la categoría
        $totalPaymentCategory=   DB::table('payment')
        ->join('category_payment', 'category_payment.payment_id', '=', 'payment.id')
        ->where('payment.account_id',Auth::user()->account_id)
        ->where('payment.type_id','=',$kindOfProcess)
        ->where('payment.isDeleted',0)
        ->when($isMonth, function ($query) {
            return $query->whereMonth('payment.created_at', '=', date('m'));
        })
        ->when($isToday, function ($query) {
            return $query->whereDay('payment.created_at', '=', date('d'));
        })
        ->when($isYear, function ($query) {
            return $query->whereYear('payment.created_at', '=', date('Y'));
        })
        ->when($isWeek, function ($query) {
            return $query ->where(DB::Raw('week(payment.created_at)'), '=', Carbon::now()->weekOfYear) ;
        })
        ->select(DB::raw("SUM(category_payment.total + IFNULL(category_payment.tax_total,0)) AS total")
        )
        ->get();
        
        if($totalPaymentCategory->isNotEmpty())
        {
            $total=$total+$totalPaymentCategory[0]->total;
        }
        
        return $total;
    }
    
    
    //total de entradas
    private static function income_consolidate()
    {
        $mainClass=new AppController();
        $data= collect(["day"=>$mainClass->_total(InvoiceSaleOrder::class,true,false,false,false,'in'),
        "month"=> $mainClass->_total(InvoiceSaleOrder::class,false,false,true,false,'in'),
        "year"=> $mainClass->_total(InvoiceSaleOrder::class,false,false,false,true,'in'),
        "week"=>$mainClass->_total(InvoiceSaleOrder::class,false,true,false,false,'in')
        ]);
        
        return $data;
    }
    
    //total de egresos
    private static function outcome_consolidate()
    {
        $mainClass=new AppController();
        
        $data= collect(["day"=>$mainClass->_total(Bill::class,true,false,false,false,'eg'),
        "month"=> $mainClass->_total(Bill::class,false,false,true,false,'eg'),
        "year"=> $mainClass->_total(Bill::class,false,false,false,true,'eg'),
        "week"=>$mainClass->_total(Bill::class,false,true,false,false,'eg')
        ]);
        
        return $data;
    }
    
    private static function  graph_info_total($model,$isToday,$isWeek,$isMonth, $isYear,$processType )
    {   
        $select=[DB::raw('day(created_at) as day'),DB::raw('sum(total) as total')];
        $categorySelect=[DB::raw('day(payment.created_at) as day'),DB::raw('SUM(category_payment.total + IFNULL(category_payment.tax_total,0)) as total')];

        $groupBy='day';

        if ($isYear==true)
        {
             $select=[DB::raw('month(created_at) as month'),DB::raw('sum(total) as total')];
             $categorySelect=[DB::raw('month(payment.created_at) as month'),DB::raw('SUM(category_payment.total + IFNULL(category_payment.tax_total,0)) as total')];
             $groupBy='month';
        }

        $data= $model::AccountID(0)
         ->when($isMonth, function ($query) {
            return $query->whereMonth('created_at', '=', date('m'));
        })
        ->when($isToday, function ($query) {
            return $query->whereDay('created_at', '=', date('d'));
        })
        ->when($isYear, function ($query) {
            return $query->whereYear('created_at', '=', date('Y'));
        })
        ->when($isWeek, function ($query) {
            return $query->where(DB::Raw('week(created_at)'), '=', Carbon::now()->weekOfYear);
        })        
        ->select($select)
        ->groupBy($groupBy)
        ->get();

        $totalPaymentCategory=   DB::table('payment')
        ->join('category_payment', 'category_payment.payment_id', '=', 'payment.id')
        ->where('payment.account_id',Auth::user()->account_id)
        ->where('payment.type_id','=',$processType)
        ->where('payment.isDeleted',0)
        ->when($isMonth, function ($query) {
            return $query->whereMonth('payment.created_at', '=', date('m'));
        })
        ->when($isToday, function ($query) {
            return $query->whereDay('payment.created_at', '=', date('d'));
        })
        ->when($isYear, function ($query) {
            return $query->whereYear('payment.created_at', '=', date('Y'));
        })
        ->when($isWeek, function ($query) {
            return $query ->where(DB::Raw('week(payment.created_at)'), '=', Carbon::now()->weekOfYear) ;
        })
        ->select($categorySelect)
        ->groupBy($groupBy)
        ->get();

        //Adicionar los items encontrados en categorias al arreglo principal
         if($totalPaymentCategory->isNotEmpty())
        {
            $totalPaymentCategory = $totalPaymentCategory->each(function ($item, $key) use($data) {
                        $data->push($item);
                        $data->all();
                    });
        }

        return $data;
    }
    
    private static function graph_info()
    {
        $mainClass=new AppController();

        $dtabyWeek=$mainClass->graph_info_total(InvoiceSaleOrder::class,false,true,false,false,'in');    

        $dtabyWeek_outcome=$mainClass->graph_info_total(Bill::class,false,true,false,false,'eg');
        
        $totalbyday_permonth= $mainClass->graph_info_total(InvoiceSaleOrder::class,false,false,true,false,'in');   
        
        $totalbyday_permonth_out= $mainClass->graph_info_total(Bill::class,false,false,true,false,'eg');
        
        $totalbyMonth_perYear_in= $mainClass->graph_info_total(InvoiceSaleOrder::class,false,false,false,true,'in');  
        
        $totalbyMonth_perYear_out= $mainClass->graph_info_total(Bill::class,false,false,false,true,'eg');
       
        //obtener rango de dias de la semana actual por numero
        $startDate = Carbon::now()->startOfWeek();
        $endDate = Carbon::now()->endOfWeek();
        
        $WeekDataArray=[];
        $WeekDataArray_out=[];
        while($startDate<= $endDate)
        {            
            $WeekDataArray2=$dtabyWeek->where('day',$startDate->copy()->day)->pluck('total')->sum();
            $WeekDataArray2_out=$dtabyWeek_outcome->where('day',$startDate->copy()->day)->pluck('total')->sum();
            if (count($WeekDataArray2)>0)
            {
                $WeekDataArray[]=$WeekDataArray2;
            }
            else{
                $WeekDataArray[]=0;
            }
            
            if (count($WeekDataArray2_out)>0)
            {
                $WeekDataArray_out[]=$WeekDataArray2_out;
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
            $data=$totalbyday_permonth->where('day',$startDayMonth->copy()->day)->pluck('total')->sum();
            $data_out=$totalbyday_permonth_out->where('day',$startDayMonth->copy()->day)->pluck('total')->sum();
            
            if (count($data)>0)
            {
                $DataByDayForMonth_in[]=$data;
            }
            else{
                $DataByDayForMonth_in[]=0;
            }
            
            if (count($data_out)>0)
            {
                $DataByDayForMonth_out[]=$data_out;
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
            $data_in=$totalbyMonth_perYear_in->where('month',$i)->pluck('total')->sum();
            $data_out=$totalbyMonth_perYear_out->where('month',$i)->pluck('total')->sum();
            
            if (count($data_in)>0)
            {
                $DataBymont_peryear_in[]=$data_in;
            }
            else{
                $DataBymont_peryear_in[]=0;
            }
            
            if (count($data_out)>0)
            {
                $DataBymont_peryear_out[]=$data_out;
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