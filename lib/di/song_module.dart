// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/song/data_source/song_data_source.dart';
import 'package:cifraclub/data/song/repository/song_repository_impl.dart';
import 'package:cifraclub/domain/song/repository/song_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SongModule {
  SongDataSource getSongDataSource(CifraClubAPINetworkService networkService) {
    return SongDataSource(
      networkService: networkService,
    );
  }

  SongRepository getSongRepository(SongDataSource songDataSource) {
    return SongRepositoryImpl(
      songDataSource: songDataSource,
    );
  }
}
