import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _OpenAppMock extends Mock implements OpenApp {}

class _OpenUrlMock extends Mock implements OpenUrl {}

class _IsAppInstalledMock extends Mock implements IsAppInstalled {}

class _GetOperatingSystemMock extends Mock implements GetOperatingSystem {}

void main() {
  group("When app is installed", () {
    test("should open app", () async {
      const app = App.cifraClub;

      final getOperatingSystem = _GetOperatingSystemMock();
      when(getOperatingSystem.call).thenReturn(OperatingSystem.ios);

      final isAppInstalled = _IsAppInstalledMock();
      when(() => isAppInstalled.call(app)).thenAnswer((_) => SynchronousFuture(true));

      final openApp = _OpenAppMock();
      when(() => openApp.call(app)).thenAnswer((_) => SynchronousFuture(null));

      final openAppOrStore = OpenAppOrStore(
        openApp: openApp,
        openUrl: _OpenUrlMock(),
        isAppInstalled: isAppInstalled,
        getOperatingSystem: getOperatingSystem,
      );

      openAppOrStore(app);

      verify(getOperatingSystem.call).called(1);
      verify(() => isAppInstalled.call(app)).called(1);
      verify(() => openApp.call(app)).called(1);
    });
  });

  group("When app is not installed", () {
    test("should open appstore url when under iOS", () async {
      const app = App.cifraClub;

      final getOperatingSystem = _GetOperatingSystemMock();
      when(getOperatingSystem.call).thenReturn(OperatingSystem.ios);

      final isAppInstalled = _IsAppInstalledMock();
      when(() => isAppInstalled.call(app)).thenAnswer((_) => SynchronousFuture(false));

      final openUrl = _OpenUrlMock();
      when(() => openUrl.call(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

      final openAppOrStore = OpenAppOrStore(
        openApp: _OpenAppMock(),
        openUrl: openUrl,
        isAppInstalled: isAppInstalled,
        getOperatingSystem: getOperatingSystem,
      );

      openAppOrStore(app);

      verify(getOperatingSystem.call).called(1);
      verify(() => isAppInstalled.call(app)).called(1);
      verify(() => openUrl.call(app.appStoreUrl)).called(1);
    });

    test("should open google play url when under Android", () async {
      const app = App.cifraClub;

      final getOperatingSystem = _GetOperatingSystemMock();
      when(getOperatingSystem.call).thenReturn(OperatingSystem.android);

      final isAppInstalled = _IsAppInstalledMock();
      when(() => isAppInstalled.call(app)).thenAnswer((_) => SynchronousFuture(false));

      final openUrl = _OpenUrlMock();
      when(() => openUrl.call(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

      final openAppOrStore = OpenAppOrStore(
        openApp: _OpenAppMock(),
        openUrl: openUrl,
        isAppInstalled: isAppInstalled,
        getOperatingSystem: getOperatingSystem,
      );

      openAppOrStore(app);

      verify(getOperatingSystem.call).called(1);
      verify(() => isAppInstalled.call(app)).called(1);
      verify(() => openUrl.call(app.googlePlayUrl)).called(1);
    });

    test("should ignore when other platforms", () async {
      const app = App.cifraClub;

      final getOperatingSystem = _GetOperatingSystemMock();
      when(getOperatingSystem.call).thenReturn(OperatingSystem.web);

      final isAppInstalled = _IsAppInstalledMock();
      when(() => isAppInstalled.call(app)).thenAnswer((_) => SynchronousFuture(false));

      final openUrl = _OpenUrlMock();
      when(() => openUrl.call(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

      final openAppOrStore = OpenAppOrStore(
        openApp: _OpenAppMock(),
        openUrl: openUrl,
        isAppInstalled: isAppInstalled,
        getOperatingSystem: getOperatingSystem,
      );

      openAppOrStore(app);

      verify(getOperatingSystem.call).called(1);
      verify(() => isAppInstalled.call(app)).called(1);
      verifyNever(() => openUrl.call(any()));
    });
  });
}
