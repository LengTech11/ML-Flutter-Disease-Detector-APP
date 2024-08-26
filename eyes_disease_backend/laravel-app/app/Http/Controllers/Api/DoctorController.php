<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Doctor;

class DoctorController extends Controller
{
    public function index()
    {
        $doctors = Doctor::all();

        return response()->json([
            'status' => 'success',
            'data' => $doctors,
        ], 200);
    }

    public function show($id)
    {
        $doctor = Doctor::findOrFail($id);

        return response()->json([
            'status' => 'success',
            'data' => $doctor,
        ], 200);
    }
}
