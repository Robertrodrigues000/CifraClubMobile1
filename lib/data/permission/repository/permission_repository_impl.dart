import 'package:cifraclub/data/permission/models/app_permission_status.dart';
import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;

class PermissionRepositoryImpl implements PermissionRepository {
  final OsVersion _osVersion;

  PermissionRepositoryImpl(this._osVersion);

  @override
  Future<AppPermissionStatus> requestPermission(PermissionType permission) async {
    switch (permission) {
      case PermissionType.audio:
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          return (await permission_handler.Permission.mediaLibrary.request()).appPermissionStatus;
        }

        final deviceInfo = defaultTargetPlatform == TargetPlatform.android ? _osVersion as AndroidOsSdkVersion : null;

        // coverage:ignore-start
        if (deviceInfo == null) {
          logger?.sendNonFatalCrash(exception: "BadPlatform");
          throw Exception("BadPlatform");
        }
        // coverage:ignore-end

        if (deviceInfo < const AndroidOsSdkVersion.sdk33()) {
          return (await permission_handler.Permission.storage.request()).appPermissionStatus;
        } else {
          return (await permission_handler.Permission.audio.request()).appPermissionStatus;
        }
      case PermissionType.microphone:
        return (await permission_handler.Permission.microphone.request()).appPermissionStatus;
    }
  }

  @override
  Future<bool> openAppSettings() {
    return permission_handler.openAppSettings();
  }
}

enum PermissionType { audio, microphone }

// coverage:ignore-start
extension PermissionStatusExtension on permission_handler.PermissionStatus {
  AppPermissionStatus get appPermissionStatus {
    switch (this) {
      case permission_handler.PermissionStatus.granted:
        return AppPermissionStatus.granted;
      case permission_handler.PermissionStatus.denied:
        return AppPermissionStatus.denied;
      case permission_handler.PermissionStatus.permanentlyDenied:
        return AppPermissionStatus.permanentlyDenied;
      case permission_handler.PermissionStatus.limited:
        return AppPermissionStatus.limited;
      case permission_handler.PermissionStatus.provisional:
        return AppPermissionStatus.provisional;
      case permission_handler.PermissionStatus.restricted:
        return AppPermissionStatus.restricted;
      default:
        return AppPermissionStatus.unknown;
    }
  }
}
// coverage:ignore-end
