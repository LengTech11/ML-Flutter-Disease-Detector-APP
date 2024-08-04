<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Prediction;
use Illuminate\Support\Facades\Storage;

class PredictionController extends Controller
{
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

    public function destroy($id)
    {
        //Find the prediction by ID
        $prediction = Prediction::find($id);

        //Check if the prediction exists and belongs to the authenticated user
        if ($prediction && $prediction->user_id == Auth::id()) {
            //Delete the prediction
            $prediction->delete();

            return response()->json(['message' => 'Prediction deleted successfully']);
        }

        return response()->json(['message' => 'Prediction not found'], 404);
    }

    public function destroyAll()
    {
        // Delete all predictions for the authenticated user
        $deletedCount = Prediction::where('user_id', Auth::id())->delete();

        return response()->json(['message' => "Deleted $deletedCount predictions"]);
    }

}
