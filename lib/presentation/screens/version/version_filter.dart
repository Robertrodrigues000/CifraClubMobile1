import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:equatable/equatable.dart';

class VersionFilter extends Equatable {
  final Instrument instrument;
  final String versionName;
  final String versionUrl;
  final bool isVerified;

  const VersionFilter({
    required this.instrument,
    required this.versionName,
    required this.versionUrl,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [versionUrl];
}
