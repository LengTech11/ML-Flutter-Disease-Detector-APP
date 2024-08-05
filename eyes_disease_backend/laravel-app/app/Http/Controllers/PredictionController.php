<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Prediction;
use Illuminate\Support\Facades\Storage;
use App\Models\User;

class PredictionController extends Controller
{

    public function list(Request $request)
    {

        $search = $request->input('search');
        $query = Prediction::select('predictions.*', 'users.first_name', 'users.last_name', 'users.email')
                    ->join('users', 'predictions.user_id', '=', 'users.id')
                    ->orderBy('predictions.id', 'desc');

        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('first_name', 'like', '%'.$search.'%')
                    ->orWhere('last_name', 'like', '%'.$search.'%')
                    ->orWhere('email', 'like', '%'.$search.'%');
            });
        }

        $data['getRecord'] = $query->orderBy('id', 'desc')->paginate(10);

        return view('history/list', $data);
    }

    public function store(Request $request)
    {
        $request->validate([
            'predicted_class' => 'required|string',
            'confidence' => 'required|numeric',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $prediction = new Prediction();
        $prediction->user_id = Auth::id();
        $prediction->predicted_class = $request->predicted_class;
        $prediction->confidence = $request->confidence;

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('images', $imageName, 'public');
            $prediction->image_url = $imagePath;
        }


        $prediction->save();

        return response()->json(['message' => 'Prediction saved successfully']);
    }

    public function index()
    {
        // Get all predictions for the authenticated user
        $predictions = Prediction::where('user_id', Auth::id())->get();

        // Optionally, you can include the full URL of the images
        foreach ($predictions as $prediction) {
            if ($prediction->image_url) {
                $prediction->image_url = Storage::url($prediction->image_url);
            }
        }

        return response()->json($predictions);
    }

    // Delete a specific prediction by ID
    public function destroy($id)
    {
        $prediction = Prediction::find($id);

        if ($prediction && $prediction->user_id == Auth::id()) {
            $prediction->delete();

            return response()->json(['message' => 'Prediction deleted successfully']);
        }

        return response()->json(['message' => 'Prediction not found'], 404);
    }

    // Delete all predictions for the authenticated user
    public function destroyAll()
    {
        $deletedCount = Prediction::where('user_id', Auth::id())->delete();

        return response()->json(['message' => "Deleted $deletedCount predictions"]);
    }

}
