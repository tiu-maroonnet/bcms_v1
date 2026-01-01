<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\ProvisioningController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\ReminderController;
use App\Http\Controllers\TicketController;
use App\Http\Controllers\AuditController;

Route::post('/auth/login', [AuthController::class, 'login']);
Route::post('/auth/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/me', [AuthController::class, 'me']);

    Route::get('/company', [CompanyController::class, 'show']);
    Route::put('/company', [CompanyController::class, 'update']);

    Route::apiResource('users', \App\Http\Controllers\UserController::class);
    Route::apiResource('customers', CustomerController::class);
    Route::apiResource('services', ServiceController::class);
    Route::apiResource('provisioning', ProvisioningController::class)->only(['index','store','update','destroy']);
    Route::apiResource('invoices', InvoiceController::class);
    Route::apiResource('payments', PaymentController::class)->only(['index','store','show']);
    Route::apiResource('reminders', ReminderController::class)->only(['index','store','update','destroy']);
    Route::apiResource('tickets', TicketController::class);
    Route::get('/audit', [AuditController::class, 'index']);

    Route::post('/provisioning/test-connection', [ProvisioningController::class, 'testConnection']);
    Route::post('/billing/run-cycle', [InvoiceController::class, 'runCycle']);
    Route::post('/billing/soft-limit', [InvoiceController::class, 'applySoftLimit']);
    Route::post('/billing/suspend', [InvoiceController::class, 'applySuspend']);
    Route::post('/billing/reactivate', [InvoiceController::class, 'reactivate']);
});