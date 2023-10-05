import 'package:cifraclub/data/search/repository/shazam_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shazam/pigeon.g.dart';
import 'package:typed_result/typed_result.dart';

class _ShazamHostApiMock extends Mock implements ShazamHostApi {}

void main() {
  test("When call 'cancelSearch' should call in plugin", () async {
    final shazamHostApi = _ShazamHostApiMock();
    when(shazamHostApi.cancelSearch).thenAnswer((_) => SynchronousFuture(null));

    final repository = ShazamRepositoryImpl(shazamHostApi);
    await repository.cancelSearch();

    verify(shazamHostApi.cancelSearch).called(1);
  });

  group("When call 'search'", () {
    test("and is success should call in plugin and return shazam result", () async {
      final shazamHostApi = _ShazamHostApiMock();
      final shazamResult =
          ShazamResult(result: ShazamSongDto(songName: "songName", artistName: "artistName", image: ""));
      when(() => shazamHostApi.search(any())).thenAnswer((_) => SynchronousFuture(shazamResult));

      final repository = ShazamRepositoryImpl(shazamHostApi);
      final result = await repository.searchAudio("token");

      verify(() => shazamHostApi.search("token")).called(1);
      expect(result.isSuccess, isTrue);
      expect(result.get()!.songName, shazamResult.result!.songName);
      expect(result.get()!.artistName, shazamResult.result!.artistName);
      expect(result.get()!.imageUrl, shazamResult.result!.image);
    });

    test("and return error message should call in plugin and return result error", () async {
      final shazamHostApi = _ShazamHostApiMock();
      final shazamResult = ShazamResult(error: "error");
      when(() => shazamHostApi.search(any())).thenAnswer((_) => SynchronousFuture(shazamResult));

      final repository = ShazamRepositoryImpl(shazamHostApi);
      final result = await repository.searchAudio("token");

      verify(() => shazamHostApi.search("token")).called(1);
      expect(result.isFailure, isTrue);
      expect(result.getError()!, "error");
    });

    test("and throw platform exception should call in plugin and return result error", () async {
      final shazamHostApi = _ShazamHostApiMock();
      when(() => shazamHostApi.search(any())).thenThrow(PlatformException(code: "", message: "error"));

      final repository = ShazamRepositoryImpl(shazamHostApi);
      final result = await repository.searchAudio("token");

      verify(() => shazamHostApi.search("token")).called(1);
      expect(result.isFailure, isTrue);
      expect(result.getError()!, "error");
    });

    test("and throw exception should call in plugin and return result error", () async {
      final shazamHostApi = _ShazamHostApiMock();
      when(() => shazamHostApi.search(any())).thenThrow(Exception("error"));

      final repository = ShazamRepositoryImpl(shazamHostApi);
      final result = await repository.searchAudio("token");

      verify(() => shazamHostApi.search("token")).called(1);
      expect(result.isFailure, isTrue);
      expect(result.getError()!, "Exception: error");
    });
  });
}
