import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/songbook/models/email_options_result.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
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

class OnShowVideoLessonVersionDialog implements VersionEffect {}

class OnShowListenBottomSheetEffect implements VersionEffect {}

class OnShowOptionsBottomSheetEffect implements VersionEffect {}

class OnShowChordShapeBottomSheetEffect implements VersionEffect {
  final List<ChordRepresentation> chords;
  final Instrument instrument;
  final ChordRepresentation selectedChord;

  OnShowChordShapeBottomSheetEffect({required this.chords, required this.instrument, required this.selectedChord});
}

class OnFavoriteError implements VersionEffect {
  final VersionOptionsResult haveError;

  OnFavoriteError({required this.haveError});
}

class OnShowTuningBottomSheetEffect implements VersionEffect {}

class OnShowCapoBottomSheetEffect implements VersionEffect {}

class OnShowSelectVersionBottomSheetEffect implements VersionEffect {}

class OnChangeVersionKeyEffect implements VersionEffect {
  final String newKey;

  OnChangeVersionKeyEffect(this.newKey);
}

class OnShowFontSizeFooterBarEffect implements VersionEffect {}

class OnReadyToProcessContentEffect implements VersionEffect {}

class OnEmailValidateEffect implements VersionEffect {
  final EmailOptionsResult result;

  OnEmailValidateEffect({required this.result});
}
