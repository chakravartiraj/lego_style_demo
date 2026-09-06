#!/bin/bash
set -e

echo "==================================================="
echo "  Setting up macOS Environment for Android Native "
echo "==================================================="

# 1. Check/Install Homebrew
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to path for Apple Silicon Mac
    if [ -d "/opt/homebrew/bin" ]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    fi
else
    echo "✅ Homebrew is already installed."
fi

# 2. Install OpenJDK 17
echo "Installing OpenJDK 17..."
brew install openjdk@17 || true
if ! grep -q 'openjdk@17/bin' ~/.zshrc; then
    echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
    echo 'export JAVA_HOME="/opt/homebrew/opt/openjdk@17"' >> ~/.zshrc
fi

# 3. Install Android Studio (for Android SDK)
echo "Installing Android Studio..."
if [ ! -d "/Applications/Android Studio.app" ]; then
    brew install --cask android-studio
else
    echo "✅ Android Studio is already installed."
fi

# 4. Configure Android SDK Path
echo "Configuring Android SDK variables..."
if ! grep -q "ANDROID_HOME" ~/.zshrc; then
    echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
    echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools' >> ~/.zshrc
fi

echo "==================================================="
echo "🎉 Setup complete! "
echo "Please restart your terminal or run 'source ~/.zshrc'."
echo "==================================================="
