import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/app/model/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/presentation/screens/academy/academy_bloc.dart';
import 'package:cifraclub/presentation/screens/academy/academy_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _OpenAppOrStoreMock extends Mock implements OpenAppOrStore {}

class _IsAppInstalledMock extends Mock implements IsAppInstalled {}

void main() {
  AcademyBloc getAcademyBloc({
    _IsAppInstalledMock? isAppInstalledMock,
    _OpenAppOrStoreMock? openAppOrStoreMock,
  }) {
    return AcademyBloc(
      isAppInstalledMock ?? _IsAppInstalledMock(),
      openAppOrStoreMock ?? _OpenAppOrStoreMock(),
    );
  }

  group('When initInstructors is called', () {
    var isAppInstalledMock = _IsAppInstalledMock();
    registerFallbackValue(App.academy);
    when(() => isAppInstalledMock.call(any())).thenAnswer((_) => Future.value(true));

    blocTest(
      'should update state',
      build: () => getAcademyBloc(isAppInstalledMock: isAppInstalledMock),
      act: (bloc) => bloc.initInstructors(),
      expect: () => [
        isA<AcademyState>()
            .having((state) => state.isAcademyInstalled, "is academy installed", true)
            .having((state) => state.instructors, "instructors", isNotEmpty),
      ],
    );
  });

  test("When openAppStore is called should call use case", () async {
    final openAppOrStore = _OpenAppOrStoreMock();
    when(() => openAppOrStore.call(any())).thenAnswer((_) => Future.value());

    final bloc = getAcademyBloc(openAppOrStoreMock: openAppOrStore);
    await bloc.openAppOrStore();

    verify(() => openAppOrStore(any())).called(1);
  });
}
