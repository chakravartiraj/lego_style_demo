# Makefile for Android Jetpack Compose Monorepo

# Ensure Gradle can find Java and the Android SDK natively (mimicking Flutter's auto-resolution)
export JAVA_HOME ?= /opt/homebrew/opt/openjdk@17
export ANDROID_HOME ?= $(HOME)/Library/Android/sdk

.PHONY: help build lint test clean clean-all sync

# Default target
help:
	@echo "Available commands:"
	@echo "  make build-apk-debug   - Build the debug APK"
	@echo "  make build-apk-release - Build the release APK"
	@echo "  make build-aab-debug   - Build the debug App Bundle (AAB)"
	@echo "  make build-aab-release - Build the release App Bundle (AAB)"
	@echo "  make lint              - Run Android static analysis (lint)"
	@echo "  make test              - Run unit tests across all modules"
	@echo "  make clean             - Clean the build directory"
	@echo "  make clean-all         - Deep clean (stop Gradle daemons, remove caches)"
	@echo "  make sync              - Sync Gradle dependencies"
	@echo "  make create-emulator   - Create an Android emulator if it doesn't exist"
	@echo "  make run-android       - Install and launch the app on connected device/emulator"

build-apk-debug:
	@echo "🔨 Building debug APK..."
	./gradlew assembleDebug

build-apk-release:
	@echo "📦 Building release APK..."
	./gradlew assembleRelease

build-aab-debug:
	@echo "📦 Building debug AAB..."
	./gradlew bundleDebug

build-aab-release:
	@echo "🚀 Building release AAB..."
	./gradlew bundleRelease

lint:
	@echo "🔍 Running Android static analysis..."
	./gradlew lint

test:
	@echo "🧪 Running unit tests..."
	./gradlew testDebugUnitTest

clean:
	@echo "🧹 Cleaning build directories..."
	./gradlew clean

clean-all:
	@echo "🌪️ Performing deep clean..."
	./gradlew clean
	./gradlew --stop
	rm -rf ~/.gradle/caches/

sync:
	@echo "🔄 Syncing Gradle dependencies..."
	./gradlew dependencies

create-emulator:
	@echo "📱 Checking/Creating Android Emulator..."
	@ARCH=$$(uname -m); \
	if [ "$$ARCH" = "arm64" ] || [ "$$ARCH" = "aarch64" ]; then \
		SYS_IMG="system-images;android-34;google_apis;arm64-v8a"; \
	else \
		SYS_IMG="system-images;android-34;google_apis;x86_64"; \
	fi; \
	echo "Installing $$SYS_IMG..."; \
	yes | $(ANDROID_HOME)/cmdline-tools/latest/bin/sdkmanager "$$SYS_IMG" > /dev/null; \
	if ! $(ANDROID_HOME)/cmdline-tools/latest/bin/avdmanager list avd | grep -q "LegoEmulator"; then \
		echo "no" | $(ANDROID_HOME)/cmdline-tools/latest/bin/avdmanager create avd -n LegoEmulator -k "$$SYS_IMG" --device "pixel" --force; \
		echo "✅ Emulator 'LegoEmulator' created."; \
	else \
		echo "✅ Emulator 'LegoEmulator' already exists."; \
	fi

run-android:
	@echo "🚀 Installing and Launching App on connected device/emulator..."
	./gradlew installDebug
	$(ANDROID_HOME)/platform-tools/adb logcat -c
	$(ANDROID_HOME)/platform-tools/adb shell am start -n com.example.lego/.MainActivity
	@echo "📡 Attaching to logcat... (Press Ctrl+C to stop)"
	@sleep 1
	$(ANDROID_HOME)/platform-tools/adb logcat --pid=$$($(ANDROID_HOME)/platform-tools/adb shell pidof -s com.example.lego)
