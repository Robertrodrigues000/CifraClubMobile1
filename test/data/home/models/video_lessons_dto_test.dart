import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_image_dto.dart';
import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/home/models/home_image_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _SongDtoMock extends Mock implements SongDto {}

class _ArtistDtoMock extends Mock implements ArtistDto {}

class _VideoLessonsImageDtoMock extends Mock implements VideoLessonsImageDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to VideoLessons", () {
    final songDto = _SongDtoMock();
    final song = getFakeSong();
    when(songDto.toDomain).thenReturn(song);

    final artistDto = _ArtistDtoMock();
    final artist = getFakeArtist();
    when(artistDto.toDomain).thenReturn(artist);

    final videoLessonsImageDto = _VideoLessonsImageDtoMock();
    final homeImage = getFakeHomeImage();
    when(videoLessonsImageDto.toDomain).thenReturn(homeImage);

    final videoLessonsDto = VideoLessonsDto(
      id: 0,
      youtubeId: "1",
      title: "title",
      url: "url",
      views: 10,
      duration: 120,
      urlApi: "urlApi",
      song: songDto,
      artist: artistDto,
      images: videoLessonsImageDto,
      instruments: const ["electric-guitar"],
    );

    final videoLessons = videoLessonsDto.toDomain();

    verify(songDto.toDomain).called(1);
    verify(artistDto.toDomain).called(1);
    verify(videoLessonsImageDto.toDomain).called(1);

    expect(videoLessons.id, videoLessonsDto.id);
    expect(videoLessons.youtubeId, videoLessonsDto.youtubeId);
    expect(videoLessons.title, videoLessonsDto.title);
    expect(videoLessons.url, videoLessonsDto.url);
    expect(videoLessons.views, videoLessonsDto.views);
    expect(videoLessons.duration, videoLessonsDto.duration);
    expect(videoLessons.urlApi, videoLessonsDto.urlApi);
  });
}
