#!/bin/bash

function drive() {
  fvm flutter drive \
    --driver test_driver/integration_test.dart \
    --target integration_test/take_screenshots.dart \
    --dart-define SCREENSHOT_MODE=true \
    --dart-define SCREENSHOT_NAME_BASE=$1 \
    -d "$2"
}

function start_android_emu() {
  device_name=$1
  ~/Library/Android/sdk/emulator/emulator @"$device_name" -netdelay none -netspeed full &
  adb wait-for-device
}

function stop_android_emu() {
  kill %%
  sleep 5
}

function find_ios_simu_device() {
  echo `xcrun simctl list devices "$1" -j | jq -r '.devices | to_entries | map(.value) | flatten | .[length - 1].udid'`
}

function start_ios_simu() {
  device_udid=$1
  xcrun simctl boot "$device_udid"
  xcrun simctl bootstatus "$device_udid"
}

function stop_ios_simu() {
  device_udid=$1
  xcrun simctl shutdown "$device_udid"
}

function exec_ios() {
  device_udid=$(find_ios_simu_device "$1")
  echo "Device udid: $device_udid"
  start_ios_simu "$device_udid"
  drive "$2" "$1"
  stop_ios_simu "$device_udid"
}

function exec_android() {
  start_android_emu "$1"
  drive "$2" "emulator-5554"
  stop_android_emu
}

exec_ios "iPhone 16 Pro Max" "screenshots/ios/iphone-6.7in"
#exec_ios "iPhone 8 Plus" "screenshots/ios/iphone-5.5in"
exec_ios "iPad Pro 13-inch (M4)" "screenshots/ios/ipad-13in-m4"
#exec_ios "iPad Pro (12.9-inch) (2nd generation)" "screenshots/ios/ipad-12.9in-gen2"

#exec_android "Pixel_7" "screenshots/android/mobile"
#exec_android "7-inch_Tablet" "screenshots/android/tablet-7in"
#exec_android "10-inch_Tablet" "screenshots/android/tablet-10in"
