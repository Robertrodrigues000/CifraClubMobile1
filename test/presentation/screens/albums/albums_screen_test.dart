import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/albums/albums_bloc.dart';
import 'package:cifraclub/presentation/screens/albums/albums_screen.dart';
import 'package:cifraclub/presentation/screens/albums/albums_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../shared_mocks/domain/artist/models/album_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _AlbumsBlocMock extends Mock implements AlbumsBloc {}

void main() {
  late AlbumsBloc bloc;

  setUpAll(() {
    bloc = _AlbumsBlocMock();
    when(bloc.getAlbums).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state has albums, should display list of albums", (widgetTester) async {
    bloc.mockStream(AlbumsState(albums: [getFakeAlbum(), getFakeAlbum()]));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AlbumsBloc>.value(
          value: bloc,
          child: const AlbumsScreen(
            artistName: "Legiao Urbana",
            totalAlbums: "56",
          ),
        ),
      ),
    );

    expect(find.byType(Albums), findsOneWidget);
  });

  testWidgets("When state isLoading, should display loading circle", (widgetTester) async {
    bloc.mockStream(const AlbumsState(isLoading: true));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumsBloc>.value(
            value: bloc,
            child: const AlbumsScreen(
              artistName: "Legiao Urbana",
              totalAlbums: "56",
            ),
          ),
        ),
      );
    });
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Albums), findsNothing);
  });

  testWidgets("When state error is not null, should display error widget", (widgetTester) async {
    bloc.mockStream(AlbumsState(error: ConnectionError()));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumsBloc>.value(
            value: bloc,
            child: const AlbumsScreen(
              artistName: "Legiao Urbana",
              totalAlbums: "56",
            ),
          ),
        ),
      );
    });
    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
  });

  testWidgets("When show error widget and click to retry should retry request", (widgetTester) async {
    bloc.mockStream(AlbumsState(error: ConnectionError()));

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumsBloc>.value(
            value: bloc,
            child: const AlbumsScreen(
              artistName: "Legião Urbana",
              totalAlbums: "56",
            ),
          ),
        ),
      );
    });

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    await widgetTester.tap(find.byType(CifraClubButton));
    await widgetTester.pumpAndSettle();

    verify(() => bloc.getAlbums()).called(1);
  });
}
