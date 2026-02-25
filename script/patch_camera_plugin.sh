#!/bin/bash

# Script to patch camera_android_camerax plugin
# This fixes compatibility issues with Flutter engine

# Try to find the plugin version in use
PLUGIN_VERSIONS=("0.6.8+2" "0.6.11" "0.6.14" "0.6.16" "0.6.12" "0.6.13" "0.6.15")
PLUGIN_PATH=""
JAVA_FILE=""

for version in "${PLUGIN_VERSIONS[@]}"; do
    potential_path="$HOME/.pub-cache/hosted/pub.dev/camera_android_camerax-$version/android/build.gradle"
    potential_java="$HOME/.pub-cache/hosted/pub.dev/camera_android_camerax-$version/android/src/main/java/io/flutter/plugins/camerax/PreviewHostApiImpl.java"
    if [ -f "$potential_path" ]; then
        PLUGIN_PATH="$potential_path"
        JAVA_FILE="$potential_java"
        break
    fi
done

if [ -z "$PLUGIN_PATH" ]; then
    echo "Plugin not found. Run 'flutter pub get' first"
    exit 1
fi

# Patch build.gradle if needed (for flutter.compileSdkVersion issue)
if grep -q "compileSdk = flutter\.compileSdkVersion" "$PLUGIN_PATH"; then
    if grep -q "compileSdk = 34" "$PLUGIN_PATH"; then
        echo "build.gradle already patched: $PLUGIN_PATH"
    else
        sed -i '' 's/compileSdk = flutter\.compileSdkVersion/compileSdk = 34/g' "$PLUGIN_PATH"
        echo "Patched build.gradle: $PLUGIN_PATH"
    fi
else
    echo "build.gradle uses hardcoded compileSdk (no patch needed): $PLUGIN_PATH"
fi

# Patch PreviewHostApiImpl.java if needed (for SurfaceProducer.Callback issue)
if [ -f "$JAVA_FILE" ]; then
    if grep -q "onSurfaceCreated()" "$JAVA_FILE"; then
        sed -i '' 's/onSurfaceCreated()/onSurfaceAvailable()/g' "$JAVA_FILE"
        echo "Patched PreviewHostApiImpl.java: $JAVA_FILE"
    else
        echo "PreviewHostApiImpl.java already uses onSurfaceAvailable (no patch needed): $JAVA_FILE"
    fi
else
    echo "PreviewHostApiImpl.java not found: $JAVA_FILE"
fi
