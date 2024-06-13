<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    public function list()
    {
        $data['getRecord'] = User::getUser();
        $data['totalUser'] = User::getTotalUser();

        return view('user/list', $data);
    }

    public function insert(Request $request)
    {

        if($request->input('form_type') === 'add')
        {
            request()->validate([
                'email' => 'required|email|unique:users',
            ]);
            $user = new User;
            $user->first_name = trim($request->first_name);
            $user->last_name = trim($request->last_name);
            $user->email = trim($request->email);
            $user->age = trim($request->age);
            $user->phone_number = trim($request->phone_number);
            $user->gender = trim($request->gender);
            $user->user_role = 2;
            $user->save();

            return redirect('user/list');
        }
        elseif ($request->input('form_type') === 'edit') {

            $user = User::find($request->input('id'));
            $user->first_name = trim($request->first_name);
            $user->last_name = trim($request->last_name);
            $user->email = trim($request->email);
            $user->age = trim($request->age);
            $user->gender = trim($request->gender);
            $user->phone_number = trim($request->phone_number);

            $user->save();

            return redirect('user/list');
        }
        elseif (($request->input('form_type') === 'delete')) {
            $user = User::getSingleUser($id);
            $user->delete();

            return redirect('user/list');
        }
    }

    public function delete($id)
    {
        $user = User::getSingleUser($id);
        $user->delete();

        return redirect('user/list');
    }
}
