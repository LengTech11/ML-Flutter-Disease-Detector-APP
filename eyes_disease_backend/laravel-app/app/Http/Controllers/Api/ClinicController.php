<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class ClinicController extends Controller
{
    public function index()
    {
        // Retrieve all users where user_role is 2 (clinics)
        $clinics = User::where('user_role', 2)->get();

        return response()->json([
            'status' => 'success',
            'data' => $clinics,
        ], 200);
    }

    public function show($id)
    {
        // Retrieve a specific user where user_role is 2
        $clinic = User::where('user_role', 2)->findOrFail($id);

        return response()->json([
            'status' => 'success',
            'data' => $clinic,
        ], 200);
    }
}
