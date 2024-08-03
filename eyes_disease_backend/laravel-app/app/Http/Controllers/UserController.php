<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function list(Request $request)
    {

        // $data['getRecord'] = User::select('users.*')
        //                             ->where('user_role', 0)
        //                             ->orderBy('id', 'desc')
        //                             ->paginate(5);
        $search = $request->input('search');
        $query = User::select('users.*')
                        ->orderBy('count', 'desc')
                        ->where('user_role', 0);

        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('first_name', 'like', '%'.$search.'%')
                    ->orWhere('last_name', 'like', '%'.$search.'%')
                    ->orWhere('email', 'like', '%'.$search.'%');
            });
        }
        $data['getRecord'] = $query->orderBy('id', 'desc')->paginate(5);

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
            $user->password = Hash::make('00000000');
            $user->user_role = 0;
            $user->save();

            return redirect('user/list')->with('success', 'Account has been saved.');
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

            return redirect('user/list')->with('success', 'Account has been edited.');
        }
    }

    public function delete($id)
    {
        $user = User::getSingleUser($id);
        $user->delete();

        return redirect('user/list')->with('success', 'Account has been deleted.');
    }
}
