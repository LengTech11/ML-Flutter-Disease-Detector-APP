@if (session('success'))
    <div id="message" class="fixed top-0 inset-x-0 p-4 z-50 transition-opacity duration-1000 ease-in-out">
        <div class="bg-green-200 bg-opacity-50 px-6 py-3 rounded-md text-lg flex items-center justify-between mx-auto max-w-lg shadow-lg">
            <div class="flex items-center">
                <svg viewBox="0 0 24 24" class="text-green-600 w-6 h-6 sm:w-6 sm:h-6 mr-3">
                    <path fill="currentColor"
                        d="M12,0A12,12,0,1,0,24,12,12.014,12.014,0,0,0,12,0Zm6.927,8.2-6.845,9.289a1.011,1.011,0,0,1-1.43.188L5.764,13.769a1,1,0,1,1,1.25-1.562l4.076,3.261,6.227-8.451A1,1,0,1,1,18.927,8.2Z">
                    </path>
                </svg>
                <span class="text-green-800">{{ session('success') }}</span>
            </div>
            <button id="close-alert" class="text-green-600 hover:text-green-800 focus:outline-none">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                </svg>
            </button>
        </div>
    </div>

@elseif (session('error'))
    <div id="message" class="fixed top-0 inset-x-0 p-4 z-50 transition-opacity duration-1000 ease-in-out">
        <div class="bg-red-200 bg-opacity-50 px-6 py-3 rounded-md text-base flex items-center justify-between mx-auto max-w-lg shadow-lg">
            <div class="flex items-center">
                <svg viewBox="0 0 24 24" class="text-red-600 w-6 h-6 sm:w-6 sm:h-6 mr-3">
                    <path fill="currentColor"
                        d="M11.983,0a12.206,12.206,0,0,0-8.51,3.653A11.8,11.8,0,0,0,0,12.207,11.779,11.779,0,0,0,11.8,24h.214A12.111,12.111,0,0,0,24,11.791h0A11.766,11.766,0,0,0,11.983,0ZM10.5,16.542a1.476,1.476,0,0,1,1.449-1.53h.027a1.527,1.527,0,0,1,1.523,1.47,1.475,1.475,0,0,1-1.449,1.53h-.027A1.529,1.529,0,0,1,10.5,16.542ZM11,12.5v-6a1,1,0,0,1,2,0v6a1,1,0,1,1-2,0Z">
                    </path>
                </svg>
                <span class="text-red-800">{{ session('error') }}</span>
            </div>
            <button id="close-alert" class="text-red-600 hover:text-red-800 focus:outline-none">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                </svg>
            </button>
        </div>
    </div>
@endif

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Auto-hide after 3 seconds
        setTimeout(function () {
            document.getElementById('message').classList.add('opacity-0');
        }, 5000); // 3 seconds

        // Remove from DOM after fade out
        setTimeout(function () {
            document.getElementById('message').remove();
        }, 4000); // 4 seconds to allow fade out

        // Manual close button
        document.getElementById('close-alert').addEventListener('click', function () {
            document.getElementById('message').classList.add('opacity-0');
            setTimeout(function () {
                document.getElementById('message').remove();
            }, 1000); // 1 second to allow fade out
        });
    });
</script>
