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
                ->select('id','name','description','lft','rgt','parent_id','isEditable','niif_account')
                ->withDepth()               
                ->get();

        return response()->json($income);  
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required'
        ]);
        
        $data = $request->all();  
          
          //get parent info
        $parent = Category::find($data['parent_id']);
        

        $newCategory=[ 'name' => $data['name'],
                    'account_id'=>Auth::user()->account_id,
                    'user_id'=>  Auth::user()->id,
                    'type_id'=>$parent['type_id'],
                     'niif_account'=>$data['niif_account'],
                    'isEditable'=>1,
                    'description'=>$data['description']
                    ];

        try{    
           Category::create($newCategory, $parent); 

        }
        catch(\exception $e){
              return response()
            ->json([
                'created' => false               
            ]);
        }

        return response()
            ->json([
                'created' => true               
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

    public function update(Request $request, $id)
    {      
        $this->validate($request, [     
            'name' => 'required'
        ]);

        $data = $request->except('parent_id');     
       
        $category = Category::findOrFail($id);

       
        try{
            $category->update($data);    
        }
        catch (\exception $e){
            return response()
            ->json([
                'updated' => false,
                'message' => "No se pudo actualizar correctamente la categoría, intente de nuevo"            
            ]);
        }
      
        return response()
            ->json([
                'updated' => true                  
            ]);
    }
    
    public function destroy($id)
    {       

        try{
            $node = Category::findOrFail($id);
            $node->delete();
            return response()
            ->json([
                'deleted' => true
            ]);
        }
        catch(\exception $e){
            return response()
            ->json([
                'deleted' => false
            ]);
        }
    }
}
