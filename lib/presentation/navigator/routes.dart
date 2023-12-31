// coverage:ignore-file
import 'package:cifraclub/presentation/screens/academy/academy_entry.dart';
import 'package:cifraclub/presentation/screens/album/album_entry.dart';
import 'package:cifraclub/presentation/screens/albums/albums_entry.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_entry.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_entry.dart';
import 'package:cifraclub/presentation/screens/dev/dev_entry.dart';
import 'package:cifraclub/presentation/screens/genre/genre_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_entry.dart';
import 'package:cifraclub/presentation/screens/search/search_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_entry.dart';
import 'package:cifraclub/presentation/screens/more/more_entry.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_entry.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_entry.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_entry.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/screens/version/full_screen_video/full_screen_video_entry.dart';
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
  NavRoute(
    TopArtistsEntry.name,
    (params, _) => TopArtistsEntry(params),
  ),
  NavRoute(
    TopSongsEntry.name,
    (params, _) => TopSongsEntry(params),
  ),
  NavRoute(
    MoreEntry.name,
    (params, _) => MoreEntry(params),
  ),
  NavRoute(
    AcademyEntry.name,
    (params, _) => AcademyEntry(params),
  ),
  NavRoute(
    VersionsEntry.name,
    (params, _) => VersionsEntry(params),
  ),
  NavRoute(
    SongbookEntry.name,
    (params, _) => SongbookEntry(params),
  ),
  NavRoute(
    ArtistEntry.name,
    (params, _) => ArtistEntry(params),
  ),
  NavRoute(
    AddVersionsToListEntry.name,
    (params, _) => AddVersionsToListEntry(params),
  ),
  NavRoute(
    AlbumsEntry.name,
    (params, _) => AlbumsEntry(params),
  ),
  NavRoute(
    ArtistSongsEntry.name,
    (params, _) => ArtistSongsEntry(params),
  ),
  NavRoute(
    AlbumEntry.name,
    (params, _) => AlbumEntry(params),
  ),
  NavRoute(
    SearchEntry.name,
    (params, _) => SearchEntry(params),
  ),
  NavRoute(
    VersionEntry.name,
    (params, _) => VersionEntry(params),
  ),
  NavRoute(
    VersionsSharedEntry.name,
    (params, _) => VersionsSharedEntry(params),
  ),
  NavRoute(
    FullScreenVideoEntry.name,
    (params, _) => FullScreenVideoEntry(params),
  ),
  NavRoute(
    ContribScreenEntry.name,
    (params, _) => ContribScreenEntry(params),
  ),
];
