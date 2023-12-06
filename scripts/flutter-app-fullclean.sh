#!/bin/bash

_ROOT=$(realpath $(dirname $0)/../$1)

if [ -d $_ROOT ]; then
  pushd . >/dev/null
  cd $_ROOT
  flutter clean
  echo -n "Cleaning other auto-gen files under android/ and ios/..."
  rm -rf $_ROOT/.idea/
  rm -rf $_ROOT/android/.gradle/
  rm -rf $_ROOT/android/app/bin
  rm -f $_ROOT/android/gradlew*
  rm -f $_ROOT/android/gradle/wrapper/gradle-wrapper.jar
  rm -f $_ROOT/android/local.properties
  rm -f $_ROOT/android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java
  rm -f $_ROOT/ios/Runner/GeneratedPluginRegistrant.*
  rm -f $_ROOT/ios/Flutter/Generated.xcconfig
  rm -f $_ROOT/ios/Flutter/flutter_export_environment.sh
  echo " DONE"
  popd >/dev/null
fi
_ROOT=
