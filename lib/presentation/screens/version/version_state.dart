import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/section.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/foundation.dart';

part 'version_state.g.dart';

@CopyWith()
@immutable
class VersionState {
  final VersionData? version;
  final bool isLoading;
  final RequestError? error;
  final List<Section> sections;

  final bool isChordListPinned;

  /*
  

   - lista de sections
   - fontSize

   - chordsState
    - lista de acordes
    - selectedChord
    - isChordListPinned

   - isAutoScrolling
   - scrollSpeed (salvar no banco junto com versionData)

   - isFavorite
   - isPro
   - isTablatureEnabled
   
   - songbookState
    - songbookId?
    - songbookVersionId
    - sortType

   - video
    - isPlayingVideo
    - videoUrl

  */

  const VersionState({
    this.version,
    this.isLoading = false,
    this.error,
    this.sections = const [],
    this.isChordListPinned = false,
  });
}
