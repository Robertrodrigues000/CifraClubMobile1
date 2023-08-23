import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/section.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_reducer.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
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

    final sections = [Section("")];
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
}
