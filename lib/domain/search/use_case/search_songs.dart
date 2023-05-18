// coverage:ignore-file
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:cifraclub/domain/search/repository/search_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class SearchSongs {
  final SearchRepository searchRepository;

  SearchSongs({
    required this.searchRepository,
  });

  Future<Result<List<SongSearch>, RequestError>> call({required String query}) {
    return searchRepository.getSongs(query: query);
  }
}
