// coverage:ignore-file
import 'package:cifraclub/presentation/navigator/screen_entry.dart';
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';

class ScreenEntryBuilder {
  final String screenName;
  final ScreenEntry? Function(Map<String, String> params, Object? objectParam) builder;

  const ScreenEntryBuilder(this.screenName, this.builder);
}

final List<ScreenEntryBuilder> cifraScreenBuilders = [
  ScreenEntryBuilder(
    DevScreenEntry.name,
    (params, _) => DevScreenEntry(params),
  ),
  ScreenEntryBuilder(
    NtpTestEntry.name,
    (params, _) => NtpTestEntry(params),
  ),
  ScreenEntryBuilder(
    GenresEntry.name,
    (params, _) => GenresEntry(params),
  ),
];
