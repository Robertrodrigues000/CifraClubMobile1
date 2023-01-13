import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_screen.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genre_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/test_wrapper.dart';

class _BlocMock extends Mock implements GenresBloc {}

class _UnexpectedState extends GenresState {}

void main() {
  const rock = Genre(id: 666, name: "Rock", url: "rock");
  const sertanejo = Genre(id: 9, name: "Sertanejo", url: "sertanejo");
  const gospel = Genre(id: 30, name: "Gospel/Religioso", url: "gospelreligioso");
  const mpb = Genre(id: 5, name: "MPB", url: "mpb");

  const genreItems = [
    GenreHeaderItem(type: GenreHeaderType.top),
    GenreListItem(genre: rock),
    GenreListItem(genre: sertanejo),
    GenreHeaderItem(type: GenreHeaderType.all),
    GenreListItem(genre: gospel),
    GenreListItem(genre: mpb),
  ];

  late GenresBloc bloc;
  setUpAll(() {
    bloc = _BlocMock();
    when(bloc.requestGenres).thenAnswer((invocation) => Future.value(null));
  });
  group("When screen is on GenresLoadingState", () {
    testWidgets("When screen is on GenresLoadingState", (widgetTester) async {
      when(bloc.requestGenres).thenAnswer(
        (invocation) => Future.value(null),
      );

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
      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresLoadedState(genres: genreItems));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.byType(GenreHeader), findsNWidgets(2));
      expect(find.byType(ListTile), findsNWidgets(4));
    });
  });

  group("When screen is on GenresErrorState", () {
    testWidgets("When screen is on GenresErrorState", (widgetTester) async {
      whenListen(bloc, const Stream<GenresState>.empty(), initialState: GenresErrorState(ServerError()));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.text("Erro"), findsOneWidget);
    });
  });

  group("When screen is on unexpected state", () {
    testWidgets("When screen is on unexpected State", (widgetTester) async {
      whenListen(bloc, const Stream<GenresState>.empty(), initialState: _UnexpectedState());

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<GenresBloc>.value(
            value: bloc,
            child: const GenresScreen(),
          ),
        ),
      );

      expect(find.text("Erro"), findsOneWidget);
    });
  });
}
