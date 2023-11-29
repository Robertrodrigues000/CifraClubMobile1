import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'version_options_bottom_sheet_state.g.dart';

@CopyWith()
class VersionOptionsBottomSheetState {
  final bool isLoggedIn;
  final bool isFavorite;
  final Instrument instrument;
  final String selectedVersion;
  final MusicalScale musicalScale;
  final String originalKey;
  final String selectedKey;
  final bool isBeatVisible;
  final bool isTabsVisible;
  final bool isLeftHanded;
  final String capo;
  final String tuning;
  final bool isPro;
  final bool isTunerInstalled;

  const VersionOptionsBottomSheetState({
    this.isLoggedIn = false,
    this.isFavorite = false,
    this.instrument = Instrument.guitar,
    this.selectedVersion = "",
    this.musicalScale = MusicalScale.majorScale,
    this.originalKey = "",
    this.selectedKey = "",
    this.isBeatVisible = true,
    this.isTabsVisible = true,
    this.isLeftHanded = false,
    this.capo = "",
    this.tuning = "",
    this.isPro = false,
    this.isTunerInstalled = false,
  });
}
