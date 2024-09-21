@extends('layouts/app')

@section('content')
    <main>
        <div class="p-4 bg-white block sm:flex items-center justify-between border-b border-gray-200 lg:mt-1.5">
            <div class="mb-1 w-full">
                <!--add doctor modal-->
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
                                    Add Doctor
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
                                            <label class="text-sm font-medium text-gray-900 block mb-2">
                                                Title</label>
                                            <select name="title" id="title"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                required>
                                                <option value="" disabled selected>Select Title</option>
                                                <option value="DR">DR</option>
                                                <option value="MR">MR</option>
                                                <option value="MRS">MRS</option>
                                            </select>
                                        </div>
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
                                            <label for="specialist"
                                                class="text-sm font-medium text-gray-900 block mb-2">Specialist</label>
                                            <input type="text" name="specialist" id="specialist" value="{{ old('specialist') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="Heart Specialist" required>
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label for="phone-number"
                                                class="text-sm font-medium text-gray-900 block mb-2">Phone
                                                Number</label>
                                            <input type="number" name="phone_number" id="phone_number"
                                                value="{{ old('phone_number') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="e.g. +(12)3456 789">
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label for="Experience"
                                                class="text-sm font-medium text-gray-900 block mb-2">Experience
                                                </label>
                                            <input type="number" name="experience" id="experience"
                                                value="{{ old('experience') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="1 Year" required>
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label class="text-sm font-medium text-gray-900 block mb-2">
                                                Telegram</label>
                                            <input type="text" name="telegram" id="telegramInput" value="{{ old('telegram', 'https://t.me/+855') }}"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                placeholder="">
                                        </div>
                                        <div class="col-span-6 sm:col-span-3">
                                            <label class="text-sm font-medium text-gray-900 block mb-2">
                                                Status</label>
                                            <select name="status" id="status"
                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                required>
                                                <option value="" disabled selected>Select Status</option>
                                                <option value="0">Unvaible</option>
                                                <option value="1">Avaible</option>
                                            </select>
                                        </div>
                                        <div class="col-span-8 sm:col-span-6">
                                            <label class="text-sm font-medium text-gray-900 block mb-2">Description</label>
                                            <textarea name="description" id="description" cols="auto" rows="3" placeholder="Write description here" style="resize: none"
                                            class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5">{{old('description')}}</textarea>
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
                                <a href=" {{url('clinic/dashboard')}} " class="text-gray-700 hover:text-gray-900 inline-flex items-center">
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
                                        class="text-gray-700 hover:text-gray-900 ml-1 md:ml-2 text-sm font-medium">Doctor</a>
                                </div>
                            </li>
                        </ol>
                    </nav>
                    <h1 class="text-xl sm:text-2xl font-semibold text-gray-900">All Doctors</h1>
                </div>
                <div class="sm:flex">
                    <div class="hidden sm:flex items-center sm:divide-x sm:divide-gray-100 mb-3 sm:mb-0">
                        <form class="lg:pr-3" action="" >
                            <label for="users-search" class="sr-only">Search</label>
                            <div class="mt-1 relative lg:w-64 xl:w-96">
                                <input type="text" name="search" id="users-search"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                    placeholder="Search for doctors" value="{{ request()->input('search') }}">
                            </div>
                        </form>
                        <div class="flex space-x-1 pl-0 sm:pl-2 mt-3 sm:mt-0 ">
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
                            Add Doctor
                        </button>
                    </div>
                </div>
            </div>
        </div>

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
                                        Telegram
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Patient
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Status
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
                                                <div class="text-base font-semibold text-gray-900"> {{$value->title}} {{ $value->first_name }}
                                                    {{ $value->last_name }}</div>
                                                <div class="text-sm font-normal text-gray-500"> {{ $value->specialist }} </div>
                                            </div>
                                        </td>

                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            {{$value->telegram}}
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            {{$value->patient}}
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            @if($value->status == 0)
                                                Unavailable
                                            @elseif($value->status == 1)
                                                Available
                                            @endif
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
                                                Edit Doctor
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
                                                Delete Doctor
                                            </button>
                                        </td>
                                    </tr>

                                    <!--edit doctor modal-->
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
                                                        Edit Doctor
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

                                                {{-- <form action="" method="POST"> --}}
                                                <form action="" method="POST" enctype="multipart/form-data">
                                                    @csrf
                                                    <!-- Modal body -->
                                                    <div class="p-6 space-y-6">
                                                        <div class="grid grid-cols-6 gap-6">
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="phone-number"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">
                                                                    Title</label>
                                                                    <select name="title" id="title"
                                                                            class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                            required>
                                                                        <option value="" disabled {{ empty($value->title) ? 'selected' : '' }}>Select title</option>
                                                                        <option value="DR" {{ $value->title == 'DR' ? 'selected' : '' }}>DR</option>
                                                                        <option value="MR" {{ $value->title == 'MR' ? 'selected' : '' }}>MR</option>
                                                                        <option value="MRS" {{ $value->title == 'MRS' ? 'selected' : '' }}>MRS</option>
                                                                    </select>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label class="text-sm font-medium text-gray-900 block mb-2">First
                                                                    Name</label>
                                                                <input type="text" name="first_name" id="first_name"
                                                                    value="{{ old('fitst_name', $value->first_name )}}"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    placeholder="Bonnie" required>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label class="text-sm font-medium text-gray-900 block mb-2">Last
                                                                    Name</label>
                                                                <input type="text" name="last_name" id="last_name"
                                                                    value="{{ old('last', $value->last_name) }}"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    placeholder="Green" required>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="profile_pic" class="text-sm font-medium text-gray-900 block mb-2">Profile Picture</label>
                                                                <input type="file" id="profile_pic" name="profile_pic" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5">
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="specialist"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">Specialist</label>
                                                                <input type="text" name="specialist" id="specialist" value="{{ old('specialist', $value->specialist) }}"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    placeholder="Heart Specialist" required>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="phone-number"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">Phone
                                                                    Number</label>
                                                                <input type="number" name="phone_number" id="phone_number"
                                                                    value="{{ old('phone_number', $value->phone_number) }}"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    placeholder="e.g. +(12)3456 789">
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for="Experience"
                                                                    class="text-sm font-medium text-gray-900 block mb-2">Experience
                                                                    </label>
                                                                <input type="number" name="experience" id="experience"
                                                                    value="{{ old('experience', $value->experience) }}"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    placeholder="1 Year" required>
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label class="text-sm font-medium text-gray-900 block mb-2">
                                                                    Telegram</label>
                                                                <input type="text" name="telegram" id="telegramInput" value="{{ old('telegram', $value->telegram ?? 'https://t.me/+855') }}"
                                                                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                    placeholder="">
                                                            </div>
                                                            <div class="col-span-6 sm:col-span-3">
                                                                <label for=""
                                                                    class="text-sm font-medium text-gray-900 block mb-2">
                                                                    Status</label>
                                                                    <select name="status" id="status"
                                                                            class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                                                            required>
                                                                        <option value="" disabled {{ empty($value->status) ? 'selected' : '' }}>Select Status</option>
                                                                        <option value="0" {{ $value->status == '0' ? 'selected' : '' }}>Unavailable</option>
                                                                        <option value="1" {{ $value->status == '1' ? 'selected' : '' }}>Available</option>
                                                                    </select>
                                                            </div>
                                                            <div class="col-span-8 sm:col-span-6">
                                                                <label class="text-sm font-medium text-gray-900 block mb-2">Description</label>
                                                                <textarea name="description" id="description" cols="auto" rows="4" placeholder="write descrition here" style="resize: none"
                                                                class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5">{{$value->description}}</textarea>
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
                                                            value="{{ $value->id}}">
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
                                                            sure you want to delete this doctor?
                                                        </h3>
                                                        <a href="{{ url('doctor/delete/'.$value->id)}}"
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

    document.addEventListener('DOMContentLoaded', function () {
        const input = document.getElementById('telegramInput');
        const prefix = 'https://t.me/+855';

        // Ensure the input starts with the correct prefix
        if (!input.value.startsWith(prefix)) {
            input.value = prefix;
        }

        // Prevent the user from modifying the prefix
        input.addEventListener('keydown', function (e) {
            if (input.selectionStart < prefix.length) {
                e.preventDefault();
            }
        });

        // Ensure that prefix stays at the beginning
        input.addEventListener('input', function () {
            if (!input.value.startsWith(prefix)) {
                input.value = prefix + input.value.slice(prefix.length);
            }
        });
    });

</script>
