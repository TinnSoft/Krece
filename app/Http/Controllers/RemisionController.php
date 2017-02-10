<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    RemisionDetail,
    Remision,
    RemisionDocumentType,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber
};
use App\Utilities\Helper;
use PDF;
use Illuminate\Support\Facades\DB;

class RemisionController extends Controller
{

    public function index()
    {
        return view('remision.index');  
    }

    public function getRemisionList()
    {
        //Obtener las cotizaciones creadas hasta la fecha       
        $remision = Remision::with('contact')
               ->GetAll(0)
               ->orderBy('created_at', 'desc')
                ->GetSelectedFields()
               ->get();

         return response()->json($remision);
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

        $DocumentType = RemisionDocumentType::select('id', 'description')
               ->orderBy('id', 'asc')
               ->get();

       
        $PublicId = Remision::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $ResolutionId = ResolutionNumber::where('account_id',  Auth::user()->account_id)
                        ->where('key','=','remision')
                        ->select('number')
                        ->first();

        //Defaultvalue
        $defaultlist_price=ListPrice::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->first();

        $defaultdocumentType=RemisionDocumentType::select('id', 'description')
               ->orderBy('id', 'asc')
               ->first();

        $defaultCurrency=null;


        $baseInfo=[
                'public_id' => $PublicId,
                'contacts' => $contact,
               'sellers'=>$sellers,
               'listprice'=>$listPrice,
               'currency'=>$currencylist,
               'productlist'=>$productlist,
               'taxes'=>$taxes,
               'resolution_id'=>$ResolutionId,
               'documentType'=> $DocumentType, 
               'list_price'=>$defaultlist_price,
               'default_documentType'=>$defaultdocumentType,  
               'default_Currency'=>$defaultCurrency,
            ];
             
     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('remision.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'documentType_id' => 'required',            
            'remisiondetail.*.unit_price' => 'required|numeric|min:1',
            'remisiondetail.*.quantity' => 'required|integer|min:1',
            'remisiondetail.*.product_id' => 'required',    
        ]);

        $products = collect($request->remisiondetail)->transform(function($remisiondetail) {
            $remisiondetail['total'] = $remisiondetail['quantity'] * $remisiondetail['unit_price'];
            $remisiondetail['user_id'] =  Auth::user()->id;
            return new RemisionDetail($remisiondetail);
        });
        

        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };

        
        $data = $request->except('remisiondetail','documentType','list_price','currency','contact','seller');       
        
        $currentPublicId = Remision::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $ResolutionId = ResolutionNumber::where('account_id',  Auth::user()->account_id)
                        ->where('key','=','remision')
                        ->select('number')
                        ->first();
        
        $data['public_id'] = $currentPublicId;
        $data['document_type_id'] =  (int)$data['documentType_id'];
        $data['resolution_id'] = $ResolutionId->number;
        $data['status_id'] = 1;        
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
        
        //Default
        if (!$data['currency_code'])
        {
            $data['currency_code']="COP";
        }

        $remision = Remision::create($data);
        $remision->remisiondetail()->saveMany($products);
     
        //Incrementa el numero de cotización
        ResolutionNumber::where('key', 'remision')
                ->increment('number');
       
        return response()
            ->json([
                'created' => true,
                'id' => $remision->public_id
            ]);
    }

    public function show($id)
    {
          $remision = Remision::with('remisiondetail','list_price','seller')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();     

        if (!$remision)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de remision creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/remision')->with($notification);
        }
        $remision['date']=Carbon::parse($remision['date'])->toFormattedDateString(); 
        $remision['due_date']=Carbon::parse($remision['due_date'])->toFormattedDateString(); 
        
       foreach($remision->remisiondetail as $item) 
        {
            $item['unit_price']=Helper::formatMoney($item['unit_price']);
            $item['total']=Helper::formatMoney($item['total']);
        }  

        $remision['total']=Helper::formatMoney($remision['total']);
        $remision['sub_total']=Helper::formatMoney($remision['sub_total']);
        $remision['total_taxes']=Helper::formatMoney($remision['total_taxes']);
        $remision['total_discounts']=Helper::formatMoney($remision['total_discounts']);

        return view('remision.show', compact('remision'));
    }



    public function edit($id)
    {
        
        $remision = Remision::with(['remisiondetail','contact','list_price','currency','seller'])
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();

        
         if (!$remision)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/remision')->with($notification);
        }

        $remision['date']= Helper::setCustomDateFormat(Carbon::parse($remision['date']));
        $remision['due_date']= Helper::setCustomDateFormat(Carbon::parse($remision['due_date']));
        
        if (request()->get('convert')=='clone')
        {
            $PublicId = Remision::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
            $remision['public_id']= $PublicId;
            $remision['date']=Helper::setCustomDateFormat(Carbon::now());
            $remision['due_date']=Helper::setCustomDateFormat(Carbon::now()->addDays(30));
            $remision['notes']=null;
            return view('remision.clone', compact('remision'));
        }

         return view('remision.edit', compact('remision'));
    }

    
    public function update(Request $request, $id)
    {        
              
        $this->validate($request, [     
            'customer_id' => 'required',               
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',            
            'remisiondetail.*.unit_price' => 'required|numeric|min:1',
            'remisiondetail.*.quantity' => 'required|integer|min:1',
            'remisiondetail.*.product_id' => 'required',    
        ]);
       
        $remision = Remision::findOrFail($id);

        $products = collect($request->remisiondetail)->transform(function($remisiondetail) {
        $remisiondetail['total'] = $remisiondetail['quantity'] * $remisiondetail['unit_price'];
        $remisiondetail['user_id'] =  Auth::user()->id;
            return new RemisionDetail($remisiondetail);
        });
        
        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
       $data = $request->except('remisiondetail');       

        $data['user_id'] = Auth::user()->id;       
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
        $remision->update($data);
       
        RemisionDetail::where('remision_id', $remision->id)->delete();
        $remision->remisiondetail()->saveMany($products);

        return response()
            ->json([
                'updated' => true,
                'id' => $remision->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $remision = Remision::GetByPublicId(0,$id)
                ->firstOrFail();   
            
            $remision['isDeleted']=1;
            $remision['deleted_at']=$now = Carbon::now();
            $remision->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function pdf($id, Request $request)
    {
        Carbon::setLocale('es');

         $remision = Remision::with('account','remisiondetail','list_price','seller')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
                
        $remision['total']=Helper::formatMoney($remision['total']);
        $remision['sub_total']=Helper::formatMoney($remision['sub_total']);
        $remision['total_taxes']=Helper::formatMoney($remision['total_taxes']);
        $remision['total_discounts']=Helper::formatMoney($remision['total_discounts']);
        
        foreach($remision->remisiondetail as $item) 
        {
            $item['unit_price']=Helper::formatMoney($item['unit_price']);
            $item['total']=Helper::formatMoney($item['total']);
        }
        
        $remision['date']=Carbon::parse($remision['date'])->toFormattedDateString(); 
        $remision['due_date']=Carbon::parse($remision['due_date'])->toFormattedDateString(); 

        $mypdf = PDF::loadView('pdf.remision', ['remision' => $remision]);
        $filename = "Remision_"."{$remision->public_id}.pdf";

         if($request->get('opt') === 'download') {
            return $pdf->download($filename);            
        }
        
        return $mypdf->stream();
    }
    
    public function update_state(Request $request,$id)
    {
        
            $data = $request->all(); 
            $data['status_id']= (int)$data['status_id'];
             

            $item = Remision::findOrFail($id);
              
            $item->update($data);

            
            return response()
            ->json([
                'updated' => true                           
            ]);
    }

}
