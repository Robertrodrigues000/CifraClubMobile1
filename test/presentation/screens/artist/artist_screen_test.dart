import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_screen.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _MockArtistBloc extends Mock implements ArtistBloc {}

void main() {
  late ArtistBloc bloc;

  setUpAll(() {
    bloc = _MockArtistBloc();
    when(bloc.getArtistSongs).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When ArtistScreen is show,artist name should be displayed", (widgetTester) async {
    bloc.mockStream(const ArtistState());

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: const ArtistScreen(
            name: "Teste",
          ),
        ),
      ),
    );

    expect(find.text("Teste"), findsOneWidget);
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
}
