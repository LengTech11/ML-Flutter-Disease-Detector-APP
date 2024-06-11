<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class ApiController extends Controller
{
    public function register(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'first_name' => 'required',
                'last_name' => 'required',
                'email' => 'required|email|unique:users,email',
                'age' => 'required|integer',
                'gender' => 'required|integer',
                'password' => 'required',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'validation error',
                    'error' => $validator->errors(),
                ],422);
            }

            if (!Auth::attempt($request->only(['email', 'password']))) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'invalid login details',
                ]);
            }

            $user = User::create([
                'first_name' => $request->first_name,
                'last_name' => $request->last_name,
                'email' => $request->email,
                'age' => $request->age,
                'gender' => $request->gender,
                'password' => Hash::make($request->password),
            ]);

            return response()->json([
                'status' => 'success',
                'message' => 'user created successfully',
                'token' => $user->createToken('API TOKEN')->plainTextToken
            ],200);
        }catch(\Trowable $th){
            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ],500);
        }
    }

    public function login(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'email' => 'required|email',
                'password' => 'required',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'validation error',
                    'error' => $validator->errors(),
                ],422);
            }

            if (!Auth::attempt($request->only('email', 'password'))) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'invalid login details',
                ]);
            }

            $user = User::where('email', $request->email)->first();
            return response()->json([
                'status' => 'success',
                'message' => 'User logged In successfully',
                'token' => $user->createToken('API TOEKN')->plainTextToken
            ],200);

        }catch(\Trowable $th){
            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ],500);
        }
    }

    public function profile(Request $request)
    {
        $userData  = auth()->user();
        return response()->json([
            'id' => auth()->user()->id,
            'status' => 'success',
            'message' => 'User profile',
            'data' => $userData,
        ],200);
    }
}

