#!/bin/bash
set -e

echo "==================================================="
echo "  Setting up macOS Environment for iOS Native "
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

# 2. Check for Xcode
echo "Checking for Xcode..."
if xcode-select -p &> /dev/null; then
    echo "✅ Xcode Command Line Tools are installed."
else
    echo "❌ Xcode is not installed or xcode-select path is missing."
    echo "Please install Xcode from the App Store and run 'sudo xcode-select -s /Applications/Xcode.app/Contents/Developer'"
    exit 1
fi

# 3. Install XcodeGen
echo "Installing XcodeGen..."
if ! command -v xcodegen &> /dev/null; then
    brew install xcodegen
else
    echo "✅ XcodeGen is already installed."
fi

# 4. Generate Xcode Project
echo "Generating LegoStyleDemo.xcodeproj..."
xcodegen generate

echo "==================================================="
echo "🎉 Setup complete! "
echo "You can now run 'make build-ios' or 'make run-ios'."
echo "==================================================="
