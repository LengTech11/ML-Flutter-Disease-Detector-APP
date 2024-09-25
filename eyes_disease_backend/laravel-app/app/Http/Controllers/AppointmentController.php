<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use App\Models\User;
use App\Models\Appointment;
use App\Models\AppointmentRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class AppointmentController extends Controller
{
    public function list(Request $request)
    {

        $search = $request->input('search');
        $query = AppointmentRequest::select('appointment_requests.*',
                                    'doctors.first_name as doctor_first_name',
                                    'doctors.last_name as doctor_last_name',
                                    'users.first_name as user_first_name',
                                    'users.last_name as user_last_name')
                        ->join('doctors', 'appointment_requests.doctor_id', '=', 'doctors.id')
                        ->join('users', 'appointment_requests.user_id', '=', 'users.id')
                        // ->where('appointment_requests.user_id', Auth::id())
                        ->orderBy('appointment_requests.preferred_date', 'desc');

        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('users.first_name', 'like', '%'.$search.'%')
                    ->orWhere('users.last_name', 'like', '%'.$search.'%')
                    ->orWhere('doctors.first_name', 'like', '%'.$search.'%')
                    ->orWhere('doctors.last_name', 'like', '%'.$search.'%');
            });
        }

        $perPage = $request->input('per_page', 10);
        $data['getRecord'] = $query->orderBy('id', 'desc')->paginate($perPage);

        return view('appointment/list', $data);
    }

    public function acceptAppointment(Request $request)
    {

        $appointment = AppointmentRequest::find($request->input('id'));

        if ($request->input('action') === 'accept') {
            $appointment->request_status = 'Approved';
            $message = 'Appointment has been approved.';
        } elseif ($request->input('action') === 'reject') {
            $appointment->request_status = 'Rejected';
            $message = 'Appointment has been rejected.';
        }

        $appointment->save();

        return redirect('appointment/list')->with('success', $message);
    }
}
