import 'package:cifraclub/domain/shared/request_error.dart';

sealed class VersionError {}

class VersionLoadError implements VersionError {
  final RequestError error;

  VersionLoadError(this.error);
}

sealed class VersionContentError implements VersionError {}

class VersionUnauthorizedError implements VersionContentError {}

class VersionEmptyError implements VersionContentError {}
