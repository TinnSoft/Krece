<?php

namespace App\Models;
use Kalnoy\Nestedset\NodeTrait;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use NodeTrait;
    protected $table = 'category';
    protected $dates = ['deleted_at'];
    
    protected $fillable = [
        'account_id','parent_id','name','niif_account','description','type_id','user_id','isEditable','isDeleted',
        'lft','rgt',
    ];

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

}
