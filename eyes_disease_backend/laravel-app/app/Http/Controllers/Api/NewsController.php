<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\News;
use Illuminate\Support\Facades\Storage;

class NewsController extends Controller
{

    public function index()
    {
        $news = News::all();
        foreach ($news as $newsItem) {
            if ($newsItem->image) {
                $newsItem->image = Storage::url($newsItem->image);
            }
        }
        return response()->json($news);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string',
            'description' => 'required|string',
            'author' => 'required|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $news = new News();
        $news->title = $request->title;
        $news->description = $request->description;
        $news->author = $request->author;

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $imagePath = $image->storeAs('images', $imageName, 'public');
            $news->image = $imagePath;
        }

        $news->save();

        return response()->json($news, 201);
    }

    public function show($id)
    {
        $news = News::findOrFail($id);
        if ($news->image) {
            $news->image = Storage::url($news->image);
        }
        return response()->json($news);
    }

    public function update(Request $request, $id)
    {
        $news = News::findOrFail($id);
        $news->update($request->all());
        return response()->json($news);
    }

    public function destroy($id)
    {
        News::destroy($id);
        return response()->json(null, 204);
    }
}
