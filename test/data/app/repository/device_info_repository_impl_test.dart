import 'package:cifraclub/data/app/repository/device_info_repository_impl.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAndroidDeviceInfo extends Fake implements AndroidDeviceInfo {
  final int? fakeSdkInt;

  FakeAndroidDeviceInfo({this.fakeSdkInt = 30});

  @override
  AndroidBuildVersion get version => FakeAndroidBuildVersion(fakeSdkInt);
}

class FakeAndroidBuildVersion extends Fake implements AndroidBuildVersion {
  @override
  int get sdkInt => fakeSdkInt!;

  final int? fakeSdkInt;

  FakeAndroidBuildVersion(this.fakeSdkInt);
}

class FakeIosDeviceInfo extends Fake implements IosDeviceInfo {
  final String? fakeSystemVersion;

  FakeIosDeviceInfo({this.fakeSystemVersion = '14.1'});

  @override
  String get systemVersion => fakeSystemVersion ?? '0';
}

void main() {
  group("when getOsVersion is called ", () {
    test("return AndroidOsVersion for android", () async {
      final deviceInfo = SynchronousFuture(FakeAndroidDeviceInfo(fakeSdkInt: 30));
      final repository = DeviceInfoRepositoryImpl(deviceInfo, OperatingSystem.ios);

      final result = await repository.getOSVersion();

      expect(result is AndroidOsSdkVersion, true);
      expect(result.version, "30");
    });

    test("return IosOsVersion for iOS", () async {
      final deviceInfo = SynchronousFuture(FakeIosDeviceInfo(fakeSystemVersion: '14.1'));
      final repository = DeviceInfoRepositoryImpl(deviceInfo, OperatingSystem.ios);

      final result = await repository.getOSVersion();

      expect(result is IosOsVersion, true);
      expect(result.version, "14.1");
    });
    test("return default iosVersion when osVersion is null ios", () async {
      final deviceInfo = SynchronousFuture(FakeIosDeviceInfo(fakeSystemVersion: null));
      final repository = DeviceInfoRepositoryImpl(deviceInfo, OperatingSystem.ios);

      final result = await repository.getOSVersion();

      expect((result as IosOsVersion).version, "0");
    });
  });
}
