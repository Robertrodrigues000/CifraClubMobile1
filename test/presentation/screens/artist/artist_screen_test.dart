import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_screen.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../shared_mocks/domain/artist/models/album_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ArtistBlocMock extends Mock implements ArtistBloc {}

void main() {
  late ArtistBloc bloc;

  setUpAll(() {
    bloc = _ArtistBlocMock();
    when(bloc.getArtistSongs).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.getArtistInfo).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.getAlbums).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state has songs, should display artist songs list", (widgetTester) async {
    bloc.mockStream(ArtistState(songs: [getFakeArtistSong(), getFakeArtistSong()]));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: const ArtistScreen(
            name: "Legiao Urbana",
          ),
        ),
      ),
    );

    expect(find.byType(ArtistSongItem), findsNWidgets(2));
  });

  testWidgets("When state has albums, should display albums list", (widgetTester) async {
    final albums = [getFakeAlbum(), getFakeAlbum()];
    bloc.mockStream(ArtistState(albums: albums));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<ArtistBloc>.value(
            value: bloc,
            child: const ArtistScreen(
              name: "Legiao Urbana",
            ),
          ),
        ),
      );
    });
    expect(find.byKey(Key(albums.first.albumUrl)), findsOneWidget);
    expect(find.byKey(Key(albums.last.albumUrl), skipOffstage: false), findsOneWidget);
  });

  testWidgets("When state albums is empty should not display albums list", (widgetTester) async {
    bloc.mockStream(const ArtistState(albums: []));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<ArtistBloc>.value(
            value: bloc,
            child: const ArtistScreen(
              name: "Legiao Urbana",
            ),
          ),
        ),
      );
    });

    expect(find.byType(ArtistSectionTitle), findsOneWidget);
    expect(find.byType(Albums), findsNothing);
  });
}
