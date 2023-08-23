import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_loader_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _GetVersionDataMock extends Mock implements GetVersionData {}

void main() {
  group("When action is OnVersionInit", () {
    test("when success should emit OnVersionLoaded action with versionData", () async {
      final versionData = getFakeVersionData();

      final getVersionData = _GetVersionDataMock();
      when(() => getVersionData(artistDns: any(named: "artistDns"), songDns: any(named: "songDns")))
          .thenAnswer((_) => SynchronousFuture(Ok(versionData)));

      final middleware = VersionLoaderMiddleware(getVersionData);
      var actionStream = PublishSubject<VersionAction>();

      expectLater(
        actionStream.stream,
        emitsInOrder([
          isA<OnStartLoading>(),
          isA<OnVersionLoaded>().having((e) => e.versionData, "versionData", versionData),
        ]),
      );

      middleware.onAction(OnVersionInit(artistUrl: "a", songUrl: "b"), const VersionState(), (action) {
        actionStream.add(action);
      });

      verify(() => getVersionData(artistDns: "a", songDns: "b")).called(1);
      actionStream.close();
    });

    test("when fails should emit OnVersionError action with serverError", () async {
      final error = ServerError(statusCode: 404);

      final getVersionData = _GetVersionDataMock();
      when(() => getVersionData(artistDns: any(named: "artistDns"), songDns: any(named: "songDns")))
          .thenAnswer((_) => SynchronousFuture(Err(error)));

      final middleware = VersionLoaderMiddleware(getVersionData);

      var actionStream = PublishSubject<VersionAction>();

      expectLater(
        actionStream.stream,
        emitsInOrder([
          isA<OnStartLoading>(),
          isA<OnVersionError>().having(
            (e) => e.error,
            "versionError",
            isA<VersionLoadError>().having((versionError) => versionError.error, "serverError", error),
          ),
        ]),
      );

      middleware.onAction(OnVersionInit(artistUrl: "a", songUrl: "b"), const VersionState(), (action) {
        actionStream.add(action);
      });

      verify(() => getVersionData(artistDns: "a", songDns: "b")).called(1);
      actionStream.close();
    });
  });

  group("When action is OnVersionSelected", () {
    test("when success should emit OnVersionLoaded action with versionData", () async {
      final versionData = getFakeVersionData();

      final getVersionData = _GetVersionDataMock();
      when(
        () => getVersionData.call(
            artistDns: any(named: "artistDns"),
            songDns: any(named: "songDns"),
            instrumentUrl: any(named: "instrumentUrl"),
            versionUrl: any(named: "versionUrl")),
      ).thenAnswer((_) => SynchronousFuture(Ok(versionData)));

      final middleware = VersionLoaderMiddleware(getVersionData);
      var actionStream = PublishSubject<VersionAction>();

      expectLater(
        actionStream.stream,
        emitsInOrder([
          isA<OnStartLoading>(),
          isA<OnVersionLoaded>().having((e) => e.versionData, "versionData", versionData),
        ]),
      );

      middleware.onAction(
        const OnVersionSelected(VersionFilter(
          instrument: Instrument.bass,
          versionName: "aaaa",
          versionUrl: "aa",
          isVerified: true,
        )),
        VersionState(version: versionData),
        (action) => actionStream.add(action),
      );

      verify(() => getVersionData.call(
            artistDns: versionData.artist!.url,
            songDns: versionData.song.url,
            instrumentUrl: Instrument.bass.instrumentUrl,
            versionUrl: "aa",
          )).called(1);

      actionStream.close();
    });

    test("when fails should emit OnVersionError action with serverError", () async {
      final error = ServerError(statusCode: 404);
      final versionData = getFakeVersionData();

      final getVersionData = _GetVersionDataMock();
      when(
        () => getVersionData.call(
            artistDns: any(named: "artistDns"),
            songDns: any(named: "songDns"),
            instrumentUrl: any(named: "instrumentUrl"),
            versionUrl: any(named: "versionUrl")),
      ).thenAnswer((_) => SynchronousFuture(Err(error)));

      final middleware = VersionLoaderMiddleware(getVersionData);

      var actionStream = PublishSubject<VersionAction>();

      expectLater(
        actionStream.stream,
        emitsInOrder([
          isA<OnStartLoading>(),
          isA<OnVersionError>().having(
            (e) => e.error,
            "versionError",
            isA<VersionLoadError>().having((versionError) => versionError.error, "serverError", error),
          ),
        ]),
      );

      middleware.onAction(
        const OnVersionSelected(VersionFilter(
          instrument: Instrument.bass,
          versionName: "aaaa",
          versionUrl: "aa",
          isVerified: true,
        )),
        VersionState(version: versionData),
        (action) => actionStream.add(action),
      );

      verify(() => getVersionData.call(
            artistDns: versionData.artist!.url,
            songDns: versionData.song.url,
            instrumentUrl: Instrument.bass.instrumentUrl,
            versionUrl: "aa",
          )).called(1);

      actionStream.close();
    });
  });
}
