<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\Tax;
use App\Models\TaxType;
use Illuminate\Support\Facades\DB;

class TaxesController extends Controller
{

    public function index()
    {
        //Obtener las cotizaciones creadas hasta la fecha       
        $taxlist = Tax::with('tax_type')
                ->where('tax.account_id',  Auth::user()->account_id)
                ->where('tax.isDeleted',  0)
               ->orderBy('created_at', 'desc')
               ->select('tax.id', 'tax.account_id','tax.public_id',
               'tax.name','tax.amount','tax.description',
               'tax.type_id'
               )->get();  

        return view('taxes.index',compact('taxlist'));
  
    }

    public function create()
    {
        return view('Taxes.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required',               
            'amount' => 'required|numeric',
            'type_id' => 'required',
        ]);
   
        $data = $request->except('tax_type'); 

        $currentPublicId = Tax::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;    

        $tax = Tax::create($data);
         
        return response()
            ->json([
                'created' => true,
                'id' => $tax->id
            ]);
    }


    public function BaseInfo()
    {  
        
               $taxtypeList = TaxType::select('id', 'name')              
               ->orderBy('id', 'asc')
               ->get();
        

         return response()->json($taxtypeList);
    }

    public function edit($id)
    {    

          $taxlist = Tax::with('tax_type')
                ->where('tax.account_id',  Auth::user()->account_id)
                ->where('tax.isDeleted',  0)
               ->orderBy('created_at', 'desc')
               ->select('tax.id','tax.account_id','tax.public_id',
               'tax.name','tax.amount','tax.description',
               'tax.type_id'
               )->find($id);           
   
         if (!$taxlist)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia creada!', 
                'alert-type' => 'error'
            );
          return redirect('/taxes')->with($notification);
        }
         return view('taxes.edit', compact('taxlist'));
    }

   public function update(Request $request, $id)
    {       
      
        $this->validate($request, [     
            'name' => 'required',               
            'amount' => 'required|numeric',
            'type_id' => 'required',
        ]);
       
        $tax = Tax::findOrFail($id);    
        $data = $request->except('tax_type'); 
        $tax->update($data);
        
        return response()
            ->json([
                'updated' => true,
                'id' => $tax->id              
            ]);
    }
    
    public function destroy($id)
    {
            $tax = Tax::findOrFail($id);

            $tax['isDeleted']=1;
            $tax['deleted_at']=$now = Carbon::now();
            $tax->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }

}
