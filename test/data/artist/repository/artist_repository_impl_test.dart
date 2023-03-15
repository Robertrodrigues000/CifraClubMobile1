import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/artist/models/artist_image_dto.dart';
import 'package:cifraclub/data/artist/models/top_artists_dto.dart';
import 'package:cifraclub/data/artist/repository/artist_repository_impl.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _MockArtistDataSource extends Mock implements ArtistDataSource {}

void main() {
  group("When getTopArtists() is Called", () {
    test("Request successful", () async {
      var artistDataSource = _MockArtistDataSource();

      var topArtistsDto = const TopArtistsDto(moreResults: true, artists: [
        ArtistDto(
          url: "ze-ramalho",
          genre: GenreDto(
            name: "Rock",
            url: "rock",
          ),
          image: ArtistImageDto(
            color: "blue",
            size162: "size162",
            size250: "size250",
            size50: "size50",
          ),
          name: "Zé Ramalho",
          id: 7507,
        ),
      ]);

      when(() => artistDataSource.getTopArtists(limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Ok(topArtistsDto),
          ),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final topArtists = await repository.getTopArtists(limit: 3, offset: 0).value;

      expect(topArtists.isSuccess, true);
      expect(topArtists.get()!.items.length, 1);
      expect(topArtists.get()!.hasMoreResults, true);
      expect(
        topArtists.get()!.items.first,
        const Artist(
          url: "ze-ramalho",
          genre: Genre(
            name: "Rock",
            url: "rock",
          ),
          image: ArtistImage(
            color: "blue",
            size162: "size162",
            size250: "size250",
            size50: "size50",
          ),
          name: "Zé Ramalho",
          id: 7507,
        ),
      );
    });

    test("Request failed", () async {
      final artistDataSource = _MockArtistDataSource();

      when(() => artistDataSource.getTopArtists(limit: 3, offset: 0)).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Err(ServerError()),
          ),
        ),
      );

      final repository = ArtistRepositoryImpl(artistDataSource: artistDataSource);
      final topArtists = await repository.getTopArtists(limit: 3, offset: 0).value;

      expect(topArtists.isFailure, true);
      expect(topArtists.getError().runtimeType, ServerError);
      expect((topArtists.getError() as ServerError).statusCode, null);
    });
  });
}
