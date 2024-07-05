<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Disease;

class DiseaseController extends Controller
{
    public function list()
    {
        $data['getRecord'] = Disease::getDisease();
        $data['tatalDisease'] = Disease::getTotalDisease();

        return view('disease/list', $data);
    }

    public function insert(Request $request)
    {

        if($request->input('form_type') === 'add')
        {
            $disease = new Disease;
            $disease->title = trim($request->title);
            $disease->description = trim($request->description);
            $disease->save();

            return redirect('disease/list')->with('success', 'Disease has been saved.');
        }
        elseif ($request->input('form_type') === 'edit') {

            $disease = Disease::find($request->input('id'));
            $disease->title = trim($request->title);
            $disease->description = trim($request->description);

            $disease->save();
            return redirect('disease/list')->with('success', 'Disease has been edited.');
        }
    }

    public function delete($id)
    {
        $disease = Disease::getSingleDisease($id);
        $disease->delete();

        return redirect('disease/list')->with('success', 'Disease has been deleted.');
    }
}
