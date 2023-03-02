// coverage:ignore-file
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetTopArtists {
  final ArtistRepository artistRepository;

  GetTopArtists({
    required this.artistRepository,
  });

  Future<Result<PaginatedList<Artist>, RequestError>> call({String? genreUrl, int limit = 100, int offset = 0}) async {
    final result = await artistRepository.getTopArtists(genreUrl: genreUrl, limit: limit, offset: offset);

    if (result.isSuccess) {
      return result.get()!.items.isNotEmpty ? result : Err(ServerError());
    }
    return result;
  }
}
