# VisionCareAI Consult

This is a project using Flutter for the front end and Laravel for the back end. This README provides a guide to set up and run the project locally.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [Backend Setup (Laravel)](#backend-setup-laravel)
  - [Frontend Setup (Flutter)](#frontend-setup-flutter)
- [Running the Project](#running-the-project)
  - [Running the Backend](#running-the-backend)
  - [Running the Frontend](#running-the-frontend)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Prerequisites

Ensure you have the following installed on your system:

- [Node.js and npm](https://nodejs.org/)
- [Composer](https://getcomposer.org/)
- [PHP](https://www.php.net/)
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) (for iOS development)

## Setup

### Backend Setup (Laravel)

1. Clone the repository:
    ```bash
    git clone https://github.com/LengTech11/VisionCareAI-Detect-Consult
    ```

2. Install dependencies:
    ```bash
    composer install
    ```

3. Copy the `.env.example` file to `.env`:
    ```bash
    cp .env.example .env
    ```

4. Generate the application key:
    ```bash
    php artisan key:generate
    ```

5. Set up your database and update the `.env` file with your database credentials.

6. Run the migrations:
    ```bash
    php artisan migrate
    ```

7. Seed the database (optional):
    ```bash
    php artisan db:seed
    ```

### Frontend Setup (Flutter)

1. Navigate to the frontend directory:
    ```bash
    cd ../frontend
    ```

2. Get the Flutter dependencies:
    ```bash
    flutter pub get
    ```

## Running the Project

### Running the Backend

1. Start the Laravel development server:
    ```bash
    php artisan serve
    ```

2. The server will be running at `http://127.0.0.1:8000`.

### Running the Frontend

1. Ensure your device or emulator is running.

2. Start the Flutter application:
    ```bash
    flutter run
    ```

## Configuration

- **Backend (Laravel)**: Configure your environment variables in the `.env` file located in the `backend` directory.
- **Frontend (Flutter)**: Configure any necessary constants or API endpoints in the appropriate configuration files.

## Troubleshooting

- **Backend Issues**:
  - Ensure your `.env` file is configured correctly.
  - Check if your database service is running.

- **Frontend Issues**:
  - Ensure you have a connected device or emulator.
  - Check for dependency issues by running `flutter doctor`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
