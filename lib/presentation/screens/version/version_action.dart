import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/section.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';

typedef ActionEmitter = Function(VersionAction);

sealed class VersionAction {}

class OnVersionInit implements VersionAction {
  final String? artistName;
  final String? songName;
  final String? artistUrl;
  final String? songUrl;
  final int? songbookVersionId;

  OnVersionInit({this.artistName, this.songName, this.artistUrl, this.songUrl, this.songbookVersionId});
}

class OnVersionSelected implements VersionAction {
  final VersionFilter filter;

  const OnVersionSelected(this.filter);
}

class OnStartLoading implements VersionAction {}

class OnVersionLoaded implements VersionAction {
  final VersionData versionData;

  const OnVersionLoaded(this.versionData);
}

class OnVersionLoadError implements VersionAction {
  final RequestError error;

  const OnVersionLoadError({required this.error});
}

class OnContentParsed implements VersionAction {
  final List<Section> sections;
  final VersionData versionData;
  final List<VersionFilter> versionFilters;
  final VersionFilter selectedFilter;

  OnContentParsed(
      {required this.sections, required this.versionData, required this.versionFilters, required this.selectedFilter});
}

class OnYouTubeVideoSelected implements VersionAction {
  final String videoId;

  OnYouTubeVideoSelected(this.videoId);
}

class OnYouTubeVideoClosed implements VersionAction {}

class OnToggleIsChordPinned implements VersionAction {}
