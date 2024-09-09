<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\AppointmentRequest;

class AppointmentRequestController extends Controller
{
    /**
     * Display a listing of appointment requests.
     */
    public function index()
    {
        $appointmentRequests = AppointmentRequest::all();
        return response()->json([
            'status' => 'success',
            'data' => $appointmentRequests,
        ], 200);
    }

    /**
     * Store a newly created appointment request in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'doctor_id' => 'required|exists:doctors,id',
            'preferred_date' => 'required|date',
            'phone_number' => 'nullable|string',
        ]);

        $appointmentRequest = new AppointmentRequest();
        $appointmentRequest->user_id = auth()->id();
        $appointmentRequest->doctor_id = $request->doctor_id;
        $appointmentRequest->preferred_date = $request->preferred_date;
        $appointmentRequest->phone_number = $request->phone_number;
        $appointmentRequest->request_status = 'Pending';
        $appointmentRequest->save();

        return response()->json($appointmentRequest, 201);
    }

    /**
     * Display the specified appointment request.
     */
    public function show($id)
    {
        $appointmentRequest = AppointmentRequest::findOrFail($id);
        return response()->json($appointmentRequest);
    }

    /**
     * Update the specified appointment request in storage.
     */
    public function update(Request $request, $id)
    {
        $appointmentRequest = AppointmentRequest::findOrFail($id);

        $request->validate([
            'request_status' => 'required|in:Pending,Approved,Rejected',
        ]);

        $appointmentRequest->request_status = $request->request_status;
        $appointmentRequest->save();

        return response()->json($appointmentRequest);
    }

    /**
     * Remove the specified appointment request from storage.
     */
    public function destroy($id)
    {
        $appointmentRequest = AppointmentRequest::findOrFail($id);
        $appointmentRequest->delete();

        return response()->json(null, 204);
    }

}
