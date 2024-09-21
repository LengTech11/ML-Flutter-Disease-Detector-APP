<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Storage;

class ClinicController extends Controller
{
    public function index()
    {
        // Retrieve all users where user_role is 2 (clinics)
        $clinics = User::where('user_role', 2)->get();

        foreach ($clinics as $clinic) {
            if ($clinic->profile) {
                $clinic->profile = Storage::url($clinic->profile);
            }
        }

        return response()->json([
            'status' => 'success',
            'data' => $clinics,
        ], 200);
    }

    public function show($id)
    {
        try {
            // Retrieve a specific user where user_role is 2
            $clinic = User::where('user_role', 2)->findOrFail($id);

            if ($clinic->profile) {
                $clinic->profile = Storage::url($clinic->profile);
            }

            return response()->json([
                'status' => 'success',
                'data' => $clinic,
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Clinic not found',
            ], 404);
        }
    }
}
