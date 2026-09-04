.PHONY: run build-apk build-ios generate pub-get

# Device ID for iPhone Simulator
IOS_DEVICE_ID = $(shell flutter devices | grep -i "ios" | head -n 1 | awk -F '•' '{print $$2}' | tr -d ' ')

# Add Homebrew, rbenv, and Dart pub-cache to PATH so global packages like cider and pod are recognized
export PATH := /opt/homebrew/bin:$(HOME)/.rbenv/shims:$(PATH):$(HOME)/.pub-cache/bin

# Helper macro for Flag resolution (Interactive/Manual)
define RESOLVE_FLAGS
	@if [ -z "$(ENVIRONMENT)" ]; then \
		read -p "Enter ENVIRONMENT (DEV/UAT/PROD, default DEV): " val; \
		env=$${val:-DEV}; \
	else \
		env=$(ENVIRONMENT); \
	fi; \
	if [ "$$env" = "UAT" ]; then defaultBypass=true; else defaultBypass=true; fi; \
	if [ -z "$(IS_BYPASS_ACTIVE)" ]; then \
		read -p "Enter IS_BYPASS_ACTIVE (true/false, default $$defaultBypass): " bval; \
		isBypassActive=$${bval:-$$defaultBypass}; \
	else \
		isBypassActive=$(IS_BYPASS_ACTIVE); \
	fi; \
	if [ -z "$(BUMP_VERSION)" ]; then \
		read -p "Bump app version? (true/false, default false): " bumpVal; \
		bumpVersion=$${bumpVal:-false}; \
	else \
		bumpVersion=$(BUMP_VERSION); \
	fi
endef

#	Activate cider globally via `dart pub global activate cider`
#	cider bump <subcommand>
#	Available subcommands:
#   breaking   Bump the breaking version
#   build      Bump the build version
#   major      Bump the major version
#   minor      Bump the minor version
#   patch      Bump the patch version
#   pre        Bump the pre-release version
#   release    Bump the release version

# Bump the app build number	
.PHONY: bump-app-build
bump-app-build:
	-dart pub global activate cider || true
	-echo "Bumping the app version and build number..."; \
	cider bump build || true

# Bump the app version and build number	
# Usage: make bump-app-version [BUMP_TYPE=major|minor|patch] (default is patch)
BUMP_TYPE ?= patch
.PHONY: bump-app-version
bump-app-version:
	-dart pub global activate cider || true
	-echo "Bumping the app $(BUMP_TYPE) version and build number..."; \
	cider bump $(BUMP_TYPE) --bump-build || true

# Run the Flutter application
.PHONY: run
run:
	@echo "Running the app..."
	@cd app/lego_app && flutter run

# Build the Android APK
.PHONY: build-apk
build-apk:
	@echo "Building Android APK..."
	@cd app/lego_app && flutter build apk

# Build Release APK (Split per ABI - Faster and smaller)
.PHONY: split-apk
split-apk:
	$(RESOLVE_FLAGS); \
	echo "Building Release APK (Split) with ENVIRONMENT=$$env and IS_BYPASS_ACTIVE=$$isBypassActive..."; \
	if [ "$$bumpVersion" = "true" ]; then $(MAKE) bump-app-version; fi; \
	cd app/lego_app && flutter build apk --release --split-per-abi --obfuscate --split-debug-info=build/app/outputs/symbols --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive

# Build Android App Bundle (AAB) - Production Release (Bumps Patch & Build)
.PHONY: aab-release
aab-release:
	$(RESOLVE_FLAGS); \
	echo "Building Android App Bundle (AAB) [RELEASE] with ENVIRONMENT=$$env and IS_BYPASS_ACTIVE=$$isBypassActive..."; \
	if [ "$$bumpVersion" = "true" ]; then $(MAKE) bump-app-version; fi; \
	cd app/lego_app && flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive

# Build iOS IPA - Production Release (Bumps Patch & Build)
.PHONY: ipa
ipa:
	$(RESOLVE_FLAGS); \
	echo "Building iOS IPA [RELEASE] with ENVIRONMENT=$$env and IS_BYPASS_ACTIVE=$$isBypassActive..."; \
	cd app/lego_app && flutter build ipa --release --obfuscate --split-debug-info=build/app/outputs/symbols --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive

# Build iOS IPA Adhoc (using Fastlane)
.PHONY: ipa-adhoc
ipa-adhoc:
	$(RESOLVE_FLAGS); \
	echo "Building iOS IPA Adhoc with ENVIRONMENT=$$env and IS_BYPASS_ACTIVE=$$isBypassActive..."; \
	export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && eval "$$(rbenv init -)" && source fastlane/app_store_config.sh && bundle exec fastlane ios adhoc udid:00008030-001A09320E79402E name:"Sirisha's iPhone12" app_id:com.hmwssb.tankerservice environment:$$env is_bypass:$$isBypassActive
# 	flutter clean && flutter build ipa --release --obfuscate --split-debug-info=build/app/outputs/symbols --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive

# Prime Xcode environment for Manual Archiving (Option 2)
# Usage: make ios-xcode-config [ENVIRONMENT=UAT IS_BYPASS_ACTIVE=true]
.PHONY: ios-xcode-config
ios-xcode-config:
	$(RESOLVE_FLAGS); \
	echo "Configuring Xcode workspace for ENVIRONMENT=$$env and IS_BYPASS_ACTIVE=$$isBypassActive..."; \
	export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && cd app/lego_app && flutter build ios --config-only --release --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive; \
	echo "Opening Xcode workspace..."; \
	open ios/Runner.xcworkspace

# Build the iOS App
.PHONY: build-ios
build-ios:
	@echo "Building iOS App..."
	@cd app/lego_app && flutter build ios --no-codesign

# Helper macro for Web Environment resolution
define RESOLVE_WEB_ENV
	@if [ -z "$(ENV)" ]; then \
		read -p "Enter Target Environment (DEV/UAT/PROD, default DEV): " val; \
		env=$${val:-DEV}; \
	else \
		env=$(ENV); \
	fi; \
	if [ "$$env" = "UAT" ]; then \
		isBypassActive=true; \
	else \
		isBypassActive=true; \
	fi
endef

# Build Flutter Web Release
# Usage: make web ENV=DEV (or UAT, PROD)
.PHONY: web
web:
	$(RESOLVE_WEB_ENV); \
	echo "Building Flutter Web Release for $$env (ENVIRONMENT=$$env, IS_BYPASS_ACTIVE=$$isBypassActive)..."; \
	cd app/lego_app && flutter build web --base-href "/flutter/" --release --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive
	
# Run dependency vulnerability audit
.PHONY: audit
audit:
	flutter pub global activate dep_audit
	dart pub global run dep_audit
	
# Run in Web
.PHONY: run-web
run-web:
	$(RESOLVE_WEB_ENV); \
	echo "Running Flutter Web for $$env (ENVIRONMENT=$$env, IS_BYPASS_ACTIVE=$$isBypassActive)..."; \
	cd app/lego_app && flutter run -d chrome --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive --web-browser-flag "--disable-web-security"

# Stop Web
.PHONY: stop-web
stop-web:
	pkill -f "flutter run -d chrome" || true

# Run code generation for all packages that require it
.PHONY: generate
generate:
	@echo "Running build_runner across the project..."
	@find . -name "pubspec.yaml" -execdir sh -c 'if grep -q "build_runner" pubspec.yaml; then dart run build_runner build --delete-conflicting-outputs; fi' \;

# Helper command to get dependencies for all packages
.PHONY: pub-get
pub-get:
	@echo "Fetching dependencies for all packages..."
	@find . -name "pubspec.yaml" -execdir flutter pub get \;

# Start default Android emulator (Pixel_8_API_35) in the background and wait for boot completion
.PHONY: emulator-up
emulator-up:
	@echo "Starting Android Emulator (Pixel_8_API_35) in background..."
	@~/Library/Android/sdk/emulator/emulator -avd Pixel_8_API_35 > /dev/null 2>&1 &
	@echo "Waiting for device to connect..."
	@adb wait-for-device
	@echo "Waiting for Android system boot completion..."
	@adb shell 'while [ "$$(getprop sys.boot_completed)" != "1" ]; do sleep 1; done'
	@echo "Emulator is fully booted and ready!"

# Run in Android Emulator
# Usage (Interactive): make run-emulator
# Usage (Automation): make run-emulator ENVIRONMENT=DEV IS_BYPASS_ACTIVE=true
.PHONY: run-emulator
run-emulator:
	$(RESOLVE_FLAGS); \
	echo "Running Android Emulator with ENVIRONMENT=$$env and IS_BYPASS_ACTIVE=$$isBypassActive..."; \
	cd app/lego_app && flutter run -d emulator-5554 --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive --vmservice-out-file=vm_service.url

# Run in iOS Simulator
# Usage (Interactive): make run-ios
# Usage (Automation): make run-ios ENVIRONMENT=DEV
.PHONY: run-ios
run-ios:
	$(RESOLVE_FLAGS); \
	echo "Running iOS Simulator with ENVIRONMENT=$$env and IS_BYPASS_ACTIVE=$$isBypassActive..."; \
	clear && cd app/lego_app && flutter run -d $(IOS_DEVICE_ID) --dart-define=ENVIRONMENT=$$env --dart-define=IS_BYPASS_ACTIVE=$$isBypassActive --vmservice-out-file=vm_service.url

# Reset iOS Simulators (Shutdown and Erase)
.PHONY: reset-ios
reset-ios:
	@echo "Shutting down and erasing all iOS simulators..."
	xcrun simctl shutdown all
	xcrun simctl erase all
	@echo "Reset complete."

# Clean
.PHONY: clean
clean:
	flutter clean

# Deep clean (Flutter clean + Android/iOS/Pub caches + Disk space)
.PHONY: deep-clean
deep-clean:
	@echo "Deep cleaning project and clearing caches..."
	cd android && ./gradlew --stop || true
	flutter clean
	rm -rf ios/Pods ios/Podfile.lock
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
	rm -rf ~/.gradle/caches/ ~/.pub-cache/
	xcrun simctl delete unavailable || true
	flutter pub get
	@echo "Deep clean completed successfully."

# Check Available Disk Space
.PHONY: check-space
check-space:
	@echo "Checking available disk space..."
ifeq ($(OS),Windows_NT)
	powershell -Command "Get-Volume | Format-Table DriveLetter, FileSystemLabel, @{Name='Size(GB)';Expression={[math]::Round(\$$_.Size/1GB, 2)}}, @{Name='Free(GB)';Expression={[math]::Round(\$$_.SizeRemaining/1GB, 2)}} -AutoSize"
else
	df -h
endif

# --- Environment Setup ---

# Setup Linux Environment for Flutter and Android SDK
# Usage: make setup-linux
.PHONY: setup-linux
setup-linux:
	@echo "Running Linux setup script..."
	@chmod +x scripts/setup_linux_env.sh
	@./scripts/setup_linux_env.sh

# Setup Mac Environment for Flutter and Android SDK
# Usage: make setup-mac
.PHONY: setup-mac
setup-mac:
	@echo "Running Mac setup script..."
	@chmod +x scripts/setup_mac_env.sh
	@./scripts/setup_mac_env.sh

# --- Code Audit & Search ---
# Usage: make search Q=inChargeBookingDetails
.PHONY: search
search:
	@if [ -z "$(Q)" ]; then \
		echo "Usage: make search Q=your_pattern"; \
		exit 1; \
	fi; \
	echo "Searching for '$(Q)' in lib/ ..."; \
	grep -rn "$(Q)" lib

# --- Git Helpers ---

# List all local and remote branches
.PHONY: git-branches
git-branches:
	@git branch -a

# Switch to a branch (Interactive/Automation)
# Usage: make git-switch [BRANCH=branch_name]
.PHONY: git-switch
git-switch:
	@if [ -z "$(BRANCH)" ]; then \
		read -p "Enter branch name to switch to: " branch; \
	else \
		branch=$(BRANCH); \
	fi; \
	git checkout $$branch && git pull

# Create a new branch (Interactive/Automation)
# Usage: make git-new [BRANCH=new_branch_name]
.PHONY: git-new
git-new:
	@if [ -z "$(BRANCH)" ]; then \
		read -p "Enter new branch name: " branch; \
	else \
		branch=$(BRANCH); \
	fi; \
	git checkout -b $$branch

# Delete a branch (Interactive/Automation)
# Usage: make git-delete [BRANCH=branch_name]
.PHONY: git-delete
git-delete:
	@if [ -z "$(BRANCH)" ]; then \
		read -p "Enter branch name to delete: " branch; \
	else \
		branch=$(BRANCH); \
	fi; \
	git branch -d $$branch

# Cherry-pick a commit (Interactive/Automation)
# Usage: make git-cherry [HASH=commit_hash]
.PHONY: git-cherry
git-cherry:
	@if [ -z "$(HASH)" ]; then \
		read -p "Enter commit hash to cherry-pick: " hash; \
	else \
		hash=$(HASH); \
	fi; \
	git cherry-pick $$hash

# Check git status
.PHONY: git-status
git-status:
	@git status

# Git blame (Interactive/Automation)
# Usage: make git-blame [FILE=path/to/file]
.PHONY: git-blame
git-blame:
	@if [ -z "$(FILE)" ]; then \
		read -p "Enter file path for git blame: " file; \
	else \
		file=$(FILE); \
	fi; \
	git blame $$file

# --- Archive ---

# Helper macro for Archive Git History resolution (Interactive/Manual)
define RESOLVE_ARCHIVE_GIT
	@if [ -z "$(WITH_GIT)" ]; then \
		read -p "Include Git history (.git folder)? (true/false, default false): " gval; \
		withGit=$${gval:-false}; \
	else \
		withGit=$(WITH_GIT); \
	fi
endef

# Create a clean compression of the source code (essential files only)
# Usage (Interactive): make archive
# Usage (Automation): make archive WITH_GIT=true
.PHONY: archive
archive:
	$(RESOLVE_ARCHIVE_GIT); \
	echo "Creating clean source code archive..."; \
	mkdir -p out; \
	git archive --format=zip HEAD android assets fastlane ios lib web .gitignore .metadata .ruby-version Gemfile Makefile README.md analysis_options.yaml flutter_launcher_icons.yaml flutter_native_splash.yaml pubspec.yaml -o out/lego_style_demo.zip; \
	for envfile in .env.dev .env.uat .env.prod .env.prod .env.test Gemfile.lock pubspec.lock; do \
		if [ -f "$$envfile" ]; then \
			zip -ur out/lego_style_demo.zip "$$envfile" > /dev/null 2>&1; \
		fi; \
	done; \
	if [ "$$withGit" = "true" ]; then \
		echo "Appending Git history (.git folder) to archive..."; \
		zip -ur out/lego_style_demo.zip .git > /dev/null 2>&1; \
	fi; \
	echo "Archive created at out/hmwssb_tankerservice_source.zip"

# --- Testing & Coverage ---

# Run all tests with coverage and generate HTML report
# Usage: make coverage-report
.PHONY: coverage-report
coverage-report:
	@echo "Running tests with coverage..."
	@flutter test --coverage
	@echo "Generating HTML coverage report..."
	@genhtml coverage/lcov.info -o coverage/html
	@echo "Coverage report generated at coverage/html/index.html"

# Open generated coverage report in Chrome
# Usage: make open-coverage
.PHONY: open-coverage
open-coverage:
	@echo "Opening coverage report in Google Chrome..."
	@open -a "Google Chrome" coverage/html/index.html

# Extract overall coverage summary from lcov.info
# Usage: make coverage-summary
.PHONY: coverage-summary
coverage-summary:
	@echo "Extracting overall coverage summary..."
	@lcov --summary coverage/lcov.info

# Search coverage for a specific module/directory
# Usage: make coverage-check Q=manager/repositories
.PHONY: coverage-check
coverage-check:
	@if [ -z "$(Q)" ]; then \
		echo "Usage: make coverage-check Q=your_directory_or_file"; \
		exit 1; \
	fi; \
	echo "Checking coverage for '$(Q)'..."; \
	lcov --list coverage/lcov.info | grep -A 2 -i "$(Q)"

# Run tests and output summary
# Usage: make test-and-summary
.PHONY: test-and-summary
test-and-summary:
	@flutter test --coverage
	@$(MAKE) coverage-summary

# Run tests and save output to unit_test_report.txt
# Usage: make test-report
.PHONY: test-report
test-report:
	@echo "Running tests and saving output to unit_test_report.txt..."
	@flutter test > unit_test_report.txt
	@echo "Test report generated at unit_test_report.txt"

# Run static analysis (enforcing strict pedantic rules)
# Usage: make lint
.PHONY: lint
lint:
	@echo "Running flutter analyze..."
	@cd app/lego_app && flutter analyze
	@echo "Linting passed successfully!"