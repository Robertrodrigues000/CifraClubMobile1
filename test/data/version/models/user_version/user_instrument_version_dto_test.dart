import 'package:cifraclub/data/version/models/user_version/user_instrument_version_dto.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    final versionDataSong = InstrumentVersion(
      id: 1,
      versionName: "Bohemian Rhapsody",
      versionUrl: "https://example.com/version.mp3",
      completePath: "https://example.com/song.json",
      isVerified: true,
      videoLesson: VersionDataVideoLesson(id: 1, youtubeId: "youtubeId", title: "title", thumb: "thumb"),
    );

    final userVersionDataSongDto = UserInstrumentVersionDto.fromDomain(versionDataSong);

    expect(userVersionDataSongDto.id, 1);
    expect(userVersionDataSongDto.versionName, "Bohemian Rhapsody");
    expect(userVersionDataSongDto.versionUrl, "https://example.com/version.mp3");
    expect(userVersionDataSongDto.completePath, "https://example.com/song.json");
    expect(userVersionDataSongDto.isVerified, true);
    expect(userVersionDataSongDto.videoLesson?.id, 1);
  });
}
