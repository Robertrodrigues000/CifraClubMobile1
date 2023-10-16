import 'package:cifraclub/presentation/navigator/deep_link_parser.dart';
import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/presentation/navigator/fake_screen_entry.dart';

class _MockDeepLinkParser extends Mock implements DeepLinkParser {}

void main() {
  const url = "cifraclub.com.br";

  group("when `SetScreenFromUrl.call` is invoked", () {
    final entries = [FakeScreenEntry(fakeScreenName: "testando1"), FakeScreenEntry(fakeScreenName: "testando2")];
    test("parse url and add to the stream if deepLinkParser returns entries", () {
      final parser = _MockDeepLinkParser();
      when(() => parser.parseUrl(url)).thenReturn(entries);
      final setScreenFromUrl = SetScreenFromUrl(parser);

      expectLater(OnNewScreenSet(setScreenFromUrl)(), emits(entries));
      setScreenFromUrl(url);
    });
  });
}
