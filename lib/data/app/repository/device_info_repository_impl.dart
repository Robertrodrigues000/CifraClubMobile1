import 'package:cifraclub/domain/app/repository/device_info_repository.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoRepositoryImpl extends DeviceInfoRepository {
  final Future<BaseDeviceInfo> _deviceInfo;
  final OperatingSystem _os;
  BaseDeviceInfo? cachedDeviceInfo;

  DeviceInfoRepositoryImpl(this._deviceInfo, this._os);

  @override
  Future<OsVersion> getOSVersion() async {
    cachedDeviceInfo ??= await _deviceInfo;

    final deviceInfo = cachedDeviceInfo!;

    if (deviceInfo is AndroidDeviceInfo) {
      final version = deviceInfo.version.sdkInt;

      return AndroidOsSdkVersion(version.toString());
    }

    if (deviceInfo is IosDeviceInfo) {
      final version = deviceInfo.systemVersion;

      return IosOsVersion(version);
    }

    throw UnimplementedOperatingSystemException(_os);
  }
}
