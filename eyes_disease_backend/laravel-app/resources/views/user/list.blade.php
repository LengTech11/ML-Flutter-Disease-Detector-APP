@extends('layouts/app')

@section('content')
    <main>
        <div class="p-4 bg-white block sm:flex items-center justify-between border-b border-gray-200 lg:mt-1.5">
            <div class="mb-1 w-full">
                {{-- <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                    <strong class="font-bold">Success!</strong>
                    <span class="block sm:inline">Your message has been sent successfully.</span>
                    <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                      <svg class="fill-current h-6 w-6 text-green-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                        <title>Close</title>
                        <path fill-rule="evenodd" d="M2.293 3.293a1 1 0 011.414 0L10 10.586l6.293-6.293a1 1 0 111.414 1.414L11.414 12l6.293 6.293a1 1 0 01-1.414 1.414L10 13.414l-6.293 6.293a1 1 0 01-1.414-1.414L8.586 12 2.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
                      </svg>
                    </span>
                </div> --}}
                <!--add user modal-->
                <div class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none"
                    id="addUserModal" data-twe-modal-init tabindex="-1" aria-modal="true">
                    <div data-twe-modal-dialog-ref
                        class="pointer-events-none relative flex min-h-[calc(100%-1rem)] w-auto translate-y-[-50px] items-center opacity-0 transition-all duration-300 ease-in-out min-[576px]:mx-auto min-[576px]:mt-7 min-[576px]:min-h-[calc(100%-3.5rem)] min-[576px]:max-w-[600px]">
                        <div
                            class="pointer-events-auto relative flex w-full flex-col rounded-md border-none bg-white bg-clip-padding text-current shadow-4 outline-none dark:bg-surface-dark">
                            <div
                                class="flex flex-shrink-0 items-center justify-between rounded-t-md border-b-2 border-neutral-100 p-4 dark:border-white/10">
                                <!-- Modal title -->
                                <h5 class="text-xl font-medium leading-normal text-surface dark:text-white"
                                    id="addUserModalTitle">
                                    Add User
                                </h5>
                                <!-- Close button -->
                                <button type="button"
                                    class="box-content rounded-none border-none text-neutral-500 hover:text-neutral-800 hover:no-underline focus:text-neutral-800 focus:opacity-100 focus:shadow-none focus:outline-none dark:text-neutral-400 dark:hover:text-neutral-300 dark:focus:text-neutral-300"
                                    data-twe-modal-dismiss aria-label="Close">
                                    <span class="[&>svg]:h-6 [&>svg]:w-6">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24"
                                            stroke-width="1.5" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                                        </svg>
                                    </span>
                                </button>
                            </div>

                            <form action="" method="POST">
                                @csrf
                                <!-- Modal body -->
                                <div class="p-6 space-y-6">
                                    <div class="grid grid-cols-6 gap-6">
                                        <div class="col-span-6 sm:col-span-3">
                                            <label class="text-sm font-medium text-gray-900 block mb-2">First
                                                Name</label>
                                            <input type="text" name="first_name" id="first_name"
                                                value="{{ old('fitst_name') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="Bonnie" required>
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label class="text-sm font-medium text-gray-900 block mb-2">Last
                                                Name</label>
                                            <input type="text" name="last_name" id="last_name"
                                                value="{{ old('last') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="Green" required>
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label for="email"
                                                class="text-sm font-medium text-gray-900 block mb-2">Email</label>
                                            <input type="email" name="email" id="email" value="{{ old('email') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="example@company.com" required>
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label for="phone-number"
                                                class="text-sm font-medium text-gray-900 block mb-2">Phone
                                                Number</label>
                                            <input type="number" name="phone_number" id="phone_number"
                                                value="{{ old('phone_number') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="e.g. +(12)3456 789" required>
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label class="text-sm font-medium text-gray-900 block mb-2">
                                                Age</label>
                                            <input type="number" name="age" id="age" value="{{ old('age') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="21" required>
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label class="text-sm font-medium text-gray-900 block mb-2">
                                                Gender</label>
                                            <select name="gender" id="gender"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                required>
                                                <option value="" disabled selected>Select your gender</option>
                                                <option value="1">Male</option>
                                                <option value="2">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal footer -->
                                <div
                                    class="flex flex-shrink-0 flex-wrap items-center justify-end rounded-b-md border-t-2 border-neutral-100 p-4 dark:border-white/10">
                                    <button type="button"
                                        class="inline-block rounded bg-cyan-600 px-6 mx-2 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-white transition duration-150 ease-in-out hover:bg-cyan-700 focus:bg-primary-accent-200 focus:outline-none focus:ring-0 active:bg-primary-accent-200 dark:bg-primary-300 dark:hover:bg-primary-400 dark:focus:bg-primary-400 dark:active:bg-primary-400"
                                        data-twe-modal-dismiss data-twe-ripple-init data-twe-ripple-color="light">
                                        Close
                                    </button>
                                    <button type="submit" name="form_type" value="add"
                                        class="ms-1 inline-block rounded bg-cyan-600 hover:bg-cyan-700 px-6 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-white shadow-primary-3 transition duration-150 ease-in-out hover:shadow-primary-2 focus:bg-cyan-700 focus:shadow-primary-2 focus:outline-none focus:ring-0 active:bg-cyan-700 active:shadow-primary-2 dark:shadow-black/30 dark:hover:shadow-dark-strong dark:focus:shadow-dark-strong dark:active:shadow-dark-strong">
                                        Create
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <nav class="flex mb-5" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href=" {{url('dashboard')}} " class="text-gray-700 hover:text-gray-900 inline-flex items-center">
                                    <svg class="w-5 h-5 mr-2.5" fill="currentColor" viewBox="0 0 20 20"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z">
                                        </path>
                                    </svg>
                                    Home
                                </a>
                            </li>

                            <li>
                                <div class="flex items-center">
                                    <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd"
                                            d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                            clip-rule="evenodd"></path>
                                    </svg>
                                    <a href="#"
                                        class="text-gray-700 hover:text-gray-900 ml-1 md:ml-2 text-sm font-medium">Users</a>
                                </div>
                            </li>
                        </ol>
                    </nav>
                    <h1 class="text-xl sm:text-2xl font-semibold text-gray-900">All Users</h1>
                </div>
                <div class="sm:flex">
                    <div class="hidden sm:flex items-center sm:divide-x sm:divide-gray-100 mb-3 sm:mb-0">
                        <form class="lg:pr-3" action="" >
                            <label for="users-search" class="sr-only">Search</label>
                            <div class="mt-1 relative lg:w-64 xl:w-96">
                                <input type="text" name="search" id="users-search"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                    placeholder="Search for users" value="{{ request()->input('search') }}">
                            </div>
                        </form>
                        <div class="flex space-x-1 pl-0 sm:pl-2 mt-3 sm:mt-0 ">
                            {{-- <a href="#"
                                class="text-gray-500 hover:text-gray-900 cursor-pointer p-1 hover:bg-gray-100 rounded inline-flex justify-center">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
                                        clip-rule="evenodd"></path>
                                </svg>
                            </a> --}}
                            {{-- <a href="#"
                                class="text-gray-500 hover:text-gray-900 cursor-pointer p-1 hover:bg-gray-100 rounded inline-flex justify-center">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                        clip-rule="evenodd"></path>
                                </svg>
                            </a> --}}
                            {{-- <a href="#"
                                class="text-gray-500 hover:text-gray-900 cursor-pointer p-1 hover:bg-gray-100 rounded inline-flex justify-center">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                                        clip-rule="evenodd"></path>
                                </svg>
                            </a> --}}
                            <a href="#"
                                class="text-gray-500 hover:text-gray-900 cursor-pointer p-1 hover:bg-gray-100 rounded inline-flex justify-center">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M10 6a2 2 0 110-4 2 2 0 010 4zM10 12a2 2 0 110-4 2 2 0 010 4zM10 18a2 2 0 110-4 2 2 0 010 4z">
                                    </path>
                                </svg>
                            </a>
                        </div>
                    </div>
                    <div class="flex items-center space-x-2 sm:space-x-3 ml-auto">
                        <button type="button" data-twe-toggle="modal" data-twe-target="#addUserModal"
                            class="w-1/2 text-white bg-cyan-600 hover:bg-cyan-700 focus:ring-4 focus:ring-cyan-200 font-medium inline-flex items-center justify-center rounded-lg text-sm px-3 py-2 text-center sm:w-auto">
                            <svg class="-ml-1 mr-2 h-6 w-6" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Add user
                        </button>
                        {{-- <a href="#"
                            class="w-1/2 text-gray-900 bg-white border border-gray-300 hover:bg-gray-100 focus:ring-4 focus:ring-cyan-200 font-medium inline-flex items-center justify-center rounded-lg text-sm px-3 py-2 text-center sm:w-auto">
                            <svg class="-ml-1 mr-2 h-6 w-6" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V7.414A2 2 0 0015.414 6L12 2.586A2 2 0 0010.586 2H6zm5 6a1 1 0 10-2 0v3.586l-1.293-1.293a1 1 0 10-1.414 1.414l3 3a1 1 0 001.414 0l3-3a1 1 0 00-1.414-1.414L11 11.586V8z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Export
                        </a> --}}
                    </div>
                </div>
            </div>
        </div>

        {{-- <div class="px-2 mt-16">
            <!-- Alert Success -->
            <div class="bg-green-200 px-6 py-3 my-4 rounded-md text-lg flex items-center mx-auto max-w-lg">
                <svg viewBox="0 0 24 24" class="text-green-600 w-4 h-4 sm:w-4 sm:h-4 mr-3">
                    <path fill="currentColor"
                        d="M12,0A12,12,0,1,0,24,12,12.014,12.014,0,0,0,12,0Zm6.927,8.2-6.845,9.289a1.011,1.011,0,0,1-1.43.188L5.764,13.769a1,1,0,1,1,1.25-1.562l4.076,3.261,6.227-8.451A1,1,0,1,1,18.927,8.2Z">
                    </path>
                </svg>
                <span class="text-green-800">Your account has been saved.</span>
            </div>
        </div> --}}

        @include('message')


        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="align-middle inline-block min-w-full">
                    <div class="shadow overflow-hidden">
                        <table class="table-fixed min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-100">
                                <tr>
                                    <th scope="col" class="p-4">
                                        <div class="flex items-center">
                                            <input id="checkbox-all" aria-describedby="checkbox-1" type="checkbox" onClick="toggle(this)"
                                                class="bg-gray-50 border-gray-300 focus:ring-3 focus:ring-cyan-200 h-4 w-4 rounded">
                                            <label for="checkbox-all" class="sr-only">checkbox</label>
                                        </div>
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Name
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Gender
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Scans
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">

                                @foreach ($getRecord as $value)
                                    <tr class="hover:bg-gray-100">
                                        <td class="p-4 w-4">
                                            <div class="flex items-center">
                                                <input id="checkbox-1" aria-describedby="checkbox-1" type="checkbox" name="checkAll"
                                                    class="bg-gray-50 border-gray-300 focus:ring-3 focus:ring-cyan-200 h-4 w-4 rounded">
                                                <label for="checkbox-1" class="sr-only">checkbox</label>
                                            </div>
                                        </td>
                                        <td class="p-4 flex items-center whitespace-nowrap space-x-6 mr-12 lg:mr-0">
                                            <img class="h-10 w-10 rounded-full"
                                                src="{{ $value->profile ? asset('storage/profiles/' . $value->profile) : 'https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0=' }}"
                                                alt="">
                                            <div class="text-sm font-normal text-gray-500">
                                                <div class="text-base font-semibold text-gray-900">{{ $value->first_name }}
                                                    {{ $value->last_name }}</div>
                                                <div class="text-sm font-normal text-gray-500"> {{ $value->email }} </div>
                                            </div>
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            @if($value->gender == 1)
                                                Male
                                            @elseif($value->gender == 2)
                                                Female
                                            @endif
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">{{ $value->count}}
                                        </td>
                                        <td class="p-4 whitespace-nowrap space-x-2">
                                            <button type="button" data-twe-toggle="modal"
                                                data-twe-target="#editUser{{ $value->id }}"
                                                class="text-white bg-cyan-600 hover:bg-cyan-700 focus:ring-4 focus:ring-cyan-200 font-medium rounded-lg text-sm inline-flex items-center px-3 py-2 text-center">
                                                <svg class="mr-2 h-5 w-5" fill="currentColor" viewBox="0 0 20 20"
                                                    xmlns="http://www.w3.org/2000/svg">
                                                    <path
                                                        d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z">
                                                    </path>
                                                    <path fill-rule="evenodd"
                                                        d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"
                                                        clip-rule="evenodd"></path>
                                                </svg>
                                                Edit user
                                            </button>
                                            <button type="button" data-twe-toggle="modal"
                                                data-twe-target="#deleteUser{{ $value->id }}"
                                                class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm inline-flex items-center px-3 py-2 text-center">
                                                <svg class="mr-2 h-5 w-5" fill="currentColor" viewBox="0 0 20 20"
                                                    xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd"
                                                        d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                                        clip-rule="evenodd"></path>
                                                </svg>
                                                Delete user
                                            </button>
                                        </td>
                                    </tr>

                                    <!--edit user modal-->
                                    <div class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none"
                                        id="editUser{{ $value->id }}" data-twe-modal-init tabindex="-1"
                                        aria-modal="true">
                                        <div data-twe-modal-dialog-ref
                                            class="pointer-events-none relative flex min-h-[calc(100%-1rem)] w-auto translate-y-[-50px] items-center opacity-0 transition-all duration-300 ease-in-out min-[576px]:mx-auto min-[576px]:mt-7 min-[576px]:min-h-[calc(100%-3.5rem)] min-[576px]:max-w-[600px]">
                                            <div
                                                class="pointer-events-auto relative flex w-full flex-col rounded-md border-none bg-white bg-clip-padding text-current shadow-4 outline-none dark:bg-surface-dark">
                                                <div
                                                    class="flex flex-shrink-0 items-center justify-between rounded-t-md border-b-2 border-neutral-100 p-4 dark:border-white/10">
                                                    <!-- Modal title -->
                                                    <h5 class="text-xl font-medium leading-normal text-surface dark:text-white"
                                                        id="addUserModalTitle">
                                                        edit User
                                                    </h5>
                                                    <!-- Close button -->
                                                    <button type="button"
                                                        class="box-content rounded-none border-none text-neutral-500 hover:text-neutral-800 hover:no-underline focus:text-neutral-800 focus:opacity-100 focus:shadow-none focus:outline-none dark:text-neutral-400 dark:hover:text-neutral-300 dark:focus:text-neutral-300"
                                                        data-twe-modal-dismiss aria-label="Close">
                                                        <span class="[&>svg]:h-6 [&>svg]:w-6">
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor"
                                                                viewBox="0 0 24 24" stroke-width="1.5"
                                                                stroke="currentColor">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    d="M6 18L18 6M6 6l12 12" />
                                                            </svg>
                                                        </span>
                                                    </button>
                                                </div>

                                                <form action="" method="POST">
                                                    @csrf
                                                    <!-- Modal body -->
                                                    <div class="p-6 ">
                                                        <div class="grid grid-cols-6 gap-6">
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="first-name"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">First
                                                                    Name</label>
                                                                <input type="text" name="first_name" id="first_name"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    value="{{ old('first_name', $value->first_name) }}">
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="last-name"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">Last
                                                                    Name</label>
                                                                <input type="text" name="last_name" id="last_name"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    value="{{ old('last_name', $value->last_name) }}"
                                                                    required>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="email"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">Email</label>
                                                                <input type="email" name="email" id="email"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    value="{{ old('email', $value->email) }}" required>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="phone_number"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">Phone
                                                                    Number</label>
                                                                <input type="" name="phone_number"
                                                                    id="phone_number" pattern="[0-9+-]*"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    placeholder="{{$value->phone_number ?? 'N/A'}}"
                                                                    value="{{$value->phone_number}}">
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="age"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">
                                                                    Age</label>
                                                                <input type="number" name="age" id="age"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    value="{{ old('age', $value->age) }}" required>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="phone-number"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">
                                                                    Gender</label>
                                                                    <select name="gender" id="gender"
                                                                            class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                            required>
                                                                        <option value="" disabled {{ empty($value->gender) ? 'selected' : '' }}>Select your gender</option>
                                                                        <option value="1" {{ $value->gender == 1 ? 'selected' : '' }}>Male</option>
                                                                        <option value="2" {{ $value->gender == 2 ? 'selected' : '' }}>Female</option>
                                                                    </select>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for=""
                                                                    class="text-sm font-medium text-gray-900 block mb-2">
                                                                    Role</label>
                                                                    <select name="user_role" id="user_role"
                                                                            class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                            required>
                                                                        <option value="" disabled {{ empty($value->user_role) ? 'selected' : '' }}>Select user role</option>
                                                                        <option value="1" {{ $value->user_role == 0 ? 'selected' : '' }}>User</option>
                                                                        <option value="2" {{ $value->user_role == 2 ? 'selected' : '' }}>Clinic</option>
                                                                    </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Modal footer -->
                                                    <div
                                                        class="flex flex-shrink-0 flex-wrap items-center justify-end rounded-b-md border-t-2 border-neutral-100 p-4 dark:border-white/10">
                                                        <button type="button"
                                                            class="inline-block rounded bg-cyan-600 px-6 mx-2 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-white transition duration-150 ease-in-out hover:bg-cyan-700 focus:bg-primary-accent-200 focus:outline-none focus:ring-0 active:bg-primary-accent-200 dark:bg-primary-300 dark:hover:bg-primary-400 dark:focus:bg-primary-400 dark:active:bg-primary-400"
                                                            data-twe-modal-dismiss data-twe-ripple-init
                                                            data-twe-ripple-color="light">
                                                            Close
                                                        </button>
                                                        <input type="hidden" name="id"
                                                            value="{{ $value->id }}">
                                                        <button type="submit" name="form_type" value="edit"
                                                            class="ms-1 inline-block rounded bg-cyan-600 px-6 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-white shadow-primary-3 transition duration-150 ease-in-out hover:bg-cyan-700 hover:shadow-primary-2 focus:bg-cyan-700 focus:shadow-primary-2 focus:outline-none focus:ring-0 active:bg-cyan-700 active:shadow-primary-2 dark:shadow-black/30 dark:hover:shadow-dark-strong dark:focus:shadow-dark-strong dark:active:shadow-dark-strong"
                                                            data-twe-ripple-init data-twe-ripple-color="light">
                                                            Save changes
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!--delete user modal-->
                                    <div class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none"
                                        id="deleteUser{{ $value->id }}" data-twe-modal-init tabindex="-1"
                                        aria-modal="true">
                                        <div data-twe-modal-dialog-ref
                                            class="pointer-events-none relative flex min-h-[calc(100%-1rem)] w-auto translate-y-[-50px] items-center opacity-0 transition-all duration-300 ease-in-out min-[576px]:mx-auto min-[576px]:mt-7 min-[576px]:min-h-[calc(100%-3.5rem)] min-[576px]:max-w-[500px]">
                                            <div
                                                class="pointer-events-auto relative flex w-full flex-col rounded-md border-none bg-white bg-clip-padding text-current shadow-4 outline-none dark:bg-surface-dark">
                                                <!-- Modal content -->
                                                <div class="bg-white rounded-lg shadow relative">
                                                    <!-- Modal header -->
                                                    <div class="flex justify-end p-2">
                                                        <button type="button" data-twe-modal-dismiss
                                                            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
                                                            data-modal-toggle="delete-user-modal">
                                                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                                                                xmlns="http://www.w3.org/2000/svg">
                                                                <path fill-rule="evenodd"
                                                                    d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                                    clip-rule="evenodd"></path>
                                                            </svg>
                                                        </button>
                                                    </div>
                                                    <!-- Modal body -->
                                                    <div class="p-6 pt-0 text-center">
                                                        <svg class="w-20 h-20 text-red-600 mx-auto" fill="none"
                                                            stroke="currentColor" viewBox="0 0 24 24"
                                                            xmlns="http://www.w3.org/2000/svg">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                            </path>
                                                        </svg>
                                                        <h3 class="text-xl font-normal text-gray-500 mt-5 mb-6">Are you
                                                            sure you want to delete this user?
                                                        </h3>
                                                        <a href="{{ url('user/delete/'.$value->id)}}"
                                                            class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-base inline-flex items-center px-3 py-2.5 text-center mr-2">
                                                            Yes, I'm sure
                                                        </a>
                                                        <a href="#"
                                                            class="text-gray-900 bg-white hover:bg-gray-100 focus:ring-4 focus:ring-cyan-200 border border-gray-200 font-medium inline-flex items-center rounded-lg text-base px-3 py-2.5 text-center"
                                                            data-twe-modal-dismiss data-twe-ripple-init>
                                                            No, cancel
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div
            class="bg-white sticky sm:flex items-center w-full sm:justify-between bottom-0 right-0 border-t border-gray-200 p-4">
            <div class="flex items-center mb-4 sm:mb-0">
                <span class="text-sm font-normal text-gray-500">Showing <span
                        class="text-gray-900 font-semibold">{{ $getRecord->firstItem() }}-{{ $getRecord->lastItem() }}</span> of <span
                        class="text-gray-900 font-semibold">{{ $getRecord->total() }}</span>
                </span>
                <form action="" method="GET">
                    <div class="ml-4">
                        <select name="per_page" id="per_page"
                            class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600"
                            onchange="this.form.submit()">
                            <option value="10" {{ request('per_page') == 10 ? 'selected' : '' }}>10</option>
                            <option value="20" {{ request('per_page') == 20 ? 'selected' : '' }}>20</option>
                            <option value="50" {{ request('per_page') == 50 ? 'selected' : '' }}>50</option>
                            <option value="100" {{ request('per_page') == 100 ? 'selected' : '' }}>100</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="flex items-center space-x-3">
                <a href="{{ $getRecord->previousPageUrl() }}"
                    class="flex-1 w-1/2 text-gray-900 bg-white border border-gray-300 hover:bg-gray-100 focus:ring-4 focus:ring-cyan-200 font-medium inline-flex items-center justify-center rounded-lg text-sm px-3 py-2 text-center sm:w-auto">
                    <svg class="-ml-1 mr-1 h-5 w-5" fill="currentColor" viewBox="0 0 20 20"
                        xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                            d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                            clip-rule="evenodd"></path>
                    </svg>
                    Previous
                </a>
                <a href="{{ $getRecord->nextPageUrl() }}"
                    class="flex-1 w-1/2 text-gray-900 bg-white border border-gray-300 hover:bg-gray-100 focus:ring-4 focus:ring-cyan-200 font-medium inline-flex items-center justify-center rounded-lg text-sm px-3 py-2 text-center sm:w-auto">
                    Next
                    <svg class="-mr-1 ml-1 h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                            d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                            clip-rule="evenodd"></path>
                    </svg>
                </a>
            </div>
        </div>
    </main>
@endsection

<script>
    function toggle(source) {
        checkboxes = document.getElementsByName('checkAll');
        for(var i=0, n=checkboxes.length;i<n;i++) {
            checkboxes[i].checked = source.checked;
        }
    }
</script>
