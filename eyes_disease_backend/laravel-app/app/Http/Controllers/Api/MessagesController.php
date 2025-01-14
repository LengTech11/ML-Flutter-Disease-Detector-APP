<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Messages;

class MessagesController extends Controller
{
    public function index()
    {
        return Messages::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email',
            'phone_number' => 'required|string',
            'subject' => 'required|string',
            'message' => 'required|string',
        ]);

        $message = Messages::create($request->all());

        return response()->json($message, 201);
    }

    public function show(Messages $message)
    {
        return $message;
    }

    public function update(Request $request, Messages $message)
    {
        $message->update($request->all());

        return response()->json($message);
    }

    public function destroy(Messages $message)
    {
        $message->delete();

        return response()->json(null, 204);
    }
}
