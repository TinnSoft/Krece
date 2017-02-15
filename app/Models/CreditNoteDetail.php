<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\Tax;
use Illuminate\Support\Facades\DB;

class CreditNoteDetail extends Model
{   
   
    protected $table = 'credit_note_detail';
    protected $fillable=['credit_note_id','user_id','product_id','reference','unit_price','discount','tax_id','tax_amount',
    'name','description','quantity','total_tax','total'];
     protected $dates = ['deleted_at'];

    public function creditnote()
    {
        return $this->belongsTo(CreditNote::class);
    }

        public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id')->select(array('id', 'name'));    
    }
        public function taxes()
    {
        return $this->hasOne(Tax::class, 'id', 'tax_id')->select(array(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value','id'));        
    }
    
}
