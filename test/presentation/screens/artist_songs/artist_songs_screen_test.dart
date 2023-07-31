import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_screen.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_video_lesson_item.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';
import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ArtistSongsBlocMock extends Mock implements ArtistSongsBloc {}

void main() {
  late ArtistSongsBloc bloc;

  setUpAll(() {
    bloc = _ArtistSongsBlocMock();
    when(() => bloc.init()).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  // testWidgets('If searching for a term with no result, should show empty state', (widgetTester) async {
  //   bloc.mockStream(ArtistSongsState());
  //
  //   await widgetTester.pumpWidget(
  //     TestWrapper(
  //       child: BlocProvider<ArtistSongsBloc>.value(
  //         value: bloc,
  //         child: const ArtistSongsScreen(
  //           artistName: "Legiao Urbana",
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   await widgetTester.tap(find.text(appTextEn.alphabeticalOrder));
  //   await widgetTester.enterText(find.byType(TextField), 'asdfasdf');
  //   await widgetTester.pumpAndSettle();
  //
  //   expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
  // });

  testWidgets(
      'When switching to video lessons tab, if there is any video lesson, should show the search bar and the video lessons',
      (widgetTester) async {
    bloc.mockStream(ArtistSongsState(videoLessons: [getFakeVideoLessons()]));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistSongsBloc>.value(
          value: bloc,
          child: const ArtistSongsScreen(
            artistName: "Legiao Urbana",
          ),
        ),
      ),
    );

    await widgetTester.tap(find.text(appTextEn.videoLessons));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ErrorDescriptionWidget), findsNothing);
    expect(find.byType(CosmosSearchBar), findsOneWidget);
    expect(find.byType(ArtistVideoLessonItem), findsOneWidget);
  });

  testWidgets(
      'When switching to video lessons tab, if there is no video lesson, should show empty state and hide search bar',
      (widgetTester) async {
    bloc.mockStream(ArtistSongsState());

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistSongsBloc>.value(
          value: bloc,
          child: const ArtistSongsScreen(
            artistName: "Legiao Urbana",
          ),
        ),
      ),
    );

    await widgetTester.tap(find.text(appTextEn.videoLessons));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.byType(CosmosSearchBar), findsNothing);
  });

  group("When state has songs", () {
    testWidgets("should display songs in most accessed order", (widgetTester) async {
      bloc.mockStream(ArtistSongsState(songs: [getFakeArtistSong(name: "Funk rave"), getFakeArtistSong(name: "Bang")]));

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<ArtistSongsBloc>.value(
          value: bloc,
          child: const ArtistSongsScreen(artistName: "Anitta"),
        ),
      );

      expect(find.byType(ArtistSongItem), findsNWidgets(2));
    });

    testWidgets("should display songs in alphabetical order", (widgetTester) async {
      bloc.mockStream(ArtistSongsState(
          songs: [getFakeArtistSong(name: "Funk rave"), getFakeArtistSong(name: "Bang")], prefixes: ["B", "F"]));

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<ArtistSongsBloc>.value(
          value: bloc,
          child: const ArtistSongsScreen(artistName: "Anitta"),
        ),
      );

      await widgetTester.pumpAndSettle();
      var tabBar = find.byType(TabBar).evaluate().first.widget as TabBar;
      Text tab = tabBar.tabs.firstWhere((element) => (element as Text).data == appTextEn.alphabeticalOrder) as Text;
      await widgetTester.tap(find.byWidget(tab));
      await widgetTester.pumpAndSettle();

      final listItemFinder = find.byType(ArtistSongItem);
      final listItem = listItemFinder.at(0);

      final positionText = find.text("Bang");
      expect(find.descendant(of: listItem, matching: positionText), findsOneWidget);
    });
  });
}
