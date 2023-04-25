import 'package:cifraclub/extensions/date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When format is called, should format the DateTime with the specified pattern", () {
    final format = DateTime(2020, 1, 2, 3, 4, 5).format("yyyy-MM-dd HH:mm:ss", "pt");
    expect(format, "2020-01-02 03:04:05");
  });
}
