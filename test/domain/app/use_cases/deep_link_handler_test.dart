import 'package:cifraclub/domain/app/use_cases/deep_link_handler.dart';
import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SetScreenFromUrlMock extends Mock implements SetScreenFromUrl {}

void main() {
  test('when consumeOrGetFirstDeepLink is called should return getInitialDeepLink use case result', () async {
    const initialDeepLink = "https://m.cifraclub.com.br/musico/546085489/repertorio/10377538";
    final setScreenFromUrl = SetScreenFromUrlMock();
    final deepLinkHandler = DeepLinkHandler(
      getInitialDeepLink: () => Future.value(initialDeepLink),
      setScreenFromUrl: setScreenFromUrl,
      deepLinkStream: const Stream.empty(),
    );

    final deepLink = await deepLinkHandler.consumeOrGetFirstDeepLink();

    expect(deepLink, initialDeepLink);
  });

  test('when handleDeepLinks is called and stream has deepLinks should call SetScreenFromUrl use case', () async {
    final deepLinkStream = Stream.fromIterable(["https://m.cifraclub.com.br/musico/546085489/repertorio/10377538"]);
    final setScreenFromUrl = SetScreenFromUrlMock();
    when(() => setScreenFromUrl.call(any())).thenAnswer((_) => SynchronousFuture(null));
    final deepLinkHandler = DeepLinkHandler(
      getInitialDeepLink: () => Future.value(null),
      setScreenFromUrl: setScreenFromUrl,
      deepLinkStream: deepLinkStream,
    );

    await deepLinkHandler.handleDeepLinks();

    verify(() => setScreenFromUrl.call(any())).called(1);
  });
}
