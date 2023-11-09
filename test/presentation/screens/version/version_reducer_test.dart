import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_reducer.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

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

  test("When action is OnYoutubeClosed", () {
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

  test("When action is OnYouTubeVideoSelected", () {
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

    effectStream.close();
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
  });
}
