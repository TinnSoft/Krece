<?php

namespace App\Models;
use Kalnoy\Nestedset\NodeTrait;
use Illuminate\Database\Eloquent\Model;
use Auth;
use Illuminate\Support\Facades\DB;

class Category extends Model
{
    use NodeTrait;
    protected $table = 'category';
    protected $dates = ['deleted_at'];
    
    protected $fillable = [
        'account_id','parent_id','name','niif_account','description','type_id','user_id','isEditable','isDeleted',
        'lft','rgt',
    ];

    
    public function detail()
    {
          return $this->hasMany(Category::class,'type_id','type_id')
                    ->where('account_id',Auth::User()->account_id)
                    ->where('isDeleted',0)
                    ->where('parent_id','!=',null)
                    ->select(array('id', 'name','type_id',DB::raw("1 AS isCategory")));
    }

     public function type()
    {
         return $this->hasOne(CategoryType::class, 'id', 'type_id')->select(array('id', 'type as description'));
    }

    
     public function getLftName()
    {
        return 'lft';
    }

    public function getRgtName()
    {
        return 'rgt';
    }

    public function getParentIdName()
    {
        return 'parent_id';
    }
      public function getDepthName()
    {
        return 'depth';
    }
    // Specify parent id attribute mutator
    public function setParentAttribute($value)
    {
        $this->setParentIdAttribute($value);
    }

    public function scopeCategoryAttributes($query)
    {
        return $query->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)               
                ->defaultOrder()
                ->select('id','name','description','lft','rgt','parent_id','isEditable','niif_account')
                ->withDepth();
    }
}
