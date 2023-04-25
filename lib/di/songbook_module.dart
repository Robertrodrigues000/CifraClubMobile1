// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
import 'package:cifraclub/data/songbook/repository/songbook_repository_impl.dart';
import 'package:cifraclub/data/songbook/repository/user_songbook_repository_impl.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@module
abstract class SongbookModule {
  UserSongbookDataSource getUserSongbookDataSource(Isar isar) {
    return UserSongbookDataSource(isar);
  }

  SongbookDataSource getSongbookDataSource(CifraClubAPINetworkService networkService) {
    return SongbookDataSource(networkService);
  }

  SongbookRepository getSongbookRepository(SongbookDataSource songbookDataSource) {
    return SongbookRepositoryImpl(songbookDataSource);
  }

  UserSongbookRepository getUserSongbookRepository(UserSongbookDataSource userSongbookDataSource) {
    return UserSongbookRepositoryImpl(userSongbookDataSource);
  }
}
