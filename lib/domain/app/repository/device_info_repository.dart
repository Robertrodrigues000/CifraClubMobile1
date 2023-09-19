import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';

abstract class DeviceInfoRepository {
  Future<OsVersion> getOSVersion();
}
