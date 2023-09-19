// coverage:ignore-file
import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class PermissionModule {
  PermissionRepository getPermissionRepository(OsVersion osVersion) {
    return PermissionRepositoryImpl(osVersion);
  }
}
