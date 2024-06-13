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
        $data['totalDocument'] = Document::getTotalDocument();

        return view('document/list', $data);
    }

    public function import(Request $request)
    {
        if($request->input('form_type') === 'import')
        {
            $doc = new Document;
            if($request->hasFile('title')) {
                $file = $request->file('title');
                $filename = $file->getClientOriginalName();
                $file->move(public_path('storage/document'), $filename);
                $doc->title = $filename;
            }
            $doc->save();
            return redirect('document/list');
        }
        elseif($request->input('form_type') === 'rename')
        {
            $doc = Document::find($request->input('id'));
            if($request->exists('title')) {
                $newName = trim($request->title);
                $oldName = $doc->getOriginal('title');
                rename('storage/document/'.$oldName, 'storage/document/'.$newName);
                $doc->title = $newName;
                $doc->description = trim($request->description);
            }
            $doc->save();
            return redirect('document/list');
        }
    }

    public function delete($id)
    {

        $doc = Document::getSingleDocument($id);
        if($doc->exists('title')) {
            $name = $doc->getOriginal('title');
            File::delete('storage/document/'.$name);
        }
        $doc->delete();
        return redirect('document/list');
    }


    public function formatFileSize($bytes, $decimals = 1)
    {
        $size = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
        $factor = floor((strlen($bytes) - 1) / 3);
        return sprintf("%.{$decimals}f", $bytes / pow(1024, $factor)) . ' ' . @$size[$factor];
    }
}
