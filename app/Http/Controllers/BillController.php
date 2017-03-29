<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    BillDetail,
    Bill,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber,
    Category
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use Illuminate\Support\Facades\DB;

class BillController extends Controller
{

    public function index()
    {  
        return view('bill.index');  
    }

    public function getBillList()
    {

         $bill = DB::table('bill')   
                    ->Join('contact', 'bill.customer_id', '=', 'contact.id')
                    ->leftJoin('payment_history', 'bill.id', '=', 'payment_history.bill_id')  
                    ->leftjoin('payment', function ($join) {
                        $join->on('payment.id', '=', 'payment_history.payment_id')
                            ->where('payment.isDeleted',0);
                    })         
                    ->where('bill.account_id',Auth::user()->account_id)
                    ->where('bill.isDeleted',0)   
                    ->select('bill.id','bill.resolution_id','bill.status_id', 
                    'bill.due_date', 'contact.name as contact_name','contact.id as contact_id',
                    DB::raw('SUM(payment_history.amount) as total_payed'),'bill.created_at',
                    'bill.public_id','bill.total',
                    DB::raw('bill.total - sum(IFNULL(payment_history.amount,0)) as pending_to_pay')
                    )
                    ->groupBy('bill.id','bill.resolution_id','bill.status_id', 
                    'bill.due_date', 'contact.name',
                    'bill.created_at','contact.id',
                    'bill.public_id','bill.total')
                    ->orderby('bill.resolution_id','desc')
                    ->get();
            
         return response()->json($bill);
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {

        $baseInfo=[
                'public_id' =>Helper::PublicId(Bill::class),
                'contacts' => Helper::providers(),              
               'currency'=>Helper::currencylist(),
               'productlist'=>Helper::category_outcome(),
               'taxes'=>Helper::taxes(),
               'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'bill'),
               'default_Currency'=>Helper::default_currency()              
            ];

     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('bill.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'customer_id' => 'required',              
            'date' => 'required',
            'due_date' => 'required',       
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.category_id' => 'required',    
        ]);

       
        $data = $request->except('detail','currency','contact');  

        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);           
            return new BillDetail($detail);
        });

        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };        

        $data['public_id'] = Helper::PublicId(Bill::class);              
        $data['status_id'] = BILL_STATUS_OPEN;               
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;         
        $data['date']=Helper::dateFormatter($data['date']);
        $data['due_date']= Helper::dateFormatter($data['due_date']);

        //Default
        if (!$data['currency_code'])
        {
            $data['currency_code']=CURRENCY_CODE_DEFAULT;
        }
        
        
        $bill = Bill::create($data); 
        $bill->detail()->saveMany($products);
    
        ResolutionNumber::where('key', 'bill')
                ->increment('number');
       
        event(new RecordActivity('Create','Se creó la factura de proveedor número: ' 
			.$bill->resolution_id.' para el cliente '.$bill->contact->name,
			'Bill','/bill/'.$bill->public_id));	

        return response()
            ->json([
                'created' => true,
                'id' => $bill->public_id
            ]);
    }

    public function show($id)
    {
          $bill = Bill::with('detail')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();     

        if (!$bill)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de bill creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/bill')->with($notification);
        }
       
        $bill=Helper::_InvoiceFormatter($bill);
        $taxes=$this->getTotalTaxes($bill->public_id);
        $paymentHistorical=$this->getPaymentHistorical($bill->public_id);

        return view('bill.show', compact('bill','taxes','paymentHistorical'));
    }

    public function edit($id)
    {
        
        $bill = Bill::with(['detail','contact'])
        ->GetByPublicId(0,$id)
        ->GetSelectedFields()
        ->first();

        
         if (!$bill)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/bill')->with($notification);
        }
        
        $checkConverted=request()->get('convert');
          if ($checkConverted=='toBill' || $checkConverted=='toBillR')
            {
               $model=null;
                if ($checkConverted=='toBill')
                {
                    $model=PurchaseOrder::class;
                }
                if ($checkConverted=='toBillR')
                {
                    $model=PurchaseOrder::class;
                }

                 $bill = $model::with(['detail','contact'])
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
                
                $resolutionID=Helper::ResolutionId(ResolutionNumber::class,'bill');

                $PublicId = Helper::PublicId(Bill::class);
                $bill['public_id']= $PublicId;
                $bill['resolution_id']= $resolutionID;
                $bill['date']=Helper::setCustomDateFormat(Carbon::now());
                $bill['due_date']=Helper::setCustomDateFormat(Carbon::now()->addDays(30));
                $bill['notes']=null;
                return view('bill.createFromConvert', compact('bill'));
            }

        $bill['date']= Helper::setCustomDateFormat(Carbon::parse($bill['date']));
        $bill['due_date']= Helper::setCustomDateFormat(Carbon::parse($bill['due_date']));

         return view('bill.edit', compact('bill'));
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
       
        $bill = Bill::findOrFail($id);

        $products = collect($request->detail)->transform(function($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $detail['total'] = $baseprice- $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100); 
            return new BillDetail($detail);
        });
        
        if($products->isEmpty()) {
            return response()
            ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
       $data = $request->except('detail','currency','contact');  

        $data['user_id'] = Auth::user()->id;       
        $data['date']=Helper::dateFormatter($data['date']);
        $data['due_date']= Helper::dateFormatter($data['due_date']);
        $bill->update($data);
       
        BillDetail::where('bill_id', $bill->id)->delete();
        $bill->detail()->saveMany($products);

        event(new RecordActivity('Update','Se actualizó la factura de proveedores número: ' 
			.$bill->resolution_id.' para el cliente '.$bill->contact->name,
			'Bill','/bill/'.$bill->public_id));	

        return response()
            ->json([
                'updated' => true,
                'id' => $bill->public_id              
            ]);
    }
    
    public function destroy($id)
    {

            $bill = Bill::GetByPublicId(0,$id)
                ->firstOrFail();   
            
            $bill['isDeleted']=1;
            $bill['deleted_at']=$now = Carbon::now();
            $bill->save();
            
            event(new RecordActivity('Delete','Se eliminó la factura de venta número: ' 
			.$bill->resolution_id,
			'Bill',null));	

            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function pdf($id, Request $request)
    {

         $bill = Bill::with('account','detail')
                    ->GetByPublicId(0,$id)
                    ->GetSelectedFields()
                    ->first();
  
        $bill=Helper::_InvoiceFormatter($bill);
        
        $mypdf = PDF::loadView('pdf.bill', ['bill' => $bill,'taxes' => $this->getTotalTaxes($bill->public_id)]);
        $filename = "Bill_"."{$bill->public_id}.pdf";

         if($request->get('opt') === 'download') {
            return $pdf->download($filename);            
        }
        
        event(new RecordActivity('Print','Se ha impreso el pdf de la factura de venta No: ' 
			.$bill->resolution_id,
			'Bill','/bill/'.$bill->public_id));	

        return $mypdf->stream();
    }
    
    public function update_state(Request $request,$id)
    {
        
            $data = $request->all(); 
            $data['status_id']= (int)$data['status_id'];             

            $item = Bill::findOrFail($id);              
            $item->update($data);

            event(new RecordActivity('Update','Se actualizó el estado de la factura de venta número: ' 
			.$item->resolution_id.' para el cliente '.$item->contact->name,
			'Bill','/bill/'.$item->public_id));	

            return response()
            ->json([
                'updated' => true                           
            ]);
    }

    public static function getTotalTaxes($bill_id)
    {
        $taxes=
        DB::table('bill')
            ->join('bill_detail', 'bill.id', '=', 'bill_detail.bill_id')
             ->join('tax', 'bill_detail.tax_id', '=', 'tax.id')
            ->where('bill.account_id',Auth::user()->account_id) 
             ->where('bill.public_id',$bill_id)  
              ->where('bill_detail.tax_amount','>',0)             
            ->select(DB::raw("CONCAT(tax.name,' (',bill_detail.tax_amount,'%)') AS name"), 
            DB::raw('SUM(bill_detail.total_tax) as total'))
            ->groupBy('tax.name','bill_detail.tax_amount')
            ->get();

            return  Helper::_taxesFormatter($taxes);
    }

     public static function getPaymentHistorical($public_id)
    {
        $payment_historical=
            DB::table('bill')            
            ->Join('payment_history', 'bill.id', '=', 'payment_history.bill_id')
            ->Join('payment', 'payment.id', '=', 'payment_history.payment_id')
            ->Join('payment_method', 'payment.payment_method_id', '=', 'payment_method.id')
            ->Join('payment_status', 'payment.status_id', '=', 'payment_status.id')
             ->where('bill.public_id',$public_id)   
            ->where('bill.account_id',Auth::user()->account_id)
              ->where('bill.isDeleted',0)   
              ->where('payment.isDeleted',0)  
            ->select('payment.date','payment.resolution_id','payment.status_id', 'payment_status.description as status',
                'payment_method.name as payment_method', 
                 DB::raw('SUM(payment_history.amount) as total_payed'),
                 'payment.observations','payment.public_id'
                 )
            ->groupBy('payment.date','payment.resolution_id', 'payment_status.description','payment_method.name', 
               'payment.observations','payment.public_id','payment.status_id')
            ->orderby('bill.resolution_id','desc')
            ->get();

            foreach($payment_historical as $item) 
            {  
               
                $item->total_payed=Helper::formatMoney($item->total_payed);            
                $item->date= Helper::setCustomDateFormat(Carbon::parse( $item->date));
            }

            return  $payment_historical;
    }
}
