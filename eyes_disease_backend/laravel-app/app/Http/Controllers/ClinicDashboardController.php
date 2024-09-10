<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use App\Models\AppointmentRequest;

class ClinicDashboardController extends Controller
{
    public function dashboard()
    {

        $data['totalDoctor'] = Doctor::getTotalDoctor();
        $data['totalAdmittedPatient'] = AppointmentRequest::where('request_status', '=', 'Approved')->count();
        $data['totalReadmittedPatient'] = AppointmentRequest::where('request_status', '=', 'Rejected')->count();

        return view('clinic/dashboard', $data);
    }
}
