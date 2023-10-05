import 'package:cifraclub/data/permission/models/app_permission_status.dart';
import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';

abstract class PermissionRepository {
  Future<AppPermissionStatus> requestPermission(PermissionType permission);
  Future<bool> openAppSettings();
}
