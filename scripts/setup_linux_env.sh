#!/bin/bash

# setup_linux_env.sh
# Automates the setup of the Flutter development environment on Linux
# Suitable for CI/CD pipelines and new developer onboarding

set -e # Exit on error

echo "============================================================"
echo "    HMWSSB Tanker Service - Linux Environment Setup"
echo "============================================================"

# Ensure script is run as root or with sudo for package installation
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
else
  SUDO=""
fi

# 1. Update and install dependencies
echo "[1/7] Installing basic dependencies..."
$SUDO apt-get update -y
$SUDO apt-get install -y curl git unzip xz-utils zip libglu1-mesa jq lcov wget clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev

# 2. Install OpenJDK 17
echo "[2/7] Installing OpenJDK 17..."
$SUDO apt-get install -y openjdk-17-jdk

# 3. Download and Install Android SDK (Command line tools)
echo "[3/7] Setting up Android SDK..."
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

if [ ! -d "$ANDROID_HOME" ]; then
    mkdir -p $ANDROID_HOME/cmdline-tools
    cd $ANDROID_HOME/cmdline-tools
    echo "Downloading Android Commandline Tools..."
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O cmdline-tools.zip
    unzip -q cmdline-tools.zip
    rm cmdline-tools.zip
    mv cmdline-tools latest
else
    echo "Android SDK directory already exists."
fi

# Accept licenses
echo "Accepting Android SDK licenses..."
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses > /dev/null

# Install required Android platforms and build tools
echo "Installing Android Platform and Build Tools..."
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-36" "platforms;android-34" "build-tools;34.0.0" "build-tools;28.0.3"
# 4. Download and Install Flutter SDK
echo "[4/7] Setting up Flutter SDK..."
FLUTTER_HOME=$HOME/flutter
if [ ! -d "$FLUTTER_HOME" ]; then
    echo "Cloning Flutter SDK..."
    git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME
else
    echo "Flutter SDK already exists. Skipping clone."
fi

export PATH=$PATH:$FLUTTER_HOME/bin
export PATH=$PATH:$HOME/.pub-cache/bin

# 5. Add paths to ~/.bashrc
echo "[5/7] Configuring environment variables..."
BASHRC=$HOME/.bashrc
if ! grep -q "ANDROID_HOME" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# Android SDK" >> "$BASHRC"
    echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> "$BASHRC"
    echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools' >> "$BASHRC"
fi

if ! grep -q "FLUTTER_HOME" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# Flutter SDK" >> "$BASHRC"
    echo 'export FLUTTER_HOME=$HOME/flutter' >> "$BASHRC"
    echo 'export PATH=$PATH:$FLUTTER_HOME/bin:$HOME/.pub-cache/bin' >> "$BASHRC"
fi

# 6. Run Flutter Doctor
echo "[6/7] Running Flutter doctor..."
flutter config --android-sdk $ANDROID_HOME
flutter doctor --android-licenses || true
flutter doctor

# 7. Install global Dart packages
echo "[7/7] Activating global Dart packages..."
dart pub global activate cider
dart pub global activate dep_audit

echo "============================================================"
echo "Setup Complete!"
echo "Please restart your terminal or run: source ~/.bashrc"
echo "============================================================"
