#!/bin/sh

export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export LANGUAGE=fr_FR.UTF-8
echo "Cleaning everything related to IOS..."
pod repo update
flutter clean
cd ../ios
pod deintegrate
rm -rf .symlinks
rm -rf Pods
rm Podfile.lock
rm ../pubspec.lock
flutter pub get
pod install
echo "Done"
