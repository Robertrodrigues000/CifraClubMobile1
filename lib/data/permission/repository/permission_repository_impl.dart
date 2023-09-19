import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;

class PermissionRepositoryImpl implements PermissionRepository {
  final OsVersion _osVersion;

  PermissionRepositoryImpl(this._osVersion);

  @override
  Future<permission_handler.PermissionStatus> requestPermission(PermissionType permission) async {
    switch (permission) {
      case PermissionType.audio:
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          return permission_handler.Permission.mediaLibrary.request();
        }

        final deviceInfo = defaultTargetPlatform == TargetPlatform.android ? _osVersion as AndroidOsSdkVersion : null;

        // coverage:ignore-start
        if (deviceInfo == null) {
          logger?.sendNonFatalCrash(exception: "BadPlatform");
          throw Exception("BadPlatform");
        }
        // coverage:ignore-end

        if (deviceInfo < const AndroidOsSdkVersion.sdk33()) {
          return permission_handler.Permission.storage.request();
        } else {
          return permission_handler.Permission.audio.request();
        }
    }
  }

  @override
  Future<bool> openAppSettings() {
    return permission_handler.openAppSettings();
  }
}

enum PermissionType { audio }
