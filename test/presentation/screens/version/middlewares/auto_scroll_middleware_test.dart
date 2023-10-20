import 'package:cifraclub/domain/version/use_cases/get_auto_scroll_stream.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/auto_scroll_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _GetAutoScrollStreamMock extends Mock implements GetAutoScrollStream {}

void main() {
  test(
      'When action is OnAutoScrollStart, should emit an OnAutoScrollTickAction when the autoscroll stream emits and when OnAutoScrollStop is called, should clear subscriptions',
      () async {
    final getAutoScrollStream = _GetAutoScrollStreamMock();
    final middleware = AutoScrollMiddleware(10, getAutoScrollStream);
    var actionStream = PublishSubject<VersionAction>();
    var scrollStreamMock = PublishSubject<double>();

    when(() => getAutoScrollStream.call(
          screenDensity: any(named: "screenDensity"),
          speedFactor: any(named: "speedFactor"),
        )).thenAnswer((_) => scrollStreamMock);

    var expectation = expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnAutoScrollTickAction>().having(
          (e) => e.delta,
          "delta",
          0.42,
        ),
      ]),
    );

    middleware.onAction(OnAutoScrollStart(), const VersionState(), (action) {
      actionStream.add(action);
    });

    scrollStreamMock.add(0.42);
    scrollStreamMock.close();

    await expectation;

    actionStream.close();

    expect(middleware.subscriptions.length, 1);
    middleware.onAction(OnAutoScrollStop(), const VersionState(), (_) {});
    await Future(() => null);
    expect(middleware.subscriptions.length, 0);
  });

  test('When action is OnAutoScrollSpeedSelected, should call the getAutoScrollStream with the new speedfactor.',
      () async {
    final getAutoScrollStream = _GetAutoScrollStreamMock();
    final middleware = AutoScrollMiddleware(10, getAutoScrollStream);
    var actionStream = PublishSubject<VersionAction>();
    var scrollStreamMock = PublishSubject<double>();

    when(
      () => getAutoScrollStream.call(
        screenDensity: any(named: "screenDensity"),
        speedFactor: any(named: "speedFactor"),
      ),
    ).thenAnswer((_) => scrollStreamMock);

    middleware.onAction(
      OnAutoScrollStart(),
      const VersionState(autoScrollState: AutoScrollState(isAutoScrollRunning: true)),
      (_) {},
    );

    scrollStreamMock.add(0.42);
    verify(() => getAutoScrollStream.call(speedFactor: 0.5, screenDensity: 10)).called(1);
    verifyNever(() => getAutoScrollStream.call(speedFactor: 0.666, screenDensity: 10));

    middleware.onAction(
      OnAutoScrollSpeedSelected(0.666),
      const VersionState(autoScrollState: AutoScrollState(isAutoScrollRunning: true)),
      (_) {},
    );

    scrollStreamMock.add(0.42);
    await Future(() => null);
    verify(() => getAutoScrollStream.call(speedFactor: 0.666, screenDensity: 10)).called(1);

    scrollStreamMock.close();
    actionStream.close();
  });
}
