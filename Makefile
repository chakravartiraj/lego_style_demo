.PHONY: run build-apk build-ios generate pub-get

# Run the Flutter application
run:
	@echo "Running the app..."
	@cd app/lego_app && flutter run

# Build the Android APK
build-apk:
	@echo "Building Android APK..."
	@cd app/lego_app && flutter build apk

# Build the iOS App
build-ios:
	@echo "Building iOS App..."
	@cd app/lego_app && flutter build ios --no-codesign

# Run code generation for all packages that require it
generate:
	@echo "Running build_runner across the project..."
	@find . -name "pubspec.yaml" -execdir sh -c 'if grep -q "build_runner" pubspec.yaml; then dart run build_runner build --delete-conflicting-outputs; fi' \;

# Helper command to get dependencies for all packages
pub-get:
	@echo "Fetching dependencies for all packages..."
	@find . -name "pubspec.yaml" -execdir flutter pub get \;
