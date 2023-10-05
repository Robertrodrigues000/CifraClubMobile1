import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/data/permission/models/app_permission_status.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song_search_error.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_song_image.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_songs.dart';
import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/song/models/local_song_mock.dart';
import '../../../shared_mocks/domain/youtube/models/youtube_video_mock.dart';

class _GetYouTubeVideosMock extends Mock implements GetYouTubeVideos {}

class _GetLocalSongsMock extends Mock implements GetLocalSongs {}

class _GetLocalSongImageMock extends Mock implements GetLocalSongImage {}

void main() {
  ListenBottomSheetBloc getBloc({
    _GetYouTubeVideosMock? getYouTubeVideos,
    _GetLocalSongsMock? getLocalSongs,
    _GetLocalSongImageMock? getLocalSongImage,
    String? artistName,
    String? songName,
  }) =>
      ListenBottomSheetBloc(
        getYouTubeVideos ?? _GetYouTubeVideosMock(),
        getLocalSongs ?? _GetLocalSongsMock(),
        getLocalSongImage ?? _GetLocalSongImageMock(),
        artistName: artistName ?? "",
        songName: songName ?? "",
      );

  group("When call 'init'", () {
    group("and is success", () {
      final getYouTubeVideos = _GetYouTubeVideosMock();
      final youtubeVideo = getFakeYouTubeVideo();
      when(() => getYouTubeVideos(artistName: any(named: "artistName"), songName: any(named: "songName")))
          .thenAnswer((_) => SynchronousFuture(Ok([youtubeVideo])));

      blocTest(
        "should emit a list of youtube videos",
        build: () => getBloc(getYouTubeVideos: getYouTubeVideos),
        act: (bloc) => bloc.init(),
        expect: () => [
          isA<ListenBottomSheetState>().having((state) => state.isLoadingYoutube, "loading youtube", isTrue),
          isA<ListenBottomSheetState>()
              .having((state) => state.isLoadingYoutube, "loading youtube", isFalse)
              .having((state) => state.youtubeVideos, "youtube videos", [youtubeVideo])
        ],
      );
    });

    group("and request fails", () {
      final getYouTubeVideos = _GetYouTubeVideosMock();
      when(() => getYouTubeVideos(artistName: any(named: "artistName"), songName: any(named: "songName")))
          .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

      blocTest(
        "should emit error",
        build: () => getBloc(getYouTubeVideos: getYouTubeVideos),
        act: (bloc) => bloc.init(),
        expect: () => [
          isA<ListenBottomSheetState>().having((state) => state.isLoadingYoutube, "loading youtube", isTrue),
          isA<ListenBottomSheetState>().having((state) => state.isLoadingYoutube, "loading youtube", isFalse).having(
                (state) => state.youtubeError,
                "youtube videos",
                isA<ServerError>().having((error) => error.statusCode, "statusCode", 404),
              ),
        ],
      );
    });
  });

  group("When call 'getLocalSongs'", () {
    group("and is success", () {
      final getLocalSongsMock = _GetLocalSongsMock();
      final localSong = getFakeLocalSong();
      when(() => getLocalSongsMock(artistName: any(named: "artistName"), songName: any(named: "songName")))
          .thenAnswer((_) => SynchronousFuture(Ok([localSong])));

      blocTest(
        "should emit a list of local songs",
        build: () => getBloc(getLocalSongs: getLocalSongsMock),
        act: (bloc) => bloc.getLocalSongs(),
        expect: () => [
          isA<ListenBottomSheetState>().having((state) => state.isLoadingLocalSongs, "loading local songs", isTrue),
          isA<ListenBottomSheetState>()
              .having((state) => state.isLoadingLocalSongs, "loading local songs", isFalse)
              .having((state) => state.localSongs, "youtube videos", [localSong])
        ],
      );
    });

    group("and is permission error", () {
      final getLocalSongsMock = _GetLocalSongsMock();
      when(() => getLocalSongsMock(artistName: any(named: "artistName"), songName: any(named: "songName")))
          .thenAnswer((_) => SynchronousFuture(Err(SongPermissionError(AppPermissionStatus.denied))));

      blocTest(
        "should emit a list of youtube videos",
        build: () => getBloc(getLocalSongs: getLocalSongsMock),
        act: (bloc) => bloc.getLocalSongs(),
        expect: () => [
          isA<ListenBottomSheetState>().having((state) => state.isLoadingLocalSongs, "loading local songs", isTrue),
          isA<ListenBottomSheetState>()
              .having((state) => state.isLoadingLocalSongs, "loading local songs", isFalse)
              .having(
                (state) => state.localSongsError,
                "permission error",
                isA<SongPermissionError>()
                    .having((error) => error.permissionStatus, "permission status", AppPermissionStatus.denied),
              )
        ],
      );
    });

    group("and is fetch error", () {
      final getLocalSongsMock = _GetLocalSongsMock();
      when(() => getLocalSongsMock(artistName: any(named: "artistName"), songName: any(named: "songName")))
          .thenAnswer((_) => SynchronousFuture(Err(SongFetchError("error"))));

      blocTest(
        "should emit a list of youtube videos",
        build: () => getBloc(getLocalSongs: getLocalSongsMock),
        act: (bloc) => bloc.getLocalSongs(),
        expect: () => [
          isA<ListenBottomSheetState>().having((state) => state.isLoadingLocalSongs, "loading local songs", isTrue),
          isA<ListenBottomSheetState>()
              .having((state) => state.isLoadingLocalSongs, "loading local songs", isFalse)
              .having(
                (state) => state.localSongsError,
                "fetch error",
                isA<SongFetchError>().having((error) => error.error, "permission status", "error"),
              )
        ],
      );
    });
  });

  test("When call 'getImage' should return binary image", () async {
    final getLocalSongImageMock = _GetLocalSongImageMock();
    final uint8List = Uint8List(0);
    when(() => getLocalSongImageMock("context://test")).thenAnswer((_) => SynchronousFuture(uint8List));

    final bloc = getBloc(getLocalSongImage: getLocalSongImageMock);
    final result = await bloc.getImage("context://test");

    expect(result, uint8List);
  });
}
