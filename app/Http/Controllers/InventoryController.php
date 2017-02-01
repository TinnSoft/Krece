<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    ProductInventoryType,
    product_inventory_type,
    Seller,
    Tax,
    ListPrice,
    Product
};


use Illuminate\Support\Facades\DB;

class InventoryController extends Controller
{

    public function index()
    {
        return view('inventory.index');  
    }

     public function InventoryIndex()
    {
       $products = Product::where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->orderBy('public_id', 'desc')
                ->select( 'name','reference','sale_price','description','isActive','public_id','tax_id','category_id','id'
               )->get();    

        return response()->json($products);  
    }

   
    public function BaseInfo()
    {
   
        $taxes = Tax::select(DB::raw("CONCAT(name,' (',amount,'%)') as name"),'amount','id')
       ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get();


        $measure_unit = ProductInventoryType::select('measure_type')
               ->groupBy('measure_type')
               ->orderBy('id', 'asc')
               ->get();
        
         $measure=[];
        
        foreach($measure_unit as $item) {
              $measure_type = ProductInventoryType::select('id','measure_unit')
              ->where('measure_type',  $item->measure_type)
               ->orderBy('id', 'asc')
               ->get();

             $measure[] = array(
                'measure_type' => $item->measure_type, 
                'measure' =>  $measure_type
            );
        }

        $listPrice = ListPrice::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->where('isEnabled',  1)
               ->orderBy('created_at', 'asc')
               ->get();
        
        $baseInfo=[                
                'taxes' => $taxes,
               'measure_unit'=>$measure,
               'listprice'=>$listPrice              
            ];
             
     return response()->json($baseInfo);

    }

    public function create()
    {
        return view('inventory.create');        
    }
        
    public function store(Request $request)
    {             
          $this->validate($request, [     
            'name' => 'required',
            'sale_price' => 'required',
            'tax_id' => 'required',
            'category_id' => 'required'
            ]);        
        
        $data = $request->except('tax');  

        $currentPublicId = Product::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['list_price_id'] =empty($data['list_price_id']) ? null : $data['list_price_id'];   
        $data['tax_id'] =empty($data['tax_id']) ? null : $data['tax_id']; 
        $data['inv_type_id'] =empty($data['inv_type_id']) ? null : $data['inv_type_id'];
        if ( $data['inv_inStock']==true)
         {
              $data['inv_inStock'] =1;
         }
         elseif ( $data['inv_inStock']==false)
         {
              $data['inv_inStock'] =0;
         }
         else 
         {
              $data['inv_inStock'] =0;
         }
       
        
       $item = Product::create($data);
     
        return response()
            ->json([
                'created' => true,
                'id' => $item->public_id
            ]);
    }

    public function show($id)
    {
         $products = Product::with(['tax','list_price','measure_unit'])
                ->where('account_id',  Auth::user()->account_id)
                ->where('public_id',  $id)
                ->where('isDeleted',  0)
                ->orderBy('created_at', 'desc')
                ->select( 'id','name','reference','sale_price','description','tax_id','public_id','inv_type_id',
                'inv_unit_cost','inv_inStock','inv_quantity_initial','isActive','inv_quantity_actual'
                )->first();    
         
        if (!$products)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia en nuestra base de datos!', 
                'alert-type' => 'error'
            );

          return redirect('/inventory')->with($notification);
        }
      
        return view('inventory.show', compact('products'));
    }

    public function edit($id)
    {
        
         $products = Product::with(['tax','list_price','measure_unit'])
                ->where('account_id',  Auth::user()->account_id)
                ->where('public_id',  $id)
                ->where('isDeleted',  0)
                ->orderBy('created_at', 'desc')
                ->select( 'id','name','reference','sale_price','description','tax_id','public_id','inv_type_id',
                'inv_unit_cost','inv_inStock','inv_quantity_initial','isActive','category_id'
                )->first();    

        
         if (!$products)
        {
            $notification = array(
                'message' => 'No se encontró ningún valor en nuestra base de datos!', 
                'alert-type' => 'error'
            );
          return redirect('/inventory')->with($notification);
        }
 
         return view('inventory.edit', compact('products'));
         
         
    }

    public function update(Request $request, $id)
    {   
        //Actualizar solamente de activo para inactivo o biseversa
        try{
            $data = $request->except('tax');         
            $avoidValidate=$data['validate'];
            $data = $request->except('validate'); 
             $data['isActive']= (int)$data['isActive'];

            $item = Product::findOrFail($id);
            $item->update($data);
            
            return response()
            ->json([
                'updated' => true                           
            ]);
        }
        catch(\exception $e){}
        
        $this->validate($request, [     
            'name' => 'required',
            'sale_price' => 'required',
            'tax_id' => 'required',
            'category_id' => 'required'
        ]);
        
    
      
        $data = $request->except('list_price','measure_unit','tax');  
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
         
         if ( $data['inv_inStock']==true)
         {
              $data['inv_inStock'] =1;
         }
         elseif ( $data['inv_inStock']==false)
         {
              $data['inv_inStock'] =0;
         }
         else 
         {
              $data['inv_inStock'] =0;
         }

        $item = Product::findOrFail($id);
        $item->update($data);
       
        return response()
            ->json([
                'updated' => true,
                'id' => $item->public_id             
            ]);
    }
    
    public function destroy($id)
    {

            $contact = Product::where('account_id',  Auth::user()->account_id)
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
