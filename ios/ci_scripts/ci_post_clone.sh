#!/bin/sh

# Copiado do https://docs.flutter.dev/deployment/cd#post-clone-script

# The default execution directory of this script is the ci_scripts directory.
cd $CI_WORKSPACE # change working directory to the root of your cloned repo.

# Install Flutter using git.
git clone https://github.com/flutter/flutter.git --depth 1 -b 3.10.5 $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

# Install CocoaPods dependencies.
# cd ios && pod install # run `pod install` in the `ios` directory.

# Workaround Flutter 3.10 - https://stackoverflow.com/a/76349926
cd ios && pod deintegrate && pod update 

# Generate "what to test" text.
git fetch --unshallow
mkdir TestFlight
cd ci_scripts
./get_commit_messages.sh "$(date -v-7d '+%Y-%m-%d %H:%M:%S')" ../TestFlight/WhatToTest.en-US.txt

exit 0
