import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';

sealed class VersionError {}

class VersionLoadError implements VersionError {
  final RequestError error;

  VersionLoadError(this.error);
}

sealed class VersionContentError implements VersionError {}

class VersionUnauthorizedError implements VersionContentError {
  final VersionData version;

  VersionUnauthorizedError({required this.version});
}

class VersionEmptyError implements VersionContentError {}
