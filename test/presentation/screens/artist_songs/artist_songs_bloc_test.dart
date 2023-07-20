import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart';
import 'package:cifraclub/domain/home/models/images_size.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';

class _GetArtistVideoLessons extends Mock implements GetArtistVideoLessons {}

void main() {
  ArtistSongsBloc getArtistSongsBloc({
    _GetArtistVideoLessons? getArtistVideoLessons,
  }) =>
      ArtistSongsBloc(getArtistVideoLessons ?? _GetArtistVideoLessons());

  test("when init is called should initialize use case", () async {
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
    when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));

    final bloc = getArtistSongsBloc(getArtistVideoLessons: getArtistVideoLessons);

    await bloc.init(null, "");
    verify(() => getArtistVideoLessons.call(any())).called(1);
  });

  group("when getArtistSongs is called", () {
    group("and request is successful", () {
      final getArtistVideoLessons = _GetArtistVideoLessons();
      final bloc = getArtistSongsBloc(getArtistVideoLessons: getArtistVideoLessons);
      const videoLessons = [
        VideoLesson(
            id: 1,
            youtubeId: "",
            title: "",
            url: "",
            views: 1,
            duration: 2,
            urlApi: "",
            instrument: Instrument.drums,
            images: ImagesSize(small: "", medium: "")),
        VideoLesson(
            id: 1,
            youtubeId: "",
            title: "",
            url: "",
            views: 1,
            duration: 2,
            urlApi: "",
            instrument: Instrument.drums,
            images: ImagesSize(small: "", medium: "")),
        VideoLesson(
            id: 1,
            youtubeId: "",
            title: "",
            url: "",
            views: 1,
            duration: 2,
            urlApi: "",
            instrument: Instrument.guitar,
            images: ImagesSize(small: "", medium: ""))
      ];

      const filteredVideoLessons = [
        VideoLesson(
            id: 1,
            youtubeId: "",
            title: "",
            url: "",
            views: 1,
            duration: 2,
            urlApi: "",
            instrument: Instrument.guitar,
            images: ImagesSize(small: "", medium: ""))
      ];

      when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(const Ok(videoLessons)));

      blocTest("should emit state with filtered video lessons",
          build: () => bloc,
          act: (bloc) => bloc.getVideoLessons(Instrument.guitar, ""),
          expect: () => [
                isA<ArtistSongsState>()
                    .having((state) => state.videoLessons, "filtered video lessons", filteredVideoLessons)
              ]);
    });

    group("when request returns error", () {
      final getArtistVideoLessons = _GetArtistVideoLessons();
      final bloc = getArtistSongsBloc(getArtistVideoLessons: getArtistVideoLessons);
      when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest("should emit error state",
          build: () => bloc,
          act: (bloc) => bloc.getVideoLessons(null, ""),
          expect: () => [
                isA<ArtistSongsState>().having((state) => state.error, "error", isNotNull),
              ]);
    });
  });
}
