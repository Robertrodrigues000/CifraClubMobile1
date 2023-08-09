#!/bin/sh
set -e
if [[ -n $CI_ARCHIVE_PATH ]];
then
    echo "Archive path is available. Let's run dSYMs uploading script"
    # Move up to parent directory
    cd ..
    # Debug
    echo "Archive path: $CI_ARCHIVE_PATH"
    # Crashlytics dSYMs script
    ./Pods/FirebaseCrashlytics/upload-symbols -gsp ./Runner/GoogleService-Info.plist -p ios $CI_ARCHIVE_PATH/dSYMs
else
    echo "Archive path isn't available. Unable to run dSYMs uploading script."
fi