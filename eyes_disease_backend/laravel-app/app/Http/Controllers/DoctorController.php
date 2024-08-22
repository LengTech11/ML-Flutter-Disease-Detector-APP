<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use App\Models\User;
use Illuminate\Support\Facades\Auth;


class DoctorController extends Controller
{
    public function list(Request $request)
    {

        $search = $request->input('search');
        $query = Doctor::select('doctors.*')
                        ->orderBy('id', 'desc');

        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('first_name', 'like', '%'.$search.'%')
                    ->orWhere('last_name', 'like', '%'.$search.'%');
            });
        }

        $perPage = $request->input('per_page', 10);
        $data['getRecord'] = $query->orderBy('id', 'desc')->paginate($perPage);


        return view('doctor/list', $data);
    }

    public function insert(Request $request)
    {

        if($request->input('form_type') === 'add')
        {

            $validatedStatus = $request->validate([
                'status' => 'required|boolean',
            ]);

            $doctor = new Doctor;
            $doctor->title = trim($request->title);
            $doctor->first_name = trim($request->first_name);
            $doctor->last_name = trim($request->last_name);
            $doctor->user_id = auth()->user()->id;
            $doctor->specialist = trim($request->specialist);
            $doctor->description = trim($request->description);
            $doctor->phone_number = trim($request->phone_number);
            $doctor->telegram = trim($request->telegram);
            $doctor->experience = trim($request->experience);
            $doctor->profile_pic = trim($request->profile_pic);
            $doctor->status = $validatedStatus['status'];

            $doctor->save();

            return redirect('doctor/list')->with('success', 'Account has been saved.');
        }
        elseif ($request->input('form_type') === 'edit') {

            $validatedStatus = $request->validate([
                'status' => 'required|boolean',
            ]);

            $doctor = Doctor::find($request->input('id'));
            $doctor->title = trim($request->title);
            $doctor->first_name = trim($request->first_name);
            $doctor->last_name = trim($request->last_name);
            $doctor->specialist = trim($request->specialist);
            $doctor->description = trim($request->description);
            $doctor->phone_number = trim($request->phone_number);
            $doctor->telegram = trim($request->telegram);
            $doctor->experience = trim($request->experience);
            $doctor->profile_pic = trim($request->profile_pic);
            $doctor->status = $validatedStatus['status'];
            $doctor->save();

            return redirect('doctor/list')->with('success', 'Account has been edited.');
        }
    }

    public function delete($id)
    {
        $user = Doctor::getSingleDoctor($id);
        $user->delete();

        return redirect('user/list')->with('success', 'Account has been deleted.');
    }
}
