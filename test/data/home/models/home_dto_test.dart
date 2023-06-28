import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/home/models/highlight/highlights_dto.dart';
import 'package:cifraclub/data/home/models/home_dto.dart';
import 'package:cifraclub/data/home/models/news/news_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_dto.dart';
import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/home/models/highlight_mock.dart';
import '../../../shared_mocks/domain/home/models/news_mock.dart';
import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _SongDtoMock extends Mock implements SongDto {}

class _ArtistDtoMock extends Mock implements ArtistDto {}

class _VideoLessonsDtoMock extends Mock implements VideoLessonsDto {}

class _NewsDtoMock extends Mock implements NewsDto {}

class _HighlightsDtoMock extends Mock implements HighlightsDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to HomeInfo", () {
    final songDto = _SongDtoMock();
    final song = getFakeSong();
    when(songDto.toDomain).thenReturn(song);

    final artistDto = _ArtistDtoMock();
    final artist = getFakeArtist();
    when(artistDto.toDomain).thenReturn(artist);

    final videoLessonsDto = _VideoLessonsDtoMock();
    final videoLessons = getFakeVideoLessons();
    when(videoLessonsDto.toDomain).thenReturn(videoLessons);

    final newsDto = _NewsDtoMock();
    final news = getFakeNews();
    when(newsDto.toDomain).thenReturn(news);

    final highlightsDto = _HighlightsDtoMock();
    final highlights = [getFakeHighlight(), getFakeHighlight()];
    when(highlightsDto.toDomain).thenReturn(highlights);

    final homeDto = HomeDto(
      highlights: highlightsDto,
      songs: [songDto],
      artists: [artistDto],
      videoLessons: [videoLessonsDto],
      news: [newsDto],
    );

    final homeInfo = homeDto.toDomain();

    verify(songDto.toDomain).called(1);
    verify(artistDto.toDomain).called(1);
    verify(videoLessonsDto.toDomain).called(1);
    verify(newsDto.toDomain).called(1);
    verify(highlightsDto.toDomain).called(1);

    expect(homeInfo.songs?.length, 1);
    expect(homeInfo.songs?.first, song);
    expect(homeInfo.artists?.length, 1);
    expect(homeInfo.artists?.first, artist);
    expect(homeInfo.videoLessons?.length, 1);
    expect(homeInfo.videoLessons?.first, videoLessons);
    expect(homeInfo.news?.length, 1);
    expect(homeInfo.news?.first, news);
    expect(homeInfo.highlights?.length, 2);
    expect(homeInfo.highlights?.first, highlights.first);
    expect(homeInfo.highlights?.last, highlights.last);
  });
}
