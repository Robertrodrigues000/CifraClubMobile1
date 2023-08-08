import 'package:equatable/equatable.dart';

class VersionFilter extends Equatable {
  final String versionName;
  final String versionUrl;
  final bool isVerified;

  const VersionFilter({
    required this.versionName,
    required this.versionUrl,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [versionUrl];
}
