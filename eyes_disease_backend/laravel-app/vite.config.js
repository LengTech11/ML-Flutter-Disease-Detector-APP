import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/css/app.css',
                'resources/js/app.js',
                'node_modules/tw-elements/js/tw-elements.umd.min.js',
            ],
            refresh: true,
        }),
    ],
});
