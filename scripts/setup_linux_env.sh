#!/bin/bash

# setup_linux_env.sh
# Automates the setup of the Android Native development environment on Linux
# Suitable for CI/CD pipelines and new developer onboarding

set -e # Exit on error

echo "============================================================"
echo "    Lego Architecture - Linux Environment Setup"
echo "============================================================"

# Ensure script is run as root or with sudo for package installation
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
else
  SUDO=""
fi

# 1. Update and install dependencies
echo "[1/4] Installing basic dependencies..."
$SUDO apt-get update -y
$SUDO apt-get install -y curl git unzip wget jq

# 2. Install OpenJDK 17
echo "[2/4] Installing OpenJDK 17..."
$SUDO apt-get install -y openjdk-17-jdk

# 3. Download and Install Android SDK (Command line tools)
echo "[3/4] Setting up Android SDK..."
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
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

# 4. Add paths to ~/.bashrc
echo "[4/4] Configuring environment variables..."
BASHRC=$HOME/.bashrc
if ! grep -q "ANDROID_HOME" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# Android SDK & Java" >> "$BASHRC"
    echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> "$BASHRC"
    echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools' >> "$BASHRC"
fi

echo "============================================================"
echo "Setup Complete!"
echo "Please restart your terminal or run: source ~/.bashrc"
echo "============================================================"
