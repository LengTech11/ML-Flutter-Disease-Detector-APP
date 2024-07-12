<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ApiController;

// Register
Route::post("register", [ApiController::class, "register"]);

// Login
Route::post("login", [ApiController::class, "login"]);

//Profile
Route::group([
    'middleware' => ['auth:sanctum']
], function(){
    //Profile
    Route::get("profile", [ApiController::class, "profile"]);
});


// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');


Route::get('/diseases', [ApiController::class, 'showDisease']);

Route::get('/documents', [ApiController::class, 'showDocument']);

Route::post('/change-password', [ApiController::class, 'changePassword'])->middleware('auth:sanctum');



