// coverage:ignore-file
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';
import 'package:cifraclub/presentation/screens/genre/genre_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';
import 'package:nav/nav.dart';

final List<NavRoute> routes = [
  NavRoute(
    DevScreenEntry.name,
    (params, _) => DevScreenEntry(params),
  ),
  NavRoute(
    NtpTestEntry.name,
    (params, _) => NtpTestEntry(params),
  ),
  NavRoute(
    GenresEntry.name,
    (params, _) => GenresEntry(params),
  ),
  NavRoute(
    GenreEntry.name,
    (params, _) => GenreEntry(params),
  ),
  NavRoute(
    HomeEntry.name,
    (params, _) => HomeEntry(params),
  ),
];
