<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    PurchaseOrderDetail,
    PurchaseOrder,
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
use App\Events\RecordActivity;
use Illuminate\Support\Facades\DB;
use App\Contracts\IEmailRepository;
use App\Contracts\IPdfRepository;

class PurchaseOrderController extends Controller
{

    protected $emailRepo;
    
    protected $iPdfRepo;
    
    public function __construct(IEmailRepository $emailRepo, IPdfRepository $iPdfRepo)
    {
        $this->emailRepo = $emailRepo;
        $this->iPdfRepo = $iPdfRepo;
    }

    public function index()
    {
        return view('purchase-order.index');  
    }

    public function getPOList()
    {
        $po = PurchaseOrder::with('contact')
               ->GetAll(0)
               ->orderBy('created_at', 'desc')
                ->GetSelectedFields()
               ->get();

         return response()->json($po);
    }


    public function BaseInfo()
    {
       
        $baseInfo=[
                'public_id' => Helper::PublicId(PurchaseOrder::class),
                'contacts' => Helper::providers(),
               'currency'=>Helper::currencylist(),
               'productlist'=>Helper::category_outcome(),
               'default_Currency'=>Helper::default_currency(),
               'list_price'=>Helper::listprice_default(), 
               'taxes'=>Helper::taxes(),
               'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'purchase_order')
            ];
             
     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('purchase-order.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',
            'due_date' => 'required',           
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.category_id' => 'required|integer',    
        ]);

        
        $products = collect($request->detail)->transform(function($detail) {
           $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
            return new PurchaseOrderDetail($detail);
        });
        
       
        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };

        $data = $request->except('detail','contact','currency');      
         
        $data['public_id'] = Helper::PublicId(PurchaseOrder::class);
        $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'purchase_order')['number'];
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Helper::dateFormatter($data['date']);
        $data['due_date']= Helper::dateFormatter($data['due_date']);
        $data['status_id'] = 1;
         if (!$data['currency_code'])
        {
            $data['currency_code']="COP";
        }       
     
       
        $po = PurchaseOrder::create($data);
        $po->detail()->saveMany($products);
        
        //Incrementa el numero de cotización
        ResolutionNumber::where('key', 'purchase_order')
                ->increment('number');
        
         event(new RecordActivity('Create','Se creó la Orden de Compra número: ' 
			.$po->resolution_id.' para el cliente '.$po->contact->name,
			'PurchaseOrder','/purchase-order/'.$po->public_id));	
       
        return response()
            ->json([
                'created' => true,
                'id' => $po->public_id
            ]);
    }


    public function show($id)
    {  
        
          $po = PurchaseOrder::with('detail')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();    
       
      
        if (!$po)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/purchase-order')->with($notification);
        }
        
        $po=Helper::_InvoiceFormatter($po);
    
        $taxes=Helper::getTotalTaxes($po->public_id,'purchase_order','purchase_order_detail');
        $_invoice_History=$this->getInvoiceHistory($po->public_id);

        return view('purchase-order.show', compact('po','taxes','_invoice_History'));
    }


    public function edit($id)
    {
        
        $po = PurchaseOrder::with(['detail','contact'])
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();

        
         if (!$po)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/purchase-order')->with($notification);
        }

        $po['date']= Helper::setCustomDateFormat(Carbon::parse($po['date']));
        $po['due_date']= Helper::setCustomDateFormat(Carbon::parse($po['due_date']));
    

         return view('purchase-order.edit', compact('po'));
    }

    
    public function update(Request $request, $id)
    {  

        $this->validate($request, [     
            'customer_id' => 'required',               
            'date' => 'required',
            'due_date' => 'required',         
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.category_id' => 'required',    
        ]);
       
        $po = PurchaseOrder::findOrFail($id);

        $products = collect($request->detail)->transform(function($detail) {
           $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
            return new PurchaseOrderDetail($detail);
        });
        
        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
       $data = $request->except('detail','contact','currency');       

        $data['user_id'] = Auth::user()->id;       
        $data['date']=Helper::dateFormatter($data['date']);
        $data['due_date']= Helper::dateFormatter($data['due_date']);

        $po->update($data);
       

        PurchaseOrderDetail::where('purchase_order_id', $po->id)->delete();
        $po->detail()->saveMany($products);
        
         event(new RecordActivity('Update','Se actualizó la Orden de Compra número: ' 
			.$po->resolution_id.' para el cliente '.$po->contact->name,
			'PurchaseOrder','/purchase-order/'.$po->public_id));	

        return response()
            ->json([
                'updated' => true,
                'id' => $po->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $po = PurchaseOrder::GetByPublicId(0,$id)
                ->firstOrFail();   
            
            $po['isDeleted']=1;
            $po['deleted_at']=$now = Carbon::now();
            $po->save();

              event(new RecordActivity('Delete','Se eliminó la cotización número: ' 
			.$po->resolution_id,
			'PurchaseOrder',null));
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function pdf($id, Request $request)
    {

        $mypdf=$this->iPdfRepo->create(PurchaseOrder::class, $id);
        
        $filename = "PO_"."{$id}.pdf";

         if($request->get('opt') === 'download') {
            return $mypdf->download($filename);            
        }
  
         event(new RecordActivity('Print','Se ha impreso el pdf de la Orden de Compra No: ' 
			.$id,
			'PurchaseOrder','/purchase-order/'.$id));	
         
        return $mypdf->stream();

    }

     public static function getInvoiceHistory($public_id)
    {
        /*
        $payment_historical=
            DB::table('purchase_order')            
            ->Join('payment_history', 'purchase_order.id', '=', 'payment_history.purchase_order_id')
            ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
            ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
            ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')
             ->where('purchase_order.public_id',$public_id)   
            ->where('purchase_order.account_id',Auth::user()->account_id)
              ->where('purchase_order.isDeleted',0)   
              ->where('payment.isDeleted',0)  
            ->select('payment.date','payment.resolution_id','payment.status_id', 'payment_status.description as status','payment_method.name as payment_method', 
                 DB::raw('SUM(payment_history.amount) as total_payed'),'payment.observations','payment.public_id'
                 )
            ->groupBy('payment.date','payment.resolution_id', 'payment_status.description','payment_method.name', 
               'payment.observations','payment.public_id','payment.status_id')
            ->orderby('purchase_order.resolution_id','desc')
            ->get();

            foreach($payment_historical as $item) 
            {  
                $item->total_payed=Helper::formatMoney($item->total_payed);            
                $item->date= Helper::setCustomDateFormat(Carbon::parse( $item->date));
            }

            return  $payment_historical;
            */
            return [];
    }

    public function getTemplateEmailToCustomer($resolution_id)
        {           
           return $this->emailRepo->TemplateEmailToCustomer(PurchaseOrder::class,$resolution_id);
        }
}
