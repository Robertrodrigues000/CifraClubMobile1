import 'package:cifraclub/data/home/models/video_lessons/version_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called, should correctly convert to Version", () {
    final versionDto = VersionDto(id: 123, type: 1, label: "Simplificada");

    final version = versionDto.toDomain();

    expect(version.id, versionDto.id);
    expect(version.label, versionDto.label);
    expect(version.type, versionDto.type);
  });
}
