{{-- <x-guest-layout>
    <!-- Session Status -->
    <x-auth-session-status class="mb-4" :status="session('status')" />

    <form method="POST" action="{{ route('login') }}">
        @csrf

        <!-- Email Address -->
        <div>
            <x-input-label for="email" :value="__('Email')" />
            <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required autofocus autocomplete="username" />
            <x-input-error :messages="$errors->get('email')" class="mt-2" />
        </div>

        <!-- Password -->
        <div class="mt-4">
            <x-input-label for="password" :value="__('Password')" />

            <x-text-input id="password" class="block mt-1 w-full"
                            type="password"
                            name="password"
                            required autocomplete="current-password" />

            <x-input-error :messages="$errors->get('password')" class="mt-2" />
        </div>

        <!-- Remember Me -->
        <div class="block mt-4">
            <label for="remember_me" class="inline-flex items-center">
                <input id="remember_me" type="checkbox" class="rounded border-gray-300 text-indigo-600 shadow-sm focus:ring-indigo-500" name="remember">
                <span class="ms-2 text-sm text-gray-600">{{ __('Remember me') }}</span>
            </label>
        </div>

        <div class="flex items-center justify-end mt-4">
            @if (Route::has('password.request'))
                <a class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" href="{{ route('password.request') }}">
                    {{ __('Forgot your password?') }}
                </a>
            @endif

            <x-primary-button class="ms-3">
                {{ __('Log in') }}
            </x-primary-button>
        </div>
    </form>
</x-guest-layout> --}}

<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Get started with a free and open source Tailwind CSS dashboard featuring a sidebar layout, advanced charts, and hundreds of components based on Flowbite">
        <meta name="author" content="Themesberg">
        <meta name="generator" content="Hugo 0.126.3">

        <title>Login Page</title>

        <link rel="canonical" href="https://themesberg.com/product/tailwind-css/dashboard-windster">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
        @vite('resources/css/app.css')
        <meta name="msapplication-TileColor" content="#ffffff">
        <meta name="theme-color" content="#ffffff">

    </head>
    <body class="bg-gray-50">
        <main class="bg-gray-50">
            <div class="mx-auto md:h-screen flex flex-col justify-center items-center px-6 pt-8 pt:mt-0">
                <!-- Card -->
                <div class="bg-white shadow rounded-lg md:mt-0 w-full sm:max-w-screen-sm xl:p-0">
                    <div class="p-6 sm:p-8 lg:p-16">
                        <div class="flex justify-center">
                            <img src="{{asset('assets/eyeslogo-removebg-preview.png')}}" class="h-20" alt="Windster Logo">
                        </div>
                        <div class="flex justify-center">
                            <h2 class="text-2xl lg:text-3xl font-bold text-gray-900">
                                Sign in
                            </h2>
                        </div>
                        <form class="mt-8 space-y-6" method="POST" action="{{ route('login') }}">
                            @csrf
                            <div>
                                <label for="email" class="text-sm font-medium text-gray-900 block mb-2">Your email</label>
                                <input type="email" name="email" id="email" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5" value=" {{old('email')}}" placeholder="" required autofocus autocomplete="username">
                                <x-input-error :messages="$errors->get('email')" class="mt-2" />
                            </div>
                            <div>
                                <label for="password" class="text-sm font-medium text-gray-900 block mb-2">Your password</label>
                                <input type="password" name="password" id="password" autocomplete="current-password" placeholder="" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5" required>
                                <x-input-error :messages="$errors->get('password')" class="mt-2" />
                            </div>
                            <div class="flex items-start">
                                <div class="flex items-center h-5">
                                <input id="remember_me" aria-describedby="remember" name="remember_me" type="checkbox" class="bg-gray-50 border-gray-300 focus:ring-3 focus:ring-cyan-200 h-4 w-4 rounded">

                                </div>
                                <div class="text-sm ml-3">
                                <label for="remember_me" class="font-medium text-gray-900">Remember me</label>
                                </div>
                                <a href="{{ route('password.request') }}" class="text-sm text-teal-500 hover:underline ml-auto">Lost Password?</a>
                            </div>
                            <button type="submit" class="text-white bg-cyan-600 hover:bg-cyan-700 focus:ring-4 focus:ring-cyan-200 font-medium rounded-lg text-base px-5 py-3 w-full sm:w-auto text-center">Login to your account</button>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
