<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Disease;

class DashboardController extends Controller
{
    public function dashboard()
    {
        $data['totalUser'] = User::getTotalUser();
        $data['getRecord'] = User::getUser();
        $data['totalDisease'] = Disease::getTotalDisease();
        $data['totalDiseaseCount'] = Disease::sum('count');
        $data['totalDiseaseCountWithoutUnknown'] = Disease::where('title', '!=', 'Unknown')->where('title', '!=', 'unknown')->sum('count');
        $data['totalNormalClass'] = Disease::where('title', '=', 'Normal')->sum('count');
        $data['totalCataractClass'] = Disease::where('title', '=', 'Cataract')->sum('count');
        $data['totalDiabeticClass'] = Disease::where('title', '=', 'Diabetic_retinopathy')->sum('count');
        $data['totalUnknownClass'] = Disease::where('title', '=', 'Unknown')->sum('count');

        return view('dashboard', $data);
    }
}
