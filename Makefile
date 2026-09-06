# Makefile for Android Jetpack Compose Monorepo

# Ensure Gradle can find Java and the Android SDK natively (mimicking Flutter's auto-resolution)
export JAVA_HOME ?= /opt/homebrew/opt/openjdk@17
export ANDROID_HOME ?= $(HOME)/Library/Android/sdk

.PHONY: help build lint test clean clean-all sync

# Default target
help:
	@echo "Available commands:"
	@echo "  make build       - Build the debug APK"
	@echo "  make lint        - Run Android static analysis (lint)"
	@echo "  make test        - Run unit tests across all modules"
	@echo "  make clean       - Clean the build directory"
	@echo "  make clean-all   - Deep clean (stop Gradle daemons, remove caches)"
	@echo "  make sync        - Sync Gradle dependencies"

build:
	@echo "🔨 Building debug APK..."
	./gradlew assembleDebug

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
