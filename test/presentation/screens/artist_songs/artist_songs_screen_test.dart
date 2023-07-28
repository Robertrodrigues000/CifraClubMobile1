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

import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ArtistSongsBlocMock extends Mock implements ArtistSongsBloc {}

void main() {
  late ArtistSongsBloc bloc;

  setUpAll(() {
    bloc = _ArtistSongsBlocMock();
    when(() => bloc.init(any(), any())).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets('If searching for a term with no result, should show empty state', (widgetTester) async {
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

    await widgetTester.tap(find.text(appTextEn.alphabeticalOrder));
    await widgetTester.enterText(find.byType(TextField), 'asdfasdf');
    await widgetTester.pumpAndSettle();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
  });

  testWidgets(
      'When switching to videolessons tab, if there is any videolesson, should show the search bar and the videolessons',
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
      'When switching to videolessons tab, if there is no videolesson, should show empty state and hide search bar',
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
}
