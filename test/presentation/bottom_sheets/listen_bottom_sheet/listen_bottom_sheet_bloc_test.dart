import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/youtube/models/youtube_video_mock.dart';

class _GetYouTubeVideosMock extends Mock implements GetYouTubeVideos {}

void main() {
  ListenBottomSheetBloc getBloc({
    GetYouTubeVideos? getYouTubeVideos,
  }) =>
      ListenBottomSheetBloc(
        getYouTubeVideos ?? _GetYouTubeVideosMock(),
      );

  group("When call 'init' and is success", () {
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

  group("When call 'init' and request fails", () {
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
}
