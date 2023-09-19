import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRepository {
  Future<PermissionStatus> requestPermission(PermissionType permission);
  Future<bool> openAppSettings();
}
