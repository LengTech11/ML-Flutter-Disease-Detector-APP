<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use App\Models\User;
use App\Models\Appointment;
use Illuminate\Http\Request;

class AppointmentController extends Controller
{
    public function list(Request $request)
    {

        $search = $request->input('search');
        $query = Appointment::select('appointments.*', 'user_booking_appointments.status as booking_status','doctors.first_name as doctor_first_name', 'doctors.last_name as doctor_last_name', 'users.first_name as user_first_name', 'users.last_name as user_last_name')
                        ->join('doctors', 'doctor_id', '=', 'doctors.id')
                        ->join('user_booking_appointments', 'user_booking_appointments.appointment_id', '=', 'appointments.id')
                        ->join('users', 'user_booking_appointments.user_id', '=', 'users.id')
                        ->orderBy('id', 'desc');


        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('first_name', 'like', '%'.$search.'%')
                    ->orWhere('last_name', 'like', '%'.$search.'%');
            });
        }

        $perPage = $request->input('per_page', 10);
        $data['getRecord'] = $query->orderBy('id', 'desc')->paginate($perPage);


        return view('appointment/list', $data);
    }
}


