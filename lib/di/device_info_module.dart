// coverage:ignore-file

import 'package:cifraclub/data/app/repository/device_info_repository_impl.dart';
import 'package:cifraclub/domain/app/repository/device_info_repository.dart';
import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DeviceInfoModule {
  @singleton
  DeviceInfoRepository getDeviceInfoRepository(GetOperatingSystem getOperatingSystem) {
    return DeviceInfoRepositoryImpl(DeviceInfoPlugin().deviceInfo, getOperatingSystem());
  }

  @singleton
  @preResolve
  Future<OsVersion> getOSVersion(DeviceInfoRepository deviceInfoRepository) async {
    return deviceInfoRepository.getOSVersion();
  }
}
