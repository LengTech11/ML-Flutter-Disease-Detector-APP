<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DocumentController;

Route::get('/', function () {
    return view('auth/login');
});

// Route::get('/dashboard', function () {
//     return view('dashboard');
// })->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'dashboard'])->name('dashboard');
    Route::get('/user/list', [UserController::class, 'list']);
    Route::post('/user/list', [UserController::class, 'insert']);
    Route::get('/user/list/{$id}', [UserController::class, 'delete']);
    Route::get('/document/list', [DocumentController::class, 'list']);
    Route::post('/document/list', [DocumentController::class, 'import']);
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
