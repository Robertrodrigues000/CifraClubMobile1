import 'package:cifraclub/data/songbook/models/songbook_version_input_dto.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When 'fromDomain' is called should return correct dto entity", () async {
    final versionInput = SongbookVersionInput(
      artistUrl: "artistUrl",
      id: 1,
      instrument: Instrument.bass.instrumentUrl,
      versionLabel: Instrument.bass.instrumentUrl,
      type: 2,
      songUrl: "songUrl",
      capo: 3,
      tone: "B",
      tuning: "AB",
      versionId: 12,
    );

    final songbookSongInputDto = SongbookVersionInputDto.fromDomain(versionInput);

    expect(versionInput.id, songbookSongInputDto.id);
    expect(versionInput.artistUrl, songbookSongInputDto.artistUrl);
    expect(versionInput.capo, songbookSongInputDto.capo);
    expect(versionInput.versionId, songbookSongInputDto.versionId);
    expect(versionInput.songUrl, songbookSongInputDto.songUrl);
    expect(versionInput.tone, songbookSongInputDto.tone);
    expect(versionInput.tuning, songbookSongInputDto.tuning);
    expect(versionInput.type, songbookSongInputDto.type);
    expect(versionInput.versionLabel, songbookSongInputDto.versionLabel);
    expect(versionInput.versionId, songbookSongInputDto.versionId);
  });
}
