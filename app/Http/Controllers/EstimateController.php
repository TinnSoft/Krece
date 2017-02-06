<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    EstimateDetail,
    Estimate,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product
};

use Illuminate\Support\Facades\DB;

class EstimateController extends Controller
{

    public function index()
    {
        return view('estimate.index');  
    }

    public function getEstimateList()
    {
        //Obtener las cotizaciones creadas hasta la fecha       
        $estimate = Estimate::with('contact')
               ->GetAll(0)
               ->orderBy('created_at', 'desc')
               ->select('id', 'account_id','public_id',
               'user_id','seller_id','list_price_id','customer_id',
               'currency_code','total','date','due_date','notes',
               'observations','created_at'
               )->get();

         return response()->json($estimate);
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
       
        $contact = Contact::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)->where('isCustomer', '=', 1)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get();
        

        $sellers = Seller::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->where('isEnabled',  1)
               ->orderBy('created_at', 'asc')
               ->get();

        $listPrice = ListPrice::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get();
        
        $currencylist =  DB::table('currency')
        ->join('currency_code', function ($join) {
            $join->on('currency.code_id', '=', 'currency_code.code')
                 ->where('currency.account_id', '=',  Auth::user()->account_id);
        })
        ->orderBy('currency_code.order', 'desc')
               ->select('currency.code_id', 'currency_code.code','currency_code.symbol')->get();
        

        $productlist = Product::select('id', 'name','description','sale_price')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get();
        
        $taxes = Tax::select(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value')
       ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get();

       
        $PublicId = Estimate::where('account_id',  Auth::user()->account_id)->max('public_id')+1;

        $baseInfo=[
                'public_id' => $PublicId,
                'contacts' => $contact,
               'sellers'=>$sellers,
               'listprice'=>$listPrice,
               'currency'=>$currencylist,
               'productlist'=>$productlist,
               'taxes'=>$taxes       
            ];
             
     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('estimate.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',            
            'estimatedetail.*.unit_price' => 'required|numeric|min:1',
            'estimatedetail.*.quantity' => 'required|integer|min:1',
            'estimatedetail.*.product_id' => 'required',    
        ]);

        $products = collect($request->estimatedetail)->transform(function($estimatedetail) {
            $estimatedetail['total'] = $estimatedetail['quantity'] * $estimatedetail['unit_price'];
            $estimatedetail['user_id'] =  Auth::user()->id;
            return new EstimateDetail($estimatedetail);
        });
        

        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };

        $data = $request->except('estimatedetail');       

        $currentPublicId = Estimate::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);

         $estimate = Estimate::create($data);
        $estimate->estimatedetail()->saveMany($products);
        
       
        return response()
            ->json([
                'created' => true,
                'id' => $estimate->public_id
            ]);
    }

    public function show($id)
    {
        $estimate = Estimate::with('estimatedetail','list_price','seller')
                    ->GetByPublicId(0,$id)
                    ->first();
         
        
        if (!$estimate)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );

          return redirect('/estimate')->with($notification);
        }
        $estimate['date']=Carbon::parse($estimate['date'])->toFormattedDateString(); 
        $estimate['due_date']=Carbon::parse($estimate['due_date'])->toFormattedDateString(); 
        return view('estimate.show', compact('estimate'));
    }

    //allows to export a date value to the customized format of the view 
    public static function setCustomDateFormat($dateval)
    {            
        $day=$dateval->day;
        $month=$dateval->month;
        $year=$dateval->year;
        return $day.'/'. $month.'/'.$year;   
    }

    public function edit($id)
    {
        
        $estimate = Estimate::with(['estimatedetail','contact','list_price','currency','seller'])
        ->GetByPublicId(0,$id)
        ->first();

         if (!$estimate)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/estimate')->with($notification);
        }

        $estimate['date']= $this->setCustomDateFormat(Carbon::parse($estimate['date']));
        $estimate['due_date']= $this->setCustomDateFormat(Carbon::parse($estimate['due_date']));
        
         return view('estimate.edit', compact('estimate'));
         
         
    }

    public function update(Request $request, $id)
    {        
              
        $this->validate($request, [     
            'customer_id' => 'required',               
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',            
            'estimatedetail.*.unit_price' => 'required|numeric|min:1',
            'estimatedetail.*.quantity' => 'required|integer|min:1',
            'estimatedetail.*.product_id' => 'required',    
        ]);
       
        $estimate = Estimate::findOrFail($id);

        $products = collect($request->estimatedetail)->transform(function($estimatedetail) {
        $estimatedetail['total'] = $estimatedetail['quantity'] * $estimatedetail['unit_price'];
        $estimatedetail['user_id'] =  Auth::user()->id;
            return new EstimateDetail($estimatedetail);
        });
        
        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
       $data = $request->except('estimatedetail');       

        $data['user_id'] = Auth::user()->id;       
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
        $estimate->update($data);
       
        EstimateDetail::where('estimate_id', $estimate->id)->delete();
        $estimate->estimatedetail()->saveMany($products);

        return response()
            ->json([
                'updated' => true,
                'id' => $estimate->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $estimate = Estimate::GetByPublicId(0,$id)
                ->firstOrFail();   
            
            $estimate['isDeleted']=1;
            $estimate['deleted_at']=$now = Carbon::now();
            $estimate->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }
}
