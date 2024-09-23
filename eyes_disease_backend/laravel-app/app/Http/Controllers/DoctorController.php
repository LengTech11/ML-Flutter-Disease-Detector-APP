<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;


class DoctorController extends Controller
{
    public function list(Request $request)
    {

        $search = $request->input('search');
        $query = Doctor::select('doctors.*')
                        ->where('user_id', Auth::id())
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
        $validatedStatus = $request->validate([
            'status' => 'required|boolean',
            'profile_pic' => 'image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        if($request->input('form_type') === 'add')
        {
            $doctor = new Doctor;
        }
        elseif ($request->input('form_type') === 'edit') {
            $doctor = Doctor::find($request->input('id'));

            // Delete the old profile image
            if ($doctor->profile_pic) {
                Storage::delete('public/' . $doctor->profile_pic);
            }
        }

        // Handle the profile image upload
        if ($request->hasFile('profile_pic')) {
            $file = $request->file('profile_pic');
            $filename = time() . '.' . $file->getClientOriginalExtension();

            // Store the image in the 'public' disk under the 'profiles' directory
            $imagePath = $file->storeAs('profiles', $filename, 'public');

            $doctor->profile_pic = $imagePath;
        } else if ($request->input('profile_pic') === null) {
            // If the profile_pic is set as null, delete the old profile image
            $doctor->profile_pic = null;
        }

        $doctor->title = trim($request->title);
        $doctor->first_name = trim($request->first_name);
        $doctor->last_name = trim($request->last_name);
        $doctor->user_id = auth()->user()->id;
        $doctor->specialist = trim($request->specialist);
        $doctor->description = trim($request->description);
        $doctor->phone_number = trim($request->phone_number);
        $doctor->telegram = trim($request->telegram);
        $doctor->experience = trim($request->experience);
        $doctor->status = $validatedStatus['status'];
        $doctor->save();

        $message = $request->input('form_type') === 'add' ? 'Account has been saved.' : 'Account has been edited.';

        return redirect('doctor/list')->with('success', $message);
    }

    public function delete($id)
    {
        $user = Doctor::getSingleDoctor($id);
        $user->delete();

        return redirect('user/list')->with('success', 'Account has been deleted.');
    }
}
