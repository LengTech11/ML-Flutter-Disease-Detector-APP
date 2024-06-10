<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<<<<<<< HEAD
    @vite('resources/css/app.css')
    @vite('resources/js/app.js')
=======
    <link rel="stylesheet" href="{{ mix('resources/css/app.css') }}">
    <link rel="stylesheet" href="{{ mix('resources/js/charts.js') }}">
    <link rel="stylesheet" href="{{ mix('resources/js/app.js')}}">

>>>>>>> 9ba4be2ef00d78ffe045e9395ffb5c965395adda

</head>

<body class="font-sans antialiased bg-gray-100">

    @include('layouts.navigation')
    <div class="flex overflow-hidden bg-white pt-16">

        @include('layouts.sidebar')

        <div class="bg-gray-900 opacity-50 hidden fixed inset-0 z-10" id="sidebarBackdrop"></div>
        <div id="main-content" class="h-full w-full bg-gray-100 relative overflow-y-auto lg:ml-64">

            @yield('content')

            @include('layouts.footer')
            <p class="text-center text-sm text-gray-500 my-5">
                &copy; 2024
                <a href="https://themesberg.com" class="hover:underline" target="_blank">VisionCareAI</a>. All rights reserved.
            </p>
        </div>
    </div>

</body>

</html>

