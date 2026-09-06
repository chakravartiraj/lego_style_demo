#!/bin/bash
set -e

echo "==================================================="
echo "  Setting up macOS Environment for Flutter & Android "
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

# 2. Install Ruby Environment (rbenv)
echo "Installing Ruby environment (rbenv)..."
brew install rbenv ruby-build || true
if ! grep -qs 'rbenv init' ~/.zshrc; then
    echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
fi

# 3. Install iOS Dependencies
echo "Installing iOS dependencies (Cocoapods, Fastlane)..."
brew install cocoapods || true
brew install fastlane || true

# 4. Install Flutter SDK
echo "Installing Flutter SDK..."
if ! command -v flutter &> /dev/null; then
    brew install --cask flutter
else
    echo "✅ Flutter SDK is already installed."
fi

# 5. Install Android Studio (for Android SDK)
echo "Installing Android Studio..."
if [ ! -d "/Applications/Android Studio.app" ]; then
    brew install --cask android-studio
else
    echo "✅ Android Studio is already installed."
fi

# 6. Android Licenses Check
echo "Attempting to accept Android Licenses..."
echo "Note: If this fails, open Android Studio -> SDK Manager -> SDK Tools -> Check 'Android SDK Command-line Tools' and click Apply, then run 'flutter doctor --android-licenses'"
yes | flutter doctor --android-licenses || true

echo "==================================================="
echo "🎉 Setup complete! "
echo "Please restart your terminal or run 'source ~/.zshrc', then run 'flutter doctor' to verify."
echo "==================================================="
