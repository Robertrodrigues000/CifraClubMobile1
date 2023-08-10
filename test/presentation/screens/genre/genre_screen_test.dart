import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_screen.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _GenreBlocMock extends Mock implements GenreBloc {}

void main() {
  late GenreBloc bloc;

  setUpAll(() {
    bloc = _GenreBlocMock();
    when(bloc.init).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state is GenreLoadingState, loading and genre name should be displayed", (widgetTester) async {
    bloc.mockStream(const GenreLoadingState(genreName: "genreName"));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenreBloc>.value(
          value: bloc,
          child: const GenreScreen(),
        ),
      ),
    );

    expect(find.text("genreName"), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("When state is GenreLoadedState, list and genre name should be displayed", (widgetTester) async {
    final topArtists = [getFakeArtist(), getFakeArtist()];
    bloc.mockStream(GenreLoadedState(genreName: "genreName", artists: topArtists));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenreBloc>.value(
          value: bloc,
          child: const GenreScreen(),
        ),
      ),
    );

    expect(find.text("genreName"), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text(topArtists.first.name), findsOneWidget);
  });

  testWidgets("When state is GenreErrorState, error and genre name should be displayed", (widgetTester) async {
    bloc.mockStream(GenreErrorState(genreName: "genreName", error: ServerError()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenreBloc>.value(
          value: bloc,
          child: const GenreScreen(),
        ),
      ),
    );

    expect(find.text("genreName"), findsOneWidget);
    expect(find.text("Erro"), findsOneWidget);
  });
}
