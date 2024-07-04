<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Disease extends Model
{
    use HasFactory;

    protected $table = 'diseases';
    protected $fillable = ['title', 'description'];

    static public function getDisease()
    {
        return self::select('diseases.*')
                        ->orderBy('id', 'desc')
                        ->get();
    }

    static public function getTotalDisease()
    {
        return self::select('diseases.*')
                        ->count();
    }

    static public function getSingleDisease($id)
    {
        return self::find($id);
    }

}
