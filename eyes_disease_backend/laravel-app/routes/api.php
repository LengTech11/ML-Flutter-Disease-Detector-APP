<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ApiController;
use App\Http\Controllers\PredictionController;
use App\Http\Controllers\Api\ClinicController;
use App\Http\Controllers\Api\DoctorController;
use App\Http\Controllers\Api\AppointmentRequestController;
use App\Http\Controllers\Api\NewsController;
use App\Http\Controllers\Api\MessagesController;


// Register
Route::post("register", [ApiController::class, "register"]);

// Login
Route::post("login", [ApiController::class, "login"]);

// New routes for Clinic and Doctor
Route::get('/clinics', [ClinicController::class, 'index']);
Route::get('/clinics/{id}', [ClinicController::class, 'show']);

// Get all doctors
Route::get('/doctors', [DoctorController::class, 'index']);
Route::get('/doctors/{id}', [DoctorController::class, 'show']);

// Profile and other protected routes
Route::group(['middleware' => ['auth:sanctum']], function() {
    // Profile
    Route::get("profile", [ApiController::class, "getProfile"]);
    // Edit Profile
    Route::post("edit-profile", [ApiController::class, "editProfile"]);

    // Predictions
    Route::post("/save-history", [PredictionController::class, "store"]);
    // fetch all predictions
    Route::get("/predictions", [PredictionController::class, "index"]);

    Route::post('/user-count', [ApiController::class, 'updateUserCount']);

    // Delete User predictions history 1 and all
    Route::delete('/predictions/{id}', [PredictionController::class, 'destroy']);
    Route::delete('/predictions/all', [PredictionController::class, 'destroyAll']);

    // Appointment API
    Route::post('/appointment-requests', [AppointmentRequestController::class, 'store']);
    Route::get('/appointment-requests', [AppointmentRequestController::class, 'index']);
    Route::get('/appointment-requests/{id}', [AppointmentRequestController::class, 'show']);
    Route::put('/appointment-requests/{id}', [AppointmentRequestController::class, 'update']);
    Route::delete('/appointment-requests/{id}', [AppointmentRequestController::class, 'destroy']);

    //the news routes
    Route::apiResource('news', NewsController::class);
    //the messages routes
    Route::apiResource('messages', MessagesController::class);


});


// Public routes
Route::get('/diseases', [ApiController::class, 'showDisease']);
Route::get('/documents', [ApiController::class, 'showDocument']);

// Update Disease Count
Route::post('/update-disease-count', [ApiController::class, 'updateCount']);

Route::post('/change-password', [ApiController::class, 'changePassword'])->middleware('auth:sanctum');
