<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Document extends Model
{
    use HasFactory;

    static public function getDocument()
    {
        return self::select('documents.*')
                        ->orderBy('id', 'desc')
                        ->get();
    }
}
