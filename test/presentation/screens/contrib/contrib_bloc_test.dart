import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';


class _OpenUrlMock extends Mock implements OpenUrl {}
void main() {
  ContribBloc getBloc({
    _OpenUrlMock? openUrl,
 }) => ContribBloc(
  openUrl ?? _OpenUrlMock(),
 );

 group("When open url is called", () {
    final openUrl = _OpenUrlMock();
    String url = "https://suporte.cifraclub.com.br/pt-BR/support/solutions/articles/64000236814-conheca-o-padr%C3%A3o-para-envio-de-cifras-e-tablaturas";
    when(() => openUrl.call(any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    blocTest(
      "should call open url use case",
      build: () => getBloc(openUrl: openUrl),
      act: (bloc) {
        bloc.openUrl(url);
      },
      verify: (bloc) {
        verify(() => openUrl(url)).called(1);
      },
    );
  });
}
