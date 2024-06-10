<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class DashboardController extends Controller
{
    public function dashboard()
    {
        $data['totalUser'] = User::getTotalUser();

        return view('dashboard', $data);
    }
}
