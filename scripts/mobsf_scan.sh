#!/bin/bash

# Configuration
MOBSF_URL=${MOBSF_URL:-"http://localhost:8000"}
MOBSF_CONTAINER="mobsf"
MOBSF_REPORT_SAVE_DIR="mobsf_reports"

# Initialize
mkdir -p "$MOBSF_REPORT_SAVE_DIR"

# Retrieve API Key from MobSF Container (if running)
retrieve_api_key() {
  echo "Attempting to retrieve API key directly from the MobSF container..."
  # MobSF stores the API key in the config.py file or it's generated at startup.
  # For Docker, it's often easiest to check the generated secret file.
  API_KEY=$(docker exec "$MOBSF_CONTAINER" cat /home/mobsf/.MobSF/config.py | grep "API_KEY =" | cut -d '"' -f 2)
  if [ -z "$API_KEY" ]; then
    echo "Error: Could not retrieve API key. Is the MobSF container running?"
    exit 1
  fi
  echo "Retrieved API key successfully."
  export MOBSF_API_KEY="$API_KEY"
}

# Upload and Scan
scan_file() {
  local FILE_PATH=$1
  if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File not found at $FILE_PATH"
    return 1
  fi

  echo "Uploading and scanning $FILE_PATH..."
  RESPONSE=$(curl -s -F 'file=@'$FILE_PATH -H "Authorization: $MOBSF_API_KEY" "$MOBSF_URL/api/v1/upload")
  
  # Check for error in upload
  ERROR=$(echo "$RESPONSE" | jq -r '.error // empty')
  if [ -n "$ERROR" ]; then
    echo "Error uploading to MobSF: $ERROR"
    return 1
  fi

  HASH=$(echo "$RESPONSE" | jq -r '.hash')
  FILE_NAME=$(echo "$RESPONSE" | jq -r '.file_name')
  
  echo "File uploaded successfully. Hash: $HASH"
  echo "Starting analysis for $FILE_NAME..."
  
  SCAN_RESPONSE=$(curl -s -X POST -d "hash=$HASH" -H "Authorization: $MOBSF_API_KEY" "$MOBSF_URL/api/v1/scan")
  
  # Check for error in scan
  ERROR=$(echo "$SCAN_RESPONSE" | jq -r '.error // empty')
  if [ -n "$ERROR" ]; then
    echo "Error initiating MobSF scan: $ERROR"
    return 1
  fi

  STATUS=$(echo "$SCAN_RESPONSE" | jq -r '.status')
  echo "Scan status: $STATUS"
  echo "--------------------------------------------------------"
  echo "Static Analysis Report: $MOBSF_URL/static_analyzer/$HASH"
  echo "--------------------------------------------------------"
  
  # Optionally download PDF report (if MobSF version supports it)
  # echo "Attempting to download PDF report..."
  # curl -s -X POST -d "hash=$HASH" -H "Authorization: $MOBSF_API_KEY" "$MOBSF_URL/api/v1/download_pdf" > "$MOBSF_REPORT_SAVE_DIR/${FILE_NAME}_report.pdf"
}

# Main Execution
if [ -z "$MOBSF_API_KEY" ]; then
  retrieve_api_key
fi

# Determine what to scan
INPUT_ARG=${1:-"android"}

if [ -f "$INPUT_ARG" ]; then
  # It's a direct file path
  scan_file "$INPUT_ARG"
elif [ "$INPUT_ARG" == "android" ]; then
  APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
  if [ ! -f "$APK_PATH" ]; then
    echo "Release APK not found at $APK_PATH. Build it first using 'make apk'."
    exit 1
  fi
  scan_file "$APK_PATH"
elif [ "$INPUT_ARG" == "ios" ]; then
  # iOS usually requires .ipa or .zip of app bundle for static analysis
  IPA_PATH=$(find build/ios -name "*.ipa" | head -n 1)
  if [ -z "$IPA_PATH" ] || [ ! -f "$IPA_PATH" ]; then
     echo "Release IPA not found. Build it first using 'make ios'."
     exit 1
  fi
  scan_file "$IPA_PATH"
else
  echo "Error: '$INPUT_ARG' is not a valid file path or supported platform (android|ios)."
  exit 1
fi
