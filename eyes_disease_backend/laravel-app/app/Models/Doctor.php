<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Doctor extends Model
{
    use HasFactory;

    static public function getSingleDoctor($id)
    {
        return self::find($id);
    }

    static public function getTotalDoctor()
    {
        return self::select('doctors.*')
                        ->count();
    }
}
