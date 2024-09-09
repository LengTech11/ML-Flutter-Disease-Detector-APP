<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Doctor;
use App\Models\Document;
use App\Models\Disease;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

/**
 * @OA\Info(
 *    version="1.0.0",
 *    title="Disease Prediction API",
 *    description="Disease Prediction API Documentation"
 *  )
 *
 * @OA\SecurityScheme(
 *     securityScheme="bearerAuth",
 *     type="http",
 *     scheme="bearer",
 *     bearerFormat="JWT",
 *     description="Enter your bearer token"
 *  )
 */

class ApiController extends Controller
{
    /**
     * @OA\Post(
     *     path="/api/register",
     *     summary="Register a new user",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 type="object",
     *                 @OA\Property(property="first_name", type="string"),
     *                 @OA\Property(property="last_name", type="string"),
     *                 @OA\Property(property="email", type="string"),
     *                 @OA\Property(property="age", type="integer"),
     *                 @OA\Property(property="gender", type="integer"),
     *                 @OA\Property(property="password", type="string")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="User created successfully",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string"),
     *             @OA\Property(property="message", type="string"),
     *             @OA\Property(property="token", type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string"),
     *             @OA\Property(property="message", type="string"),
     *             @OA\Property(property="errors", type="object")
     *         )
     *     )
     * )
     */
    public function register(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'first_name' => 'required|string|max:255',
                'last_name' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email|max:255',
                'age' => 'required|integer',
                'gender' => 'required|integer',
                'password' => 'required|string|min:8',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Validation error',
                    'errors' => $validator->errors(),
                ], 422);
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
                'message' => 'User created successfully',
                'token' => $user->createToken('API TOKEN')->plainTextToken
            ], 201);
        } catch (\Throwable $th) {
            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    /**
     * @OA\Post(
     *     path="/api/login",
     *     summary="Login a user",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 type="object",
     *                 @OA\Property(property="email", type="string", example="visioncare@gmail.com"),
     *                 @OA\Property(property="password", type="string", example="061706202")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="User logged in successfully",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string"),
     *             @OA\Property(property="message", type="string"),
     *             @OA\Property(property="token", type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Invalid login details",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string"),
     *             @OA\Property(property="message", type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string"),
     *             @OA\Property(property="message", type="string"),
     *             @OA\Property(property="errors", type="object")
     *         )
     *     )
     * )
     */
    public function login(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'email' => 'required|email',
                'password' => 'required|string|min:8',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Validation error',
                    'errors' => $validator->errors(),
                ], 422);
            }

            if (!Auth::attempt($request->only('email', 'password'))) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Invalid login details',
                ], 401);
            }

            $user = User::where('email', $request->email)->first();
            return response()->json([
                'status' => 'success',
                'message' => 'User logged in successfully',
                'token' => $user->createToken('API TOKEN')->plainTextToken
            ], 200);

        } catch (\Throwable $th) {
            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    /**
     * @OA\Get(
     *     path="/api/profile",
     *     summary="Get user profile",
     *     security={{"bearerAuth": {}}},
     *     @OA\Response(
     *         response=200,
     *         description="User profile",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string"),
     *             @OA\Property(property="message", type="string"),
     *             @OA\Property(property="data", type="object",
     *                 @OA\Property(property="id", type="integer"),
     *                 @OA\Property(property="first_name", type="string"),
     *                 @OA\Property(property="last_name", type="string"),
     *                 @OA\Property(property="email", type="string"),
     *                 @OA\Property(property="age", type="integer"),
     *                 @OA\Property(property="gender", type="integer"),
     *                 @OA\Property(property="profile", type="string", format="uri")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string"),
     *             @OA\Property(property="message", type="string")
     *         )
     *     )
     * )
     */
    public function getProfile(Request $request)
    {
        $user = auth()->user();

        // Include the full URL of the profile image
        if ($user->profile) {
            $user->profile = Storage::url($user->profile);
        }

        return response()->json([
            'id' => $user->id,
            'status' => 'success',
            'message' => 'User profile',
            'data' => $user,
        ], 200);
    }

    public function editProfile(Request $request)
    {
        $user = auth()->user();

        // Handle the profile image upload
        if ($request->hasFile('profile')) {
            $file = $request->file('profile');
            $filename = time() . '.' . $file->getClientOriginalExtension();

            // Store the image in the 'public' disk under the 'profiles' directory
            $imagePath = $file->storeAs('profiles', $filename, 'public');

            // Delete the old profile image
            if ($user->profile) {
                Storage::delete('public/' . $user->profile);
            }

            $user->profile = $imagePath;
        } else if ($request->input('profile') === null) {
            // If the profile is set as null, delete the old profile image
            if ($user->profile) {
                Storage::delete('public/' . $user->profile);
            }

            $user->profile = null;
        }

        $user->update($request->except('profile'));

        return response()->json([
            'status' => 'success',
            'message' => 'User profile updated successfully',
            'data' => $user,
        ], 200);
    }

    public function showDisease()
    {
        $diseases = Disease::select('id', 'title', 'description')->where('title', '!=', 'Unknown')->get();

        return response()->json([
            'status' => 'success',
            'data' => $diseases
        ], 200);
    }

    public function showDocument(Request $request)
    {
        $diseaseTitle = $request->query('disease');

        if (!$diseaseTitle) {
            return response()->json([
                'status' => 'error',
                'message' => 'No disease parameter provided'
            ], 400);
        }

        $doc = Document::whereHas('disease', function ($query) use ($diseaseTitle) {
            $query->where('title', 'LIKE', $diseaseTitle);
        })->get();

        $doc = $doc->map(function ($doc) {
            return [
                'id' => $doc->id,
                'file_name' => $doc->title,
                'url' => asset('storage/document/' . rawurlencode($doc->title)),
                'disease' => $doc->disease ? $doc->disease->title : null
            ];
        });

        return response()->json([
            'status' => 'success',
            'data' => $doc
        ], 200);
    }


    public function changePassword(Request $request)
    {
        try
        {
            $validator = Validator::make($request->all(), [
                'old_password' => 'required',
                'password' => 'required|string|min:8',
                'confirm_password' => 'required|same:password'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Validation error',
                    'errors' => $validator->errors(),
                ], 422);
            }

            $user = $request->user();
            if(Hash::check($request->old_password, $user->password))
            {
                $user->update([
                    'password'=> Hash::make($request->password)
                ]);
                return response()->json([
                    'status' => 'success',
                    'message' => 'Password Successfully Updated',
                ], 200);
            }
            else
            {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Old password do not matched',
                ], 400);
            }

        } catch (\Throwable $th) {
            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }

    public function updateCount(Request $request)
    {
        $request->validate([
            'title' => 'required|string',
        ]);

        $title = $request->input('title');

        // Find the disease by title
        $disease = Disease::where('title', $title)->first();

        if($disease)
        {
            $disease->count = $disease->count + 1;
            $disease->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Disease count has been updated.',
                'disease' => $disease,
                'count' => $disease->count
            ]);
        }
        else
        {
            return response()->json([
                'status' => 'error',
                'message' => 'Disease not found.'
            ]);
        }
    }

    public function updateUserCount(Request $request) {

        // Get the currently authenticated user
        $user = Auth::user();

        if ($user)
        {
            $user->count = $user->count + 1;
            $user->save();

            return response()->json([
                'user' => $user,
                'status' => 'success',
                'message' => 'User count has been updated.',
                'count' => $user->count
            ]);
        }
        else
        {
            return response()->json([
                'status' => 'error',
                'message' => 'User not authenticated.'
            ]);
        }
    }

    public function getClinicUser(Request $request)
    {
        $user = User::where('user_role', 2)->get();

    public function getClinicUser(Request $request)
    {
        $user = User::where('user_role', 2)->get();

        return response()->json([
            'status' => 'success',
            'data' => $user
        ], 200);
    }

    public function getAllDoctors(Request $request)
    {
        $doctors = Doctor::all();

        return response()->json([
            'status' => 'success',
            'data' => $doctors
        ], 200);
    }
}
