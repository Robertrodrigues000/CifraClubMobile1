import 'package:cifraclub/data/permission/models/app_permission_status.dart';
import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:cifraclub/domain/permission/repository/permission_repository.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:cifraclub/domain/search/models/shazam_item.dart';
import 'package:cifraclub/domain/search/repository/shazam_repository.dart';
import 'package:cifraclub/domain/search/use_cases/search_shazam.dart';
import 'package:cifraclub/domain/song/models/song_search_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _ShazamRepositoryMock extends Mock implements ShazamRepository {}

class _PermissionRepositoryMock extends Mock implements PermissionRepository {}

class _RemoteConfigRepositoryMock extends Mock implements RemoteConfigRepository {}

void main() {
  SearchShazam getSearchShazam({
    _ShazamRepositoryMock? shazamRepository,
    _PermissionRepositoryMock? permissionRepository,
    _RemoteConfigRepositoryMock? remoteConfigRepository,
  }) =>
      SearchShazam(
        shazamRepository ?? _ShazamRepositoryMock(),
        permissionRepository ?? _PermissionRepositoryMock(),
        remoteConfigRepository ?? _RemoteConfigRepositoryMock(),
      );

  test("When permission is denied should return SongPermissionError", () async {
    final permissionRepository = _PermissionRepositoryMock();

    when(() => permissionRepository.requestPermission(PermissionType.microphone))
        .thenAnswer((_) => SynchronousFuture(AppPermissionStatus.denied));

    final useCase = await getSearchShazam(permissionRepository: permissionRepository)();

    expect(useCase.isFailure, isTrue);
    expect(useCase.getError().runtimeType, SongPermissionError);
  });

  test("When permission is granted and shazam request fails should return error mensage", () async {
    final permissionRepository = _PermissionRepositoryMock();
    final remoteConfigRepository = _RemoteConfigRepositoryMock();
    final shazamRepository = _ShazamRepositoryMock();

    when(() => permissionRepository.requestPermission(PermissionType.microphone))
        .thenAnswer((_) => SynchronousFuture(AppPermissionStatus.granted));

    when(remoteConfigRepository.getShazamToken).thenReturn("token");

    when(() => shazamRepository.searchAudio("token")).thenAnswer((_) => SynchronousFuture(const Err("error")));

    final useCase = await getSearchShazam(
      permissionRepository: permissionRepository,
      remoteConfigRepository: remoteConfigRepository,
      shazamRepository: shazamRepository,
    )();

    expect(useCase.isFailure, isTrue);
    expect(useCase.getError().runtimeType, SongFetchError);
    expect((useCase.getError() as SongFetchError).error, "error");
  });

  test("When permission is granted and shazam request is success should return shazam item", () async {
    final permissionRepository = _PermissionRepositoryMock();
    final remoteConfigRepository = _RemoteConfigRepositoryMock();
    final shazamRepository = _ShazamRepositoryMock();

    when(() => permissionRepository.requestPermission(PermissionType.microphone))
        .thenAnswer((_) => SynchronousFuture(AppPermissionStatus.granted));

    when(remoteConfigRepository.getShazamToken).thenReturn("token");

    when(() => shazamRepository.searchAudio("token"))
        .thenAnswer((_) => SynchronousFuture(const Ok(ShazamItem("artistName", "songName", "image"))));

    final useCase = await getSearchShazam(
      permissionRepository: permissionRepository,
      remoteConfigRepository: remoteConfigRepository,
      shazamRepository: shazamRepository,
    )();

    expect(useCase.isSuccess, isTrue);
    expect(useCase.get().runtimeType, ShazamItem);
    final shazamItem = useCase.get() as ShazamItem;
    expect(shazamItem.artistName, "artistName");
    expect(shazamItem.songName, "songName");
    expect(shazamItem.imageUrl, "image");
  });
}
