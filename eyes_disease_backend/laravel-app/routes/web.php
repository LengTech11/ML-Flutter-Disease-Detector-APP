<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DiseaseController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\PredictionController;



Route::get('/', function () {
    if (Auth::check()) {
        return redirect('/dashboard');
    }
    return view('auth/login');
});

// Route::get('/dashboard', function () {
//     return view('dashboard');
// })->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'dashboard'])->name('dashboard');
    Route::get('/user/list', [UserController::class, 'list']);
    Route::post('/user/list', [UserController::class, 'insert']);
    Route::get('/user/delete/{id}', [UserController::class, 'delete']);
    Route::get('/document/list', [DocumentController::class, 'list']);
    Route::post('/document/list', [DocumentController::class, 'import'])->name('import.document');
    Route::get('/document/delete/{id}', [DocumentController::class, 'delete']);
    Route::get('/disease/list', [DiseaseController::class, 'list']);
    Route::post('/disease/list', [DiseaseController::class, 'insert']);
    Route::get('/disease/delete/{id}', [DiseaseController::class, 'delete']);
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get('/history/list', [PredictionController::class, 'list']);
});

require __DIR__.'/auth.php';
