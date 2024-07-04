<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Document extends Model
{
    use HasFactory;

    protected $table = 'documents';
    protected $fillable = ['title', 'description', 'disease_id'];

    public function disease()
    {
        return $this->belongsTo(Disease::class);
    }

    static public function getSingleDocument($id)
    {
        return self::find($id);
    }

    static public function getDocument()
    {
        return self::select('documents.*')
                        ->orderBy('id', 'desc')
                        ->get();
    }

    static public function getTotalDocument()
    {
        return self::select('documents.*')
                        ->count();
    }
}
