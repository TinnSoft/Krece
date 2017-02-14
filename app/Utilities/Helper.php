<?php namespace App\Utilities;
use App\Models\{
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber,
    PaymentTerms
};
use Illuminate\Support\Facades\DB;
use Auth;
use Carbon\Carbon;

class Helper
{
 public static function formatMoney($value)
 {
     $valconverted=$value;
     try{
     $valconverted=number_format($value, '2', '.', ',');
     }
     catch(\exception $e){}

    return $valconverted;
 }
   public static function setCustomDateFormat($dateval)
    {            
        $day=$dateval->day;
        $month=$dateval->month;
        $year=$dateval->year;
        return $day.'/'. $month.'/'.$year;   
    }

    public static function currencylist()
    {
       return  DB::table('currency')
        ->join('currency_code', function ($join) {
            $join->on('currency.code_id', '=', 'currency_code.code')
                 ->where('currency.account_id', Auth::user()->account_id);
        })
        ->orderBy('currency_code.order', 'desc')
               ->select('currency.code_id', 'currency_code.code','currency_code.symbol')
               ->get()
                ->toArray();
    }
    public static function contacts()
    {
         return Contact::with('seller')
                ->select('id', 'name','seller_id')
                ->where('account_id',  Auth::user()->account_id)->where('isCustomer', '=', 1)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get()
                ->toArray();
    }

    public static function sellers()
    {

        return Seller::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->where('isEnabled',  1)
               ->orderBy('created_at', 'asc')
               ->get()
               ->toArray();
    }

    public static function listPrice()
    {
         return ListPrice::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get()
               ->toArray();
    }
    public static function taxes()
    {
       return Tax::select(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value')
       ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get()
               ->toArray();
    }
    public static function productlist()
    {
        return Product::select('id', 'name','description','sale_price','reference')
                    ->where('account_id',  Auth::user()->account_id)
                    ->where('isDeleted',  0)
                ->orderBy('created_at', 'asc')
                ->get()
                ->toArray();
    }

      public static function PaymentTerms()
    {
        return PaymentTerms::select('id', 'name','days')
                    ->where('account_id',  Auth::user()->account_id)
                    ->where('isDeleted',  0)
                ->orderBy('created_at', 'asc')
                ->get()
                ->toArray();
    }

    public static function ResolutionId($model,$key)
    {
        return $model::where('account_id',  Auth::user()->account_id)
                        ->where('key','=',$key)
                        ->select('number')
                        ->first()
                        ->toArray();
    }
    public static function PublicId($model)
    {
         return $model::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
    }

    public static function listprice_default()
    {
        return ListPrice::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->first();
    }

    public static function default_currency()
    {
         return [
            'code_id' => 'COP',
           'code' => 'COP',
           'symbol' => '$'];
    }
    //realiza el formato de mneda y fecha para los arreglos tipo factura (nvoice, remision, estimate, etc..)
    public static function _InvoiceFormatter($model_in)
    {
        $model_in['total']=Helper::formatMoney($model_in['total']);
        $model_in['sub_total']=Helper::formatMoney($model_in['sub_total']);
        $model_in['total_taxes']=Helper::formatMoney($model_in['total_taxes']);
        $model_in['total_discounts']=Helper::formatMoney($model_in['total_discounts']);
       
       foreach($model_in->detail as $item) 
        {
            $item['unit_price']=Helper::formatMoney($item['unit_price']);
            $item['total']=Helper::formatMoney($item['total']);
        }  
        
        $model_in['date']=Carbon::parse($model_in['date'])->toFormattedDateString(); 
        $model_in['due_date']=Carbon::parse($model_in['due_date'])->toFormattedDateString(); 

        return $model_in;
    }

}