<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    Category,
    Category2
};


class CategoryController extends Controller
{

    public function index()
    {
        return view('category.index');
    }
 
    public function CategoryIncome()
    {
        //$parent = Category2::find(10);
        //$node->appendToNode($parent)->save();
       
        $income = Category::where('type_id',  1)
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->where('parent_id',"!=",  null)
                ->defaultOrder()
                ->select('id','name','description','lft','rgt','parent_id','isEditable')
                ->withDepth()               
                ->get();

        return response()->json($income);  
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {
    
        $paymentTerms = PaymentTerms::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
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
                ->where('isEnabled',  1)
               ->orderBy('created_at', 'asc')
               ->get();
        
        $baseInfo=[                
                'paymentterms' => $paymentTerms,
               'sellers'=>$sellers,
               'listprice'=>$listPrice              
            ];
             
     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('contact.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required'
        ]);

        $items=[];
        
        foreach($request->contact_others as $item) {
              if($item['name'])
              {
                  if ( $item['notify']==true)
                  {
                        $item['notify']=1;
                  }
                  if ( $item['notify']==false)
                  {
                       $item['notify']=0;
                  }
                $item['account_id'] = Auth::user()->account_id; 
                $item['user_id'] = Auth::user()->id;      
                $items[] = new Contact_others($item);
              }
        }
        
          
        $data = $request->except('contact_others');  

        $currentPublicId = Contact::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['isProvider'] =empty($data['isProvider']) ? 0 : $data['isProvider']; 
        $data['isCustomer'] =empty($data['isCustomer']) ? 0 : $data['isCustomer'];  
        $data['list_price_id'] =empty($data['list_price_id']) ? null : $data['list_price_id'];   
        $data['seller_id'] =empty($data['seller_id']) ? null : $data['seller_id']; 
        $data['payment_terms_id'] =empty($data['payment_terms_id']) ? null : $data['payment_terms_id']; 

        if ($data['isProvider']==true)
        {
            $data['isProvider']=1;
        }
         if ($data['isCustomer']==true)
        {
            $data['isCustomer']=1;
        }
        
       $contact = Contact::create($data);
        $contact->contact_others()->saveMany($items);

     
        return response()
            ->json([
                'created' => true,
                'id' => $contact->public_id
            ]);
    }

    public function show($id)
    {
       

        $contact = Contact::with('contact_others')
                ->where('account_id',  Auth::user()->account_id)
                ->where('public_id',  $id)
                ->where('isDeleted',  0)
                ->first();   
      

        if (!$contact)
        {
            
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );             
          return redirect('/contact')->with($notification);
        }
      
        return view('contact.show', compact('contact'));
    }

  

    public function edit($id)
    {
         $contact = Contact::with(['list_price','seller','payment_terms','contact_others'])
                ->where('account_id',  Auth::user()->account_id)
                ->where('public_id',  $id)
                ->where('isDeleted',  0)
                ->orderBy('created_at', 'desc')
                ->select( 'id','name','nit','address','account_id','user_id','public_id','city','email','phone1','phone2','fax',
                    'phone_mobile','list_price_id','seller_id','payment_terms_id','observation','include_account_state',
                    'isProvider','isCustomer'
                )->first();    

        
         if (!$contact)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/contact')->with($notification);
        }

 
         return view('contact.edit', compact('contact'));
         
         
    }

    public function update(Request $request, $id)
    {        
         

         $this->validate($request, [     
            'name' => 'required'
        ]);
       
         $items=[];
        
        
        foreach($request->contact_others as $item) {
              if($item['name'])
              {
                  if ( $item['notify']==true)
                  {
                        $item['notify']=1;
                  }
                  if ( $item['notify']==false)
                  {
                       $item['notify']=0;
                  }
                $item['account_id'] = Auth::user()->account_id; 
                $item['user_id'] = Auth::user()->id;      
                $items[] = new Contact_others($item);
              }
        }
        
    
         $data = $request->except('contact_others');  
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['isProvider'] =empty($data['isProvider']) ? 0 : $data['isProvider']; 
        $data['isCustomer'] =empty($data['isCustomer']) ? 0 : $data['isCustomer'];  
        $data['list_price_id'] =empty($data['list_price_id']) ? null : $data['list_price_id'];   
        $data['seller_id'] =empty($data['seller_id']) ? null : $data['seller_id']; 
        $data['payment_terms_id'] =empty($data['payment_terms_id']) ? null : $data['payment_terms_id']; 

        if ($data['isProvider']==true)
        {
            $data['isProvider']=1;
        }
         if ($data['isCustomer']==true)
        {
            $data['isCustomer']=1;
        }
        
        
        $contact = Contact::findOrFail($id);
        try{
            $contact->update($data);    
        }
        catch (\exception $e){
            return response()
            ->json([
                'updated' => false,
                'message' => "No se pudo actualizar correctamente el contacto, intente de nuevo"            
            ]);
        }
        contact_others::where('contact_id', $contact->id)->delete();
        $contact->contact_others()->saveMany($items);
        
        return response()
            ->json([
                'updated' => true,
                'id' => $contact->public_id             
            ]);
    }
    
    public function destroy($id)
    {

            $contact = Contact::where('account_id',  Auth::user()->account_id)
                ->where('public_id',  $id)
                ->firstOrFail();   
            
            $contact['isDeleted']=1;
            $contact['deleted_at']=$now = Carbon::now();
            $contact->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }
}
