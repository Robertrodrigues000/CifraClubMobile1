import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_screen.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/test_wrapper.dart';

class _MockBloc extends Mock implements GenreBloc {}

void main() {
  const topArtists = [
    Artist(
      url: "ze-ramalho",
      genre: Genre(
        id: 666,
        name: "Rock",
        url: "rock",
      ),
      image: ArtistImage(
        color: "blue",
        size162: "size162",
        size250: "size250",
        size50: "size50",
      ),
      name: "Zé Ramalho",
      id: 7507,
    ),
  ];
  const genreName = "Rock";
  late GenreBloc bloc;
  setUpAll(() {
    bloc = _MockBloc();
    when(() => bloc.genreName).thenAnswer((_) => genreName);
    when(bloc.requestTopArtists).thenAnswer((invocation) => Future.value(null));
  });

  testWidgets("When screen is on GenreLoadingState", (widgetTester) async {
    whenListen(bloc, const Stream<GenreState>.empty(), initialState: GenreLoadingState());

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenreBloc>.value(
          value: bloc,
          child: const GenreScreen(),
        ),
      ),
    );

    expect(find.text(genreName), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("When screen is on GenreLoadedState", (widgetTester) async {
    whenListen(bloc, const Stream<GenreState>.empty(), initialState: GenreLoadedState(artists: topArtists, genreName: genreName));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenreBloc>.value(
          value: bloc,
          child: const GenreScreen(),
        ),
      ),
    );

    expect(find.text(genreName), findsOneWidget);
    expect(find.text(topArtists.first.name), findsOneWidget);
  });
  testWidgets("When screen is on GenreErrorState", (widgetTester) async {
    whenListen(bloc, const Stream<GenreState>.empty(), initialState: GenreErrorState(ServerError()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenreBloc>.value(
          value: bloc,
          child: const GenreScreen(),
        ),
      ),
    );

    expect(find.text("Erro"), findsOneWidget);
  });

  testWidgets("When screen is on GenreLoadedState when genreName is initially null", (widgetTester) async {
    bloc = _MockBloc();
    when(bloc.requestTopArtists).thenAnswer((invocation) => Future.value(null));

    whenListen(bloc, const Stream<GenreState>.empty(), initialState: GenreLoadedState(artists: topArtists, genreName: genreName));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenreBloc>.value(
          value: bloc,
          child: const GenreScreen(),
        ),
      ),
    );

    expect(find.text(genreName), findsOneWidget);
  });
}
