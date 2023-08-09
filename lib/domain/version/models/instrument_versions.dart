import 'package:cifraclub/domain/version/models/instrument_version.dart';

class InstrumentVersions {
  final List<InstrumentVersion>? versions;
  final String label;
  final int type;

  InstrumentVersions({
    this.versions,
    required this.label,
    required this.type,
  });
}
