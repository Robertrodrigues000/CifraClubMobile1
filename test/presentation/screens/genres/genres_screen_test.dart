import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_screen.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genres_list.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _GenresBlocMock extends Mock implements GenresBloc {}

void main() {
  late GenresBloc bloc;

  setUpAll(() {
    bloc = _GenresBlocMock();
    when(bloc.init).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state is GenresLoadingState, a loading be displayed", (widgetTester) async {
    bloc.mockStream(GenresLoadingState());

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenresBloc>.value(
          value: bloc,
          child: const GenresScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(GenresList), findsNothing);
  });

  testWidgets("When state is GenresLoadedState, a genres list should be displayed", (widgetTester) async {
    List<GenreItem> genreItems = [
      const GenreHeaderItem(type: GenreHeaderType.top),
      GenreListItem(genre: getFakeGenre()),
      GenreListItem(genre: getFakeGenre()),
      GenreDivider(),
      const GenreHeaderItem(type: GenreHeaderType.all),
      GenreListItem(genre: getFakeGenre()),
      GenreListItem(genre: getFakeGenre()),
    ];
    bloc.mockStream(GenresLoadedState(genres: genreItems));

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: BlocProvider<GenresBloc>.value(
          value: bloc,
          child: const GenresScreen(),
        ),
      ));
    });

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(GenresList), findsOneWidget);
  });

  testWidgets("When state is GenresErrorState, an error should be displayed", (widgetTester) async {
    bloc.mockStream(GenresErrorState(ServerError()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenresBloc>.value(
          value: bloc,
          child: const GenresScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(GenresList), findsNothing);
    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
  });

  testWidgets("When show error widget and click to retry should retry request", (widgetTester) async {
    bloc.mockStream(GenresErrorState(ConnectionError()));
    when(() => bloc.requestGenres()).thenAnswer((_) => SynchronousFuture(null));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<GenresBloc>.value(
          value: bloc,
          child: const GenresScreen(),
        ),
      ),
    );

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    await widgetTester.tap(find.byType(CifraClubButton));
    await widgetTester.pumpAndSettle();

    verify(() => bloc.requestGenres()).called(1);
  });
}
