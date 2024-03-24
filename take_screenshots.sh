#!/bin/bash

function drive() {
  flutter drive \
    --driver test_driver/integration_test.dart \
    --target integration_test/take_screenshots.dart \
    --dart-define SCREENSHOT_MODE=true \
    --dart-define SCREENSHOT_NAME_BASE=$1
}

function start_android_emu() {
  device_name=$1
  ~/Library/Android/sdk/emulator/emulator @"$device_name" -netdelay none -netspeed full &
  adb wait-for-device
}

function stop_android_emu() {
  kill %%
  sleep 3
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
    drive "$2"
    stop_ios_simu "$device_udid"
}

exec_ios "iPhone 15 Pro Max" "screenshots/ios/iphone-6.7in"
exec_ios "iPhone 8 Plus" "screenshots/ios/iphone-5.5in"
exec_ios "iPad Pro (12.9-inch) (6th generation)" "screenshots/ios/ipad-12.9in-gen6"
exec_ios "iPad Pro (12.9-inch) (2nd generation)" "screenshots/ios/ipad-12.9in-gen2"
