#!/bin/bash

# Build the APK
flutter build apk --release

# Get the Flutter project name from pubspec.yaml
project_name=$(grep '^name:' pubspec.yaml | sed 's/name: //')

# Source and destination APK paths
apk_path="build/app/outputs/flutter-apk/app-release.apk"
destination_path="build/app/outputs/flutter-apk/${project_name}.apk"

# Rename the APK file to the project name
if [ -f "$apk_path" ]; then
    mv "$apk_path" "$destination_path"
    echo "APK has been renamed to ${project_name}.apk"
else
    echo "APK build failed or file not found!"
fi
