#!/bin/sh

export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export LANGUAGE=fr_FR.UTF-8
echo "Cleaning everything related to Android..."
cd ..
flutter clean
rm -rf ~/.gradle/caches
cd android
./gradlew clean
flutter pub get
echo "Done"
