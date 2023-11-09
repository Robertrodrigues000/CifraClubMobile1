import 'package:cifraclub/domain/songbook/models/version_options_result.dart';

sealed class VersionEffect {}

class OnShowYouTubeVideo implements VersionEffect {
  final String videoId;

  const OnShowYouTubeVideo(this.videoId);
}

class OnCloseYouTubeVideo implements VersionEffect {}

class OnAutoScrollTickEffect implements VersionEffect {
  final double delta;

  OnAutoScrollTickEffect(this.delta);
}

class OnShowListenBottomSheetEffect implements VersionEffect {}

class OnShowOptionsBottomSheetEffect implements VersionEffect {}

class OnFavoriteError implements VersionEffect {
  final VersionOptionsResult haveError;

  OnFavoriteError({required this.haveError});
}
