import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("When 'shareVersionWithConfig' is called", () {
    test("and list type is bass", () {
      final shareLink = AppUrls.shareVersionWithConfig(
        artistUrl: "artistUrl",
        songUrl: "songUrl",
        instrument: Instrument.bass,
        versionUrl: "simplificada",
      );

      expect(shareLink, "https://www.cifraclub.com.br/artistUrl/songUrl/tabs-baixo/simplificada.html");
    });

    test("and have versions config", () {
      final shareLink = AppUrls.shareVersionWithConfig(
        artistUrl: "artistUrl",
        songUrl: "songUrl",
        instrument: Instrument.guitar,
        versionUrl: "simplificada",
        capo: 2,
        key: 11,
        tuning: "Db Gb B E Ab Db",
      );

      expect(shareLink,
          "https://www.cifraclub.com.br/artistUrl/songUrl/simplificada.html#instrument=guitar&tuning=Db%20Gb%20B%20E%20Ab%20Db&capo=2&key=11");
    });
  });
}
