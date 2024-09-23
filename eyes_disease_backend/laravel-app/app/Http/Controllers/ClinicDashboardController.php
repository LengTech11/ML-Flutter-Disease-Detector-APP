<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use App\Models\AppointmentRequest;

class ClinicDashboardController extends Controller
{
    public function dashboard()
    {

        $data['totalDoctor'] = Doctor::where('user_id', Auth::id())->count();
        $data['totalAdmittedPatient'] = AppointmentRequest::where('request_status', '=', 'Approved')->where('user_id', Auth::id())->count();
        $data['totalReadmittedPatient'] = AppointmentRequest::where('request_status', '=', 'Rejected')->where('user_id', Auth::id())->count();

        $data['getRecord'] = AppointmentRequest::select('appointment_requests.*',
                                    'doctors.first_name as doctor_first_name',
                                    'doctors.last_name as doctor_last_name',
                                    'doctors.specialist as specialist',
                                    'users.first_name as user_first_name',
                                    'users.last_name as user_last_name')
                            ->join('doctors', 'appointment_requests.doctor_id', '=', 'doctors.id')
                            ->join('users', 'appointment_requests.user_id', '=', 'users.id')
                            ->where('appointment_requests.user_id', Auth::id())
                            ->orderBy('appointment_requests.preferred_date', 'desc')
                            ->get();

                            // dd(Auth::id());

        return view('clinic/dashboard', $data);
    }
}
