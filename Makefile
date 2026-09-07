.PHONY: help build-ios run-ios clean-ios

help:
	@echo "Available commands:"
	@echo "  make build-ios       - Build the iOS App for Simulator"
	@echo "  make run-ios         - Run the iOS App on the Simulator"
	@echo "  make clean-ios       - Clean the iOS build"

build-ios:
	xcodebuild -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemo -destination 'platform=iOS Simulator,name=iPhone 13 Pro Max' -derivedDataPath build build

run-ios: build-ios
	xcrun simctl boot "iPhone 13 Pro Max" || true
	xcrun simctl install "iPhone 13 Pro Max" build/Build/Products/Debug-iphonesimulator/LegoStyleDemo.app
	xcrun simctl launch "iPhone 13 Pro Max" com.example.lego.LegoStyleDemo

clean-ios:
	xcodebuild -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemo clean
	rm -rf build/
