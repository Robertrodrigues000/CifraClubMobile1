import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/songbook/models/email_options_result.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/models/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_reducer.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

import '../../../shared_mocks/domain/chord/chord_representation_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';

void main() {
  test("When action is OnVersionInit", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      const VersionState(),
      OnVersionInit(
        artistName: "Michel",
        songName: "Se eu",
      ),
      (_) => null,
    );

    expect(state.versionHeaderState.artistName, "Michel");
    expect(state.versionHeaderState.songName, "Se eu");
    expect(state.versionHeaderState.selectedInstrument, Instrument.guitar);
  });

  test("When action is OnStartLoading", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      const VersionState(),
      OnStartLoading(),
      (_) => null,
    );

    expect(state.isLoading, isTrue);
    expect(state.version, isNull);
  });

  test("When action is OnVersionSelected", () {
    final reducer = VersionReducer();
    const filter = VersionFilter(
      instrument: Instrument.bass,
      versionName: "Aquela",
      versionUrl: "aaa",
      isVerified: true,
    );

    final state = reducer.reduce(
      const VersionState(),
      const OnVersionSelected(filter),
      (_) => null,
    );

    expect(state.versionHeaderState.selectedVersionFilter, filter);
  });

  test("When action is OnContentParsed", () {
    final reducer = VersionReducer();

    const filter = VersionFilter(
      instrument: Instrument.bass,
      versionName: "Aquela",
      versionUrl: "aaa",
      isVerified: true,
    );

    final sections = [TextSection("")];
    final versionData = getFakeVersionData();
    final versionFilters = [filter];

    final state = reducer.reduce(
      const VersionState(),
      OnContentParsed(
        sections: sections,
        versionData: versionData,
        versionFilters: versionFilters,
        selectedFilter: filter,
      ),
      (_) => null,
    );

    expect(state.sections, sections);
    expect(state.isLoading, false);
    expect(state.version, versionData);
    expect(state.versionHeaderState.versionFilters, versionFilters);
    expect(state.versionHeaderState.selectedVersionFilter, filter);
  });

  test("When action is OnReadyToProcessContent", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    final sections = [TextSection("")];
    const fontSize = 14;
    const isFontIncreaseEnabled = true;
    const isFontDecreaseEnabled = true;

    expectLater(effectStream.stream, emitsInOrder([isA<OnReadyToProcessContentEffect>()]));

    final state = reducer.reduce(
      const VersionState(),
      OnReadyToProcessContent(
        sections: sections,
        fontSize: fontSize,
        isFontIncreaseEnabled: isFontIncreaseEnabled,
        isFontDecreaseEnabled: isFontDecreaseEnabled,
      ),
      effectStream.add,
    );

    expect(state.filteredSections, sections);
    expect(state.fontSizeState.fontSize, 14);
    expect(state.fontSizeState.isDecreaseEnabled, true);
    expect(state.fontSizeState.isIncreaseEnabled, true);
    effectStream.close();
  });

  test("When action is OnContentProcessed", () {
    final reducer = VersionReducer();
    final sections = [TextSection("")];

    final state = reducer.reduce(
      const VersionState(),
      OnContentProcessed(
        sections: sections,
      ),
      (_) {},
    );

    expect(state.sections, sections);
  });

  test("When action is OnYoutubeVideoClosed", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(effectStream.stream, emitsInOrder([isA<OnCloseYouTubeVideo>()]));

    final state = reducer.reduce(
      const VersionState(),
      OnYouTubeVideoClosed(),
      effectStream.add,
    );
    expect(state.isYouTubeVisible, isFalse);

    effectStream.close();
  });

  test("When action is OnYoutubeVideoOpened", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();
    const videoId = "tesdas";

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnShowYouTubeVideo>().having((effect) => effect.videoId, "video id", videoId),
        ]));

    final state = reducer.reduce(
      const VersionState(),
      OnYouTubeVideoOpened(videoId),
      effectStream.add,
    );
    expect(state.isYouTubeVisible, isTrue);

    effectStream.close();
  });

  group("when action is OnYouTubeSelected", () {
    test("and version has not changed", () {
      final reducer = VersionReducer();
      final effectStream = PublishSubject<VersionEffect>();
      const videoId = "tesdas";

      expectLater(
          effectStream.stream,
          emitsInOrder([
            isA<OnShowYouTubeVideo>().having((effect) => effect.videoId, "video id", videoId),
          ]));

      final state = reducer.reduce(
        const VersionState(),
        OnYouTubeVideoSelected(videoId),
        effectStream.add,
      );
      expect(state.isYouTubeVisible, isTrue);
      expect(state.shouldShowChangeVersionDialog, isFalse);

      effectStream.close();
    });

    test("and version has changed", () {
      final reducer = VersionReducer();
      final effectStream = PublishSubject<VersionEffect>();
      const videoId = "tesdas";

      expectLater(
          effectStream.stream,
          emitsInOrder([
            isA<OnShowVideoLessonVersionDialog>(),
          ]));

      final state = reducer.reduce(
        const VersionState(localVersionSettings: LocalVersionSettings(instrument: Instrument.guitar, capo: Capo.capo1)),
        OnYouTubeVideoSelected(videoId),
        effectStream.add,
      );
      expect(state.isYouTubeVisible, isFalse);
      expect(state.shouldShowChangeVersionDialog, isFalse);

      effectStream.close();
    });

    test("and version has changed, but dialog was already shown", () {
      final reducer = VersionReducer();
      final effectStream = PublishSubject<VersionEffect>();
      const videoId = "tesdas";

      expectLater(
          effectStream.stream,
          emitsInOrder([
            isA<OnShowYouTubeVideo>().having((effect) => effect.videoId, "video id", videoId),
          ]));

      final state = reducer.reduce(
        const VersionState(
            shouldShowChangeVersionDialog: false,
            localVersionSettings: LocalVersionSettings(instrument: Instrument.guitar, capo: Capo.capo1)),
        OnYouTubeVideoSelected(videoId),
        effectStream.add,
      );
      expect(state.isYouTubeVisible, isTrue);
      expect(state.shouldShowChangeVersionDialog, isFalse);

      effectStream.close();
    });
  });

  test("When action is OnToggleIsChordPinned", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      const VersionState(isChordListPinned: true),
      OnToggleIsChordPinned(),
      (_) => null,
    );

    expect(state.isChordListPinned, isFalse);
  });

  test("When action is OnVersionLoaded", () {
    final reducer = VersionReducer();
    const versionState = VersionState();

    final state = reducer.reduce(
      versionState,
      OnVersionLoaded(getFakeVersionData()),
      (_) => null,
    );

    expect(state, versionState);
  });

  test("When action is OnFloatingFooterBarModeChange", () {
    final reducer = VersionReducer();
    const versionState = VersionState();

    expect(versionState.floatingFooterBarState.mode, FloatingFooterBarMode.main);
    final state = reducer.reduce(
      versionState,
      OnFloatingFooterBarModeChange(mode: FloatingFooterBarMode.autoscroll),
      (_) => null,
    );
    expect(state.floatingFooterBarState.mode, FloatingFooterBarMode.autoscroll);
  });

  test("When action is OnShowListenBottomSheet", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnShowListenBottomSheetEffect>(),
        ]));

    reducer.reduce(
      const VersionState(),
      OnShowListenBottomSheet(),
      effectStream.add,
    );

    effectStream.close();
  });

  test("When action is OnShowOptionsBottomSheet", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnShowOptionsBottomSheetEffect>(),
        ]));

    reducer.reduce(
      const VersionState(),
      OnShowOptionsBottomSheet(),
      effectStream.add,
    );

    effectStream.close();
  });

  test("When action is OnShowTuningBottomSheetEffect", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnShowTuningBottomSheetEffect>(),
        ]));

    reducer.reduce(
      const VersionState(),
      OnShowTuningBottomSheet(),
      effectStream.add,
    );

    effectStream.close();
  });

  test("When action is OnShowCapoBottomSheetEffect", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnShowCapoBottomSheetEffect>(),
        ]));

    reducer.reduce(
      const VersionState(),
      OnShowCapoBottomSheet(),
      effectStream.add,
    );

    effectStream.close();
  });

  test("When action is OnShowSelectVersionBottomSheetEffect", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnShowSelectVersionBottomSheetEffect>(),
        ]));

    reducer.reduce(
      const VersionState(),
      OnShowSelectVersionBottomSheet(),
      effectStream.add,
    );

    effectStream.close();
  });

  test("When action is OnChangeVersionKeyEffect", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnChangeVersionKeyEffect>().having((effect) => effect.newKey, "new key", "E"),
        ]));

    reducer.reduce(
      const VersionState(),
      OnChangeVersionKey("E"),
      effectStream.add,
    );

    effectStream.close();
  });

  test("When action is OnShowChordShapeBottomSheet", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnShowChordShapeBottomSheetEffect>(),
        ]));

    reducer.reduce(
      const VersionState(),
      OnShowChordShapeBottomSheet(
        instrument: Instrument.guitar,
        selectedChord: getFakeChordRepresentation(name: "A"),
        chords: [
          getFakeChordRepresentation(name: "A"),
          getFakeChordRepresentation(name: "A"),
        ],
      ),
      effectStream.add,
    );

    effectStream.close();
  });

  test("When action is OnFavoriteChange", () {
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
      effectStream.stream,
      emitsInOrder([
        isA<OnFavoriteError>().having((error) => error.haveError, "error", isA<FavoriteVersionError>()),
      ]),
    );

    final state = reducer.reduce(
      VersionState(version: getFakeVersionData()),
      OnFavoriteChange(isFavorite: true, haveError: FavoriteVersionError()),
      effectStream.add,
    );

    expect(state.versionHeaderState.isFavorite, true);
    effectStream.close();
  });

  test("When action is OnVersionError", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      VersionState(version: getFakeVersionData()),
      OnVersionError(error: VersionEmptyError()),
      (_) => null,
    );

    expect(state.version, null);
    expect(state.isLoading, isFalse);
  });

  test("When action is OnVersionError and error is Unauthorized", () {
    final reducer = VersionReducer();
    final version = getFakeVersionData();

    final state = reducer.reduce(
      VersionState(version: getFakeVersionData()),
      OnVersionError(error: VersionUnauthorizedError(version: version)),
      (_) => null,
    );

    expect(state.version, version);
    expect(state.isLoading, isFalse);
    expect(state.restrictContent, true);
  });

  test("When action is OnChangeEmail", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      const VersionState(isConflictError: true),
      OnChangeEmail(email: ""),
      (_) => null,
    );

    expect(state.isConflictError, isFalse);
  });

  test("When action is OnValidateEmail", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      const VersionState(isConflictError: true),
      OnValidateEmail(isValid: true),
      (_) => null,
    );

    expect(state.isValidEmail, isTrue);
  });

  group("When action is OnEmailValidate", () {
    final reducer = VersionReducer();
    test("and is SendEmailConflictError", () {
      final state = reducer.reduce(
        const VersionState(isConflictError: true),
        OnEmailValidate(result: SendEmailConflictError()),
        (_) => null,
      );

      expect(state.isConflictError, isTrue);
    });

    test("and is other status", () {
      final effectStream = PublishSubject<VersionEffect>();

      expectLater(
        effectStream.stream,
        emitsInOrder([
          isA<OnEmailValidateEffect>().having((effect) => effect.result, "email result", isA<SendEmailSuccess>()),
          isA<OnEmailValidateEffect>().having((effect) => effect.result, "email result", isA<SendEmailNetworkError>()),
          isA<OnEmailValidateEffect>().having((effect) => effect.result, "email result", isA<SendEmailError>()),
        ]),
      );

      reducer.reduce(
        const VersionState(isConflictError: true),
        OnEmailValidate(result: SendEmailSuccess()),
        effectStream.add,
      );

      reducer.reduce(
        const VersionState(isConflictError: true),
        OnEmailValidate(result: SendEmailNetworkError()),
        effectStream.add,
      );

      reducer.reduce(
        const VersionState(isConflictError: true),
        OnEmailValidate(result: SendEmailError()),
        effectStream.add,
      );

      effectStream.close();
    });
  });

  test("When action is OnChangeSelectedChord", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      const VersionState(),
      OnChangeSelectedChord(selectedChord: "Bm"),
      (_) => null,
    );

    expect(state.isChordListPinned, true);
    expect(state.chordState.selectedChord, "Bm");
  });

  test("When action is OnChangeSelectedChord", () {
    final reducer = VersionReducer();

    final state = reducer.reduce(
      const VersionState(),
      OnChangeSelectedChord(selectedChord: "Bm"),
      (_) => null,
    );

    expect(state.isChordListPinned, true);
    expect(state.chordState.selectedChord, "Bm");
  });

  test("When action is OnChangeTabsVisibility", () {
    final reducer = VersionReducer();

    var state = reducer.reduce(
      const VersionState(),
      OnChangeTabsVisibility(true),
      (_) => null,
    );

    expect(state.isTabsVisible, true);

    state = reducer.reduce(
      const VersionState(),
      OnChangeTabsVisibility(false),
      (_) => null,
    );

    expect(state.isTabsVisible, false);
  });

  test("When action is OnTabsVisibilityChanged", () {
    final reducer = VersionReducer();
    final filteredSections = [TextSection("section")];

    final state = reducer.reduce(
      const VersionState(),
      OnTabsVisibilityChanged(filteredSections),
      (_) => null,
    );

    expect(state.filteredSections, filteredSections);
  });

  test("When action is OnRestoreVersion", () {
    final versionData = getFakeVersionData(
        videoLesson: VersionDataVideoLesson(id: 1, youtubeId: "teste", title: "Video aula", thumb: ""));
    final reducer = VersionReducer();
    final effectStream = PublishSubject<VersionEffect>();

    expectLater(
      effectStream.stream,
      emitsInOrder([
        isA<OnShowYouTubeVideo>().having((effect) => effect.videoId, "video id", versionData.videoLesson!.youtubeId),
      ]),
    );

    final state = reducer.reduce(
      VersionState(version: versionData),
      OnRestoreVersion(),
      effectStream.add,
    );

    expect(state.localVersionSettings.instrument, versionData.instrument);
    expect(state.localVersionSettings.capo, versionData.capo);
    expect(state.localVersionSettings.tuning, versionData.tuning);
    expect(state.localVersionSettings.key, versionData.key);
    effectStream.close();
  });
}
