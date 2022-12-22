import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/entities/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_screen.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/test_wrapper.dart';

class _BlocMock extends Mock implements GenresBloc {}

class _UnexpectedState extends GenresState {}

void main() {
  group("When screen is on GenresInitialState", () {
    testWidgets("When screen is on GenresInitialState", (widgetTester) async {
      final bloc = _BlocMock();

      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresInitialState());

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.text(appTextEn.pressTheButtonToGetGenres), findsOneWidget);
      expect(find.text(appTextEn.getIt), findsOneWidget);
    });
  });

  group("When screen is on GenresLoadingState", () {
    testWidgets("When screen is on GenresLoadingState", (widgetTester) async {
      final bloc = _BlocMock();

      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresLoadingState());

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group("When screen is on GenresLoadedState", () {
    testWidgets("When screen is on GenresLoadedState", (widgetTester) async {
      final bloc = _BlocMock();

      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresLoadedState([const Genre(name: "Rock", url: "rock")]));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.text("Rock"), findsOneWidget);
    });
  });

  group("When screen is on GenresLoadedState with empty result", () {
    testWidgets("When screen is on GenresLoadedState with empty result", (widgetTester) async {
      final bloc = _BlocMock();

      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresLoadedState([]));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.text(appTextEn.emptyList), findsOneWidget);
    });
  });

  group("When screen is on GenresErrorState", () {
    testWidgets("When screen is on GenresErrorState", (widgetTester) async {
      final bloc = _BlocMock();

      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresErrorState(ServerError()));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.text(appTextEn.failToLoad), findsOneWidget);
    });
  });

  group("When screen is on unexpected state", () {
    testWidgets("When screen is on unexpected State", (widgetTester) async {
      final bloc = _BlocMock();

      whenListen(bloc, const Stream<GenresState>.empty(), initialState: _UnexpectedState());

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.text(appTextEn.failToLoad), findsOneWidget);
    });
  });
  group("When button is pressed, call requestGenres()", () {
    testWidgets("When screen is on GenresInitialState ", (widgetTester) async {
      final bloc = _BlocMock();
      when(bloc.requestGenres).thenAnswer((invocation) => SynchronousFuture(null));
      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresInitialState());

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      await widgetTester.tap(find.text(appTextEn.getIt));

      verify(bloc.requestGenres).called(1);
    });
  });
}
