<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Doctor;
use Illuminate\Support\Facades\Storage;

class DoctorController extends Controller
{
    // public function index()
    // {
    //     $doctors = Doctor::all();

    //     foreach ($doctors as $doctor) {
    //         if ($doctor->profile) {
    //             $doctor->profile = Storage::url($doctor->profile);
    //         }
    //     }

    //     return response()->json([
    //         'status' => 'success',
    //         'data' => $doctors,
    //     ], 200);
    // }

    public function index()
    {
        $doctors = Doctor::all();

        foreach ($doctors as $doctor) {
            if ($doctor->profile_pic) {
                // Generate a URL for the profile picture
                $doctor->profile_pic = Storage::url('public/' . $doctor->profile_pic);
            }
        }

        return response()->json([
            'status' => 'success',
            'data' => $doctors,
        ], 200);
    }

    public function show($id)
    {
        try {
            $doctor = Doctor::findOrFail($id);
            return response()->json([
                'status' => 'success',
                'data' => $doctor,
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Doctor not found',
            ], 404);
        }
    }
}
