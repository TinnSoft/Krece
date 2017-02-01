<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\Seller;

class SellerController extends Controller
{

    public function index()
    {      
        $seller = Seller::where('account_id',  Auth::user()->account_id)
            ->where('isDeleted',  0)
               ->orderBy('created_at', 'desc')
               ->select('id', 'name','dni',
               'work_phone','private_phone','observations','isEnabled'
               )->get();    

        return view('seller.index',compact('seller'));
  
    }

    public function create()
    {
        return view('seller.create');        
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required'  
        ]);


        $data = $request->except('estimatedetail');       

        $currentPublicId = Seller::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;

         $seller = Seller::create($data);
     
        return response()
            ->json([
                'created' => true,
                'id' => $seller->id
            ]);
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
        $seller = Seller::where('account_id',  Auth::user()->account_id)->find($id);        
        if (!$seller)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
          return redirect('/seller.index')->with($notification);
        }

         return view('seller.edit', compact('seller'));
         
    }

    public function update(Request $request, $id)
    {        
              
        $this->validate($request, [     
            'name' => 'required'
        ]);
       
        $seller = Seller::findOrFail($id);

        $data = $request->except('estimatedetail'); 
        $data['user_id'] = Auth::user()->id;
        
        $seller->update($data);

        return response()
            ->json([
                'updated' => true,
                'id' => $seller->id              
            ]);
    }
    
    public function destroy($id)
    {
         $seller = Seller::findOrFail($id);

            $seller['isDeleted']=1;
            $seller['deleted_at']=$now = Carbon::now();
            $seller->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }
}
