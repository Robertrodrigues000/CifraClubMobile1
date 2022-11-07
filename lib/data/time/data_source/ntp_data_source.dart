import 'package:ntp/ntp.dart';

/// A wrapper for [NTP] static
class NtpDataSource {
  const NtpDataSource();

  Future<int> getNtpOffset({
    String? lookUpAddress,
    int port = 123,
    DateTime? localTime,
    Duration? timeout,
  }) {
    return NTP.getNtpOffset(
      lookUpAddress: lookUpAddress ?? 'time.google.com',
      port: port,
      localTime: localTime,
      timeout: timeout,
    );
  }
}
