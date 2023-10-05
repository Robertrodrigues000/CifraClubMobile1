import 'package:cifraclub/data/permission/models/app_permission_status.dart';

sealed class SongSearchError {}

class SongPermissionError implements SongSearchError {
  final AppPermissionStatus permissionStatus;

  SongPermissionError(this.permissionStatus);
}

class SongFetchError implements SongSearchError {
  final String error;

  SongFetchError(this.error);
}
