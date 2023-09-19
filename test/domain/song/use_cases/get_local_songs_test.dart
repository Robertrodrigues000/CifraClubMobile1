import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:cifraclub/domain/song/models/local_song.dart';
import 'package:cifraclub/domain/song/repository/local_songs_repository.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_songs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:typed_result/typed_result.dart';

class _LocalSongRepositoryMock extends Mock implements LocalSongRepository {}

class _PermissionRepositoryMock extends Mock implements PermissionRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(PermissionType.audio);
  });

  test("When permission is granted and get local songs correctly should return LocalSongSuccess", () async {
    final localSongRepository = _LocalSongRepositoryMock();
    final permissionRepository = _PermissionRepositoryMock();
    const localSong = LocalSong(artistName: "", duration: 1, songName: "", albumId: "", path: "");

    when(() => permissionRepository.requestPermission(any()))
        .thenAnswer((_) => SynchronousFuture(PermissionStatus.granted));
    when(() =>
            localSongRepository.getLocalSongs(artistName: any(named: "artistName"), songName: any(named: "songName")))
        .thenAnswer((_) => SynchronousFuture(const Ok([localSong])));

    final result = await GetLocalSongs(localSongRepository, permissionRepository)(
        artistName: "Gabriela Rocha", songName: "Me Atraiu");

    expect(result.isSuccess, isTrue);
    expect(result.get(), [localSong]);
  });

  test("When permission is denied should return LocalSongPermissionError", () async {
    final localSongRepository = _LocalSongRepositoryMock();
    final permissionRepository = _PermissionRepositoryMock();

    when(() => permissionRepository.requestPermission(any()))
        .thenAnswer((_) => SynchronousFuture(PermissionStatus.denied));

    final result = await GetLocalSongs(localSongRepository, permissionRepository)(
        artistName: "Gabriela Rocha", songName: "Me Atraiu");

    expect(
        result.getError(),
        isA<LocalSongPermissionError>()
            .having((result) => result.permissionStatus, "permission status", PermissionStatus.denied));
  });

  test("When permission is granted and local songs return error should return LocalSongFetchError", () async {
    final localSongRepository = _LocalSongRepositoryMock();
    final permissionRepository = _PermissionRepositoryMock();

    when(() => permissionRepository.requestPermission(any()))
        .thenAnswer((_) => SynchronousFuture(PermissionStatus.granted));
    when(() =>
            localSongRepository.getLocalSongs(artistName: any(named: "artistName"), songName: any(named: "songName")))
        .thenAnswer((_) => SynchronousFuture(const Err("error")));

    final result = await GetLocalSongs(localSongRepository, permissionRepository)(
        artistName: "Gabriela Rocha", songName: "Me Atraiu");

    expect(result.getError(), isA<LocalSongFetchError>().having((result) => result.error, "error", "error"));
  });
}
