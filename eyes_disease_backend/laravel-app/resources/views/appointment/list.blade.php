@extends('layouts/app')

@section('content')
    <main>
        <div class="p-4 bg-white block sm:flex items-center justify-between border-b border-gray-200 lg:mt-1.5">
            <div class="mb-1 w-full">
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
                                        class="text-gray-700 hover:text-gray-900 ml-1 md:ml-2 text-sm font-medium">Appointments</a>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>
                <div class="sm:flex">
                    <div class="hidden sm:flex items-center sm:divide-x sm:divide-gray-100 mb-3 sm:mb-0">
                        <form class="lg:pr-3" action="" >
                            <label for="users-search" class="sr-only">Search</label>
                            <div class="mt-1 relative lg:w-64 xl:w-96">
                                <input type="text" name="search" id="users-search"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-cyan-600 focus:border-cyan-600 block w-full p-2.5"
                                    placeholder="Search Name" value="{{ request()->input('search') }}">
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
                                        Date
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Patient
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Phone Number
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Status
                                    </th>
                                    <th scope="col" class="p-4 text-left text-xs font-medium text-gray-500 uppercase">
                                        Doctor
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
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            {{ \Carbon\Carbon::parse($value->preferred_date)->format('d M Y h:i A') }}
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            {{$value->user_first_name}} {{$value->user_last_name}}
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            {{$value->phone_number}}
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium">
                                            <span class="{{ $value->request_status === 'Approved' ? 'text-green-600' : ($value->request_status === 'Rejected' ? 'text-red-600' : 'text-yellow-600') }}">
                                                {{ $value->request_status }}
                                            </span>
                                        </td>
                                        <td class="p-4 whitespace-nowrap text-base font-medium text-gray-900">
                                            {{$value->doctor_first_name}} {{$value->doctor_last_name}}
                                        </td>
                                        <td class="p-4 whitespace-nowrap space-x-2">
                                            <!-- Accept Button Form -->
                                            <form action="{{ url('/appointment/list') }}" method="POST" class="inline">
                                                @csrf
                                                <input type="hidden" name="id" value="{{ $value->id }}">
                                                <button type="submit" name="action" value="accept"
                                                    class="text-white bg-cyan-600 hover:bg-cyan-700 focus:ring-4 focus:ring-cyan-200 font-medium rounded-lg text-sm inline-flex items-center px-3 py-2 text-center">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5">
                                                        <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                                                    </svg>

                                                    Accept
                                                </button>

                                            </form>

                                            <!-- Reject Button Form -->
                                            <form action="{{ url('/appointment/list') }}" method="POST" class="inline">
                                                @csrf
                                                <input type="hidden" name="id" value="{{ $value->id }}">
                                                <button type="submit" name="action" value="reject"
                                                    class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm inline-flex items-center px-3 py-2 text-center">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5">
                                                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                                                      </svg>
                                                    Reject
                                                </button>

                                            </form>
                                        </td>
                                    </tr>
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
