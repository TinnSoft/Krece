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


        $DocumentType = RemisionDocumentType::select('id', 'description')
               ->orderBy('id', 'asc')
               ->get();

        $defaultdocumentType=RemisionDocumentType::select('id', 'description')
               ->orderBy('id', 'asc')
               ->first();

        $defaultCurrency=null;


        $baseInfo=[
                'public_id' =>Helper::PublicId(Remision::class),
                'contacts' => Helper::contacts(),
               'sellers'=>Helper::sellers(),
               'listprice'=>Helper::listPrice(),
               'currency'=>Helper::currencylist(),
               'productlist'=>Helper::productlist(),
               'taxes'=>Helper::taxes(),
               'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'remision'),
               'documentType'=> $DocumentType, 
               'list_price'=>Helper::listprice_default(),
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
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',    
        ]);

        $products = collect($request->detail)->transform(function($detail) {
            $detail['total'] = $detail['quantity'] * $detail['unit_price'];
            $detail['user_id'] =  Auth::user()->id;
            return new RemisionDetail($detail);
        });
        

        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };

        
        $data = $request->except('detail','documentType','list_price','currency','contact','seller');       
        
        $data['public_id'] = Helper::PublicId(Remision::class);
        $data['document_type_id'] =  (int)$data['documentType_id'];
        $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'remision')['number'];
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
        $remision->detail()->saveMany($products);
     
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
          $remision = Remision::with('detail','list_price','seller')
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
       
        $remision=Helper::_InvoiceFormatter($remision);

        return view('remision.show', compact('remision'));
    }



    public function edit($id)
    {
        
        $remision = Remision::with(['detail','contact','list_price','currency','seller'])
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
            $PublicId = Helper::PublicId(Remision::class);
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
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',    
        ]);
       
        $remision = Remision::findOrFail($id);

        $products = collect($request->detail)->transform(function($detail) {
        $detail['total'] = $detail['quantity'] * $detail['unit_price'];
        $detail['user_id'] =  Auth::user()->id;
            return new RemisionDetail($detail);
        });
        
        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
       $data = $request->except('detail');       

        $data['user_id'] = Auth::user()->id;       
        $data['date']=Carbon::createFromFormat('d/m/Y', $data['date']);
        $data['due_date']= Carbon::createFromFormat('d/m/Y', $data['due_date']);
        $remision->update($data);
       
        RemisionDetail::where('remision_id', $remision->id)->delete();
        $remision->detail()->saveMany($products);

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

         $remision = Remision::with('account','detail','list_price','seller')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
                
        $remision=Helper::_InvoiceFormatter($remision);
        
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
