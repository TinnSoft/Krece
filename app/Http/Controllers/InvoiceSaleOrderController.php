<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    InvoiceSaleOrderDetail,
    InvoiceSaleOrder,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber,
    Resolution,
    Category,
    Estimate,
    User,
    Remision
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use DB;
use App\Contracts\IEmailRepository;
use App\Contracts\IPdfRepository;
use App\Repositories\PaymentRepository;
use Datatables;

class InvoiceSaleOrderController extends Controller
{
    protected $emailRepo;
    
    protected $iPdfRepo;
    
    protected $paymentRepo;
    
    public function __construct(IEmailRepository $emailRepo, IPdfRepository $iPdfRepo,PaymentRepository $paymentRepo)
    {
        $this->emailRepo = $emailRepo;
        $this->iPdfRepo = $iPdfRepo;
        $this->paymentRepo = $paymentRepo;
    }
    
    
    public function index()
    {
        return view('invoice.index');
    }
    
    public function getInvoiceList()
    {
        //Obtener facturas sin pagos
        $data = DB::table('invoice_sale_order')
        ->Join('contact', 'invoice_sale_order.customer_id', '=', 'contact.id')
        ->leftJoin('payment_history', 'invoice_sale_order.id', '=', 'payment_history.invoice_sale_order_id')
        ->leftJoin('payment', function ($join) {
            $join->on('payment.id', '=', 'payment_history.payment_id');
        })
        ->where([
            ['invoice_sale_order.account_id',Auth::user()->account_id],
            ['invoice_sale_order.isDeleted',0],
            ['payment_history.amount',null]
        ])
        ->orWhere(function ($query) {
                $query->where('payment.status_id',1)
                      ->where('invoice_sale_order.isDeleted',0)
                      ->where('invoice_sale_order.account_id',Auth::user()->account_id);
            })
        ->select('invoice_sale_order.id',
        'invoice_sale_order.resolution_id',
        'invoice_sale_order.status_id',
        'invoice_sale_order.due_date',
        'contact.name as contact_name',
        'contact.public_id as contact_id',
        'invoice_sale_order.created_at',
        'invoice_sale_order.public_id',
        'invoice_sale_order.total',
        'payment.isDeleted as isPaymentDeleted',
        DB::raw('SUM(payment_history.amount) as total_payed'),
        DB::raw('invoice_sale_order.total - IFNULL(SUM(payment_history.amount),0) as pending_to_pay')
        )
        ->groupBy('invoice_sale_order.id','invoice_sale_order.resolution_id','invoice_sale_order.status_id',
        'invoice_sale_order.due_date', 'contact.name',
        'invoice_sale_order.created_at','contact.public_id',
        'invoice_sale_order.public_id','invoice_sale_order.total',
        'payment.isDeleted')        
        ->orderBy('invoice_sale_order.id','desc')
        
        ->get();
      //return Datatables::queryBuilder($data)->make(true);
        return response()->json($data);
    }
    
    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
        
        $resolutionID=Resolution::select('next_invoice_number')
        ->where('isDefault',1)
        ->where('account_id',Auth::user()->account_id)
        ->where('isDeleted',0)
        ->where('isActive',1)
        ->first();
        
        $numeration_for_saleOrder=Resolution::select('id','name','prefix','next_invoice_number','auto_increment','isDefault')
        ->where('account_id',Auth::user()->account_id)
        ->where('isDeleted',0)
        ->where('isActive',1)
        ->get()
        ->toArray();
        
        $baseInfo=[
        'public_id' =>Helper::PublicId(InvoiceSaleOrder::class),
        'contacts' => Helper::contacts(),
        'sellers'=>Helper::sellers(),
        'listprice'=>Helper::listPrice(),
        'currency'=>Helper::currencylist(),
        'productlist'=>Helper::productlist(),
        'taxes'=>Helper::taxes(),
        'resolution_id'=>$resolutionID,
        'list_price'=>Helper::listprice_default(),
            'default_Currency'=>Helper::default_currency(),
                'paymentTerms'=>Helper::PaymentTerms(),
                'numerationList_sale_order'=>$numeration_for_saleOrder
                ];
                
                return response()->json($baseInfo);
                
        }
        
        public function create()
        {
            return view('invoice.create');
        }
        
        public function store(Request $request)
        {
            $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'payment_terms_id' => 'required',
            'resolution_number'   =>'required_if:ResolutionIsAutoNumeric,false',
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',
            ]);
            
            
            $data = $request->except('detail','list_price','currency','contact','seller','payment_terms'
            ,'resolution','ResolutionIsAutoNumeric','resolution_id');
            
            
            //el numero de resolución debe ser único
            $checkInvoiceNumber=InvoiceSaleOrder::where('account_id',Auth::user()->account_id)
            ->where('resolution_id',$data['resolution_number'])->get()->count();

            
            if ($checkInvoiceNumber>0)
            {
                return response()
                ->json([
                'invoice_exists' => ['Ya existe una factura con el número '.$data['resolution_number'].' creado, asegúrese de ingresar ún número válido ']
                ], 422);
            }
            
            $products = collect($request->detail)->transform(function($detail) {
                $baseprice=$detail['quantity'] * $detail['unit_price'];
                $totalDiscount= $baseprice*($detail['discount']/100);
                $detail['total'] = $baseprice- $totalDiscount;
                $detail['user_id'] =  Auth::user()->id;
                $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
                return new InvoiceSaleOrderDetail($detail);
            });
            
            
            if($products->isEmpty()) {
                return response()
                ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
                ], 422);
            };
            
            $categoryId=Category::select('id')
            ->where('account_id',Auth::user()->account_id)
            ->where('name','Ventas')
            ->first();
            
            $data['public_id'] = Helper::PublicId(InvoiceSaleOrder::class);
            $data['resolution_id'] = (int)$data['resolution_number'];
            $data['status_id'] = INVOICE_STATUS_OPEN;
            $data['category_id'] = $categoryId['id'];
            $data['account_id'] = Auth::user()->account_id;
            $data['user_id'] = Auth::user()->id;
            $data['date']=Helper::dateFormatter($data['date']);
            $data['due_date']= Helper::dateFormatter($data['due_date']);
            
            //Default
            if (!$data['currency_code'])
            {
                $data['currency_code']=CURRENCY_CODE_DEFAULT;
            }
            
            $invoice = InvoiceSaleOrder::create($data);
            
            $invoice->detail()->saveMany($products);
            
            //Incrementa el numero de cotización
            Resolution::where('account_id', Auth::user()->account_id)
            ->where('id',$request['resolution_id'])
            ->increment('next_invoice_number');
            
            event(new RecordActivity('Create','Se creó la factura de venta número: '
            .$invoice->resolution_id.' para el cliente '.$invoice->contact->name,
            'InvoiceSaleOrder','/invoice/'.$invoice->public_id));
            
            return response()
            ->json([
            'created' => true,
            'id' => $invoice->public_id
            ]);
        }
        
        public function show($id)
        {
            $invoice = InvoiceSaleOrder::with('detail','list_price','seller','payment_terms')
            ->GetByPublicId(0,$id)
            ->GetSelectedFields()
            ->first();
            
            if (!$invoice)
            {
                $notification = array(
                'message' => 'No se encontró ninguna referencia de invoice creadas!',
                'alert-type' => 'error'
                );
                return redirect('/invoice')->with($notification);
            }
            
            $invoice=Helper::_InvoiceFormatter($invoice);
            $taxes=Helper::getTotalTaxes($invoice->public_id,'invoice_sale_order','invoice_sale_order_detail');
           
            $paymentHistorical=$this->paymentRepo->PaymentHistoryByDocument('invoice_sale_order',$invoice->public_id);
            
            return view('invoice.show', compact('invoice','taxes','paymentHistorical'));
        }
        
        public function edit($id)
        {
            
            $invoice = InvoiceSaleOrder::with(['detail','contact','list_price','currency','seller','payment_terms'])
            ->GetByPublicId(0,$id)
            ->GetSelectedFields()
            ->first();
            
            if (request()->get('convert')=='clone')
            {
                $PublicId = Helper::PublicId(InvoiceSaleOrder::class);
                $invoice['public_id']= $PublicId;
                $invoice['date']=Helper::setCustomDateFormat(Carbon::now());
                $invoice['due_date']=Helper::setCustomDateFormat(Carbon::now()->addDays(30));
                $invoice['notes']=null;
                return view('invoice.clone', compact('invoice'));
            }
            
            $checkConverted=request()->get('convert');
            if ($checkConverted=='toInvoice' || $checkConverted=='toInvoiceR')
            {
                $model=null;
                if ($checkConverted=='toInvoice')
                {
                    $model=Estimate::class;
                }
                if ($checkConverted=='toInvoiceR')
                {
                    $model=Remision::class;
                }
                
                $invoice = $model::with(['detail','contact','list_price','currency','seller'])
                ->GetByPublicId(0,$id)
                ->GetSelectedFields()
                ->first();
                
                $resolutionID=Resolution::select('next_invoice_number')
                ->where('isDefault',1)
                ->where('account_id',Auth::user()->account_id)
                ->where('isDeleted',0)
                ->where('isActive',1)
                ->first();
                
                $PublicId = Helper::PublicId(InvoiceSaleOrder::class);
                $invoice['public_id']= $PublicId;
                $invoice['resolution_id']= $resolutionID->next_invoice_number;
                $invoice['date']=Helper::setCustomDateFormat(Carbon::now());
                $invoice['due_date']=Helper::setCustomDateFormat(Carbon::now()->addDays(30));
                $invoice['notes']=null;
                return view('invoice.createFromConvert', compact('invoice'));
            }
            
            
            
            if (!$invoice)
            {
                $notification = array(
                'message' => 'No se encontró ninguna referencia de factura creadas!',
                'alert-type' => 'error'
                );
                return redirect('/invoice')->with($notification);
            }
            
            
            $invoice['date']= Helper::setCustomDateFormat(Carbon::parse($invoice['date']));
            $invoice['due_date']= Helper::setCustomDateFormat(Carbon::parse($invoice['due_date']));
            
            
            return view('invoice.edit', compact('invoice'));
        }
        
        
        public function update(Request $request, $id)
        {
            
            
            $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'payment_terms_id' => 'required',
            'resolution_number'   =>'required_if:ResolutionIsAutoNumeric,false',
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',
            ]);
            
            $invoice = InvoiceSaleOrder::findOrFail($id);
            
            $products = collect($request->detail)->transform(function($detail) {
                $baseprice=$detail['quantity'] * $detail['unit_price'];
                $totalDiscount= $baseprice*($detail['discount']/100);
                $detail['total'] = $baseprice- $totalDiscount;
                $detail['user_id'] =  Auth::user()->id;
                $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
                return new InvoiceSaleOrderDetail($detail);
            });
            
            if($products->isEmpty()) {
                return response()
                ->json([
                'products_empty' => ['Uno o mas productos son requeridos.']
                ], 422);
            };
            $data = $request->except('detail');
            
            $data['user_id'] = Auth::user()->id;
            $data['date']=Helper::dateFormatter($data['date']);
            $data['due_date']= Helper::dateFormatter($data['due_date']);
            $data['resolution_id']= $data['resolution_number'];
            $invoice->update($data);
            
            InvoiceSaleOrderDetail::where('invoice_sale_order_id', $invoice->id)->delete();
            $invoice->detail()->saveMany($products);
            
            event(new RecordActivity('Update','Se actualizó la factura de venta número: '
            .$invoice->resolution_id.' para el cliente '.$invoice->contact->name,
            'InvoiceSaleOrder','/invoice/'.$invoice->public_id));
            
            return response()
            ->json([
            'updated' => true,
            'id' => $invoice->public_id
            ]);
        }
        
        public function destroy($id)
        {
            
            $invoice = InvoiceSaleOrder::GetByPublicId(0,$id)
            ->firstOrFail();
            
            $invoice['isDeleted']=1;
            $invoice['deleted_at']=$now = Carbon::now();
            $invoice->save();
            
            event(new RecordActivity('Delete','Se eliminó la factura de venta número: '
            .$invoice->resolution_id,
            'InvoiceSaleOrder',null));
            
            return response()
            ->json([
            'deleted' => true
            ]);
        }
        
        public function pdf($id, Request $request)
        {
            
            $mypdf=$this->iPdfRepo->create(InvoiceSaleOrder::class, $id);
            
            $filename = "InvoiceSaleOrder_"."{$id}.pdf";
            
            if($request->get('opt') === 'download') {
                return $mypdf->download($filename);
            }
            
            event(new RecordActivity('Print','Se ha impreso el pdf de la factura de venta No: '
            .$id,'InvoiceSaleOrder','/invoice/'.$id));
            
            return $mypdf->stream();
        }
        
        public function update_state(Request $request,$id)
        {
            
            $data = $request->all();
            $data['status_id']= (int)$data['status_id'];
            
            $item = InvoiceSaleOrder::findOrFail($id);
            
            $item->update($data);
            
            event(new RecordActivity('Update','Se actualizó el estado de la factura de venta número: '
            .$item->resolution_id.' para el cliente '.$item->contact->name,
            'InvoiceSaleOrder','/invoice/'.$item->public_id));
            
            return response()
            ->json([
            'updated' => true
            ]);
        }
        
        public function getTemplateEmailToCustomer($estimate_number)
        {
            return $this->emailRepo->TemplateEmailToCustomer(InvoiceSaleOrder::class,$estimate_number);
        }
    }