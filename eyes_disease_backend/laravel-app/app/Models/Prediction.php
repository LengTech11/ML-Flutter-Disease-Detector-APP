<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prediction extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'predicted_class',
        'confidence',
        'image_url',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    static public function getSinglePrediction($id)
    {
        return self::find($id);
    }
}
