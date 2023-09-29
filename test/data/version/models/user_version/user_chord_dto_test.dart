import 'package:cifraclub/data/version/models/user_version/user_chord_dto.dart';
import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    final chord = Chord(
      name: "chrod",
      shapeName: "alt",
      guitar: ["A B"],
      cavaco: ["A E"],
      ukulele: ["A T"],
      keyboard: ["A E"],
      viola: ["A E"],
      violaMi: ["A E"],
      violaRa: ["A E"],
    );

    final userChordDto = UserChordDto.fromDomain(chord);

    expect(userChordDto.name, "chrod");
    expect(userChordDto.shapeName, "alt");
    expect(userChordDto.guitar, ["A B"]);
    expect(userChordDto.cavaco, ["A E"]);
    expect(userChordDto.ukulele, ["A T"]);
    expect(userChordDto.keyboard, ["A E"]);
    expect(userChordDto.viola, ["A E"]);
    expect(userChordDto.violaMi, ["A E"]);
    expect(userChordDto.violaRa, ["A E"]);
  });
}
