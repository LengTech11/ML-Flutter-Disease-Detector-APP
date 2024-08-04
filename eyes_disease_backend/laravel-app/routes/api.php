<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ApiController;
use App\Http\Controllers\PredictionController;

// Register
Route::post("register", [ApiController::class, "register"]);

// Login
Route::post("login", [ApiController::class, "login"]);

// Profile and other protected routes
Route::group(['middleware' => ['auth:sanctum']], function() {
    // Profile
    Route::get("profile", [ApiController::class, "profile"]);

    // Predictions
    Route::post("/save-history", [PredictionController::class, "store"]);
    // fetch all predictions
    Route::get("/predictions", [PredictionController::class, "index"]);

    Route::post('/user-count', [ApiController::class, 'updateUserCount']);

    // Delete User predictions history 1 and all
    Route::delete('/predictions/{id}', [PredictionController::class, 'destroy']);
    Route::delete('/predictions/all', [PredictionController::class, 'destroyAll']);

});

// Public routes
Route::get('/diseases', [ApiController::class, 'showDisease']);
Route::get('/documents', [ApiController::class, 'showDocument']);

// Update Disease Count
Route::post('/update-disease-count', [ApiController::class, 'updateCount']);

Route::post('/change-password', [ApiController::class, 'changePassword'])->middleware('auth:sanctum');



