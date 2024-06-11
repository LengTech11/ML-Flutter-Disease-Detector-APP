<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Document;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;

class DocumentController extends Controller
{
    public function list()
    {
        $data['getRecord'] = Document::getDocument();

        return view('document/list', $data);
    }

    public function import(Request $request)
    {
        $doc = new Document;
            if($request->hasFile('name')) {
                $file = $request->file('name');
                $filename = $file->getClientOriginalName();
                // $file->move('upload/document', $filename);
                Storage::putFileAs('upload/document', $file, $filename);
                dd($filename);
                $doc->title = $filename;
            }
            $doc->save();
        return redirect('document/list');
    }


    public function formatFileSize($bytes, $decimals = 1)
    {
        $size = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
        $factor = floor((strlen($bytes) - 1) / 3);
        return sprintf("%.{$decimals}f", $bytes / pow(1024, $factor)) . ' ' . @$size[$factor];
    }
}
