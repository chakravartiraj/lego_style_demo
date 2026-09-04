---
description: Toggle between online and offline mode in Android emulator using adb
---

# Toggle Network Mode in Android Emulator

Toggle WiFi and Mobile Data on/off together for testing network-related functionality.

## Prerequisites
- Android emulator must be running
- ADB must be installed and in PATH

## Quick Toggle Commands

### Check WiFi Status
// turbo
```bash
adb shell dumpsys wifi | grep "Wi-Fi is"
```

### Go Offline (Disable WiFi + Data)
// turbo
```bash
adb shell svc wifi disable && adb shell svc data disable
```

### Go Online (Enable WiFi + Data)
// turbo
```bash
adb shell svc wifi enable && adb shell svc data enable
```

## Quick Reference

| Action | Command |
|--------|---------|
| Go offline | `adb shell svc wifi disable && adb shell svc data disable` |
| Go online | `adb shell svc wifi enable && adb shell svc data enable` |
| WiFi only off | `adb shell svc wifi disable` |
| WiFi only on | `adb shell svc wifi enable` |
| Data only off | `adb shell svc data disable` |
| Data only on | `adb shell svc data enable` |

## Notes
- Changes take effect immediately on the emulator
- For physical devices, root access may be required
