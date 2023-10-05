import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_screen.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_title.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rxdart/rxdart.dart';

import '../../../shared_mocks/domain/artist/models/album_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_info_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ArtistBlocMock extends Mock implements ArtistBloc {}

class _VersionOptionsBottomSheetMock extends Mock implements VersionOptionsBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

void main() {
  late ArtistBloc bloc;
  late VersionOptionsBottomSheet bottomSheet;

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());

    bloc = _ArtistBlocMock();
    when(bloc.init).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.artistEventStream).thenAnswer((_) => PublishSubject());
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));

    final bottomSheetMock = _VersionOptionsBottomSheetMock();
    when(() => bottomSheetMock.show(
          context: any(named: 'context'),
          artistUrl: any(named: 'artistUrl'),
          songUrl: any(named: 'songUrl'),
          songId: any(named: 'songId'),
        )).thenAnswer((_) => SynchronousFuture(null));
    bottomSheet = bottomSheetMock;
  });

  testWidgets("When state has songs, should display artist songs list", (widgetTester) async {
    bloc.mockStream(ArtistState(
      songs: [
        getFakeArtistSong(),
        getFakeArtistSong(),
      ],
    ));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: ArtistScreen(
            versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
          ),
        ),
      ),
    );

    expect(find.byType(ArtistSongItem), findsNWidgets(2));
  });

  testWidgets("When state has albums, should display albums list", (widgetTester) async {
    final albums = [
      getFakeAlbum(),
      getFakeAlbum(),
    ];
    bloc.mockStream(ArtistState(albums: albums));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<ArtistBloc>.value(
            value: bloc,
            child: ArtistScreen(
              versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
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
            child: ArtistScreen(
              versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
            ),
          ),
        ),
      );
    });

    expect(find.byType(ArtistSectionTitle), findsOneWidget);
    expect(find.byType(Albums), findsNothing);
  });

  testWidgets("When state isLoading, should display loading circle", (widgetTester) async {
    bloc.mockStream(const ArtistState(isLoading: true));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<ArtistBloc>.value(
            value: bloc,
            child: ArtistScreen(
              versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
            ),
          ),
        ),
      );
    });
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ArtistSectionTitle), findsNothing);
    expect(find.byType(ArtistSongItem), findsNothing);
    expect(find.byType(Albums), findsNothing);
  });

  testWidgets("When state error is not null, should display error widget", (widgetTester) async {
    bloc.mockStream(ArtistState(error: ServerError()));
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<ArtistBloc>.value(
            value: bloc,
            child: ArtistScreen(
              versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
            ),
          ),
        ),
      );
    });
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
  });

  testWidgets("When state has instruments, should display filter capsules", (widgetTester) async {
    bloc.mockStream(const ArtistState(
      instruments: [
        Instrument.bass,
        Instrument.cavaco,
      ],
    ));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: ArtistScreen(
            versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
          ),
        ),
      ),
    );

    expect(find.byType(FilterCapsuleList), findsOneWidget);
  });

  testWidgets("When isFavorite is true, should show filled favorite icon", (widgetTester) async {
    bloc.mockStream(const ArtistState(isFavorite: true));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: ArtistScreen(
            versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
          ),
        ),
      ),
    );

    final favoriteIconFinder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.filledFavoriteIcon,
    );
    expect(favoriteIconFinder, findsOneWidget);
  });

  testWidgets("When isFavorite is false, should show favorite icon", (widgetTester) async {
    bloc.mockStream(const ArtistState(isFavorite: false));

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<ArtistBloc>.value(
            value: bloc,
            child: ArtistScreen(
              versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
            ),
          ),
        ),
      );
    });

    final favoriteIconFinder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.favoriteIcon,
    );
    expect(favoriteIconFinder, findsOneWidget);
  });

  testWidgets('When tap in share icon should call shareLink', (widgetTester) async {
    bloc.mockStream(const ArtistState());

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: ArtistScreen(
            versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
          ),
        ),
      );
    });

    final finder = find.byWidgetPredicate(
      (Widget widget) => widget is SvgImage && widget.assetPath == AppSvgs.shareIcon,
    );
    expect(finder, findsOneWidget);

    await widgetTester.tap(finder, warnIfMissed: false);

    verify(() => bloc.shareLink(any(), any())).called(1);
  });

  testWidgets("when tapping options icon of a song, should show bottom sheet", (widgetTester) async {
    bloc.mockStream(ArtistState(
      songs: [
        getFakeArtistSong(),
      ],
    ));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: ArtistScreen(
            versionOptionsBottomSheet: bottomSheet,
          ),
        ),
      ),
    );

    await widgetTester.tap(find.byKey(const Key("options-icon")));

    verify(() => bottomSheet.show(
          context: any(named: 'context'),
          artistUrl: any(named: 'artistUrl'),
          songUrl: any(named: 'songUrl'),
          songId: any(named: 'songId'),
        )).called(1);
  });

  testWidgets("when tapping song, should navigate to version screen", (widgetTester) async {
    final song = getFakeArtistSong();
    final artist = getFakeArtistInfo();
    bloc.mockStream(ArtistState(songs: [
      song,
    ], artistInfo: artist));
    final nav = NavMock.getDummy();

    await widgetTester.pumpWidget(
      TestWrapper(
        nav: nav,
        child: BlocProvider<ArtistBloc>.value(
          value: bloc,
          child: ArtistScreen(
            versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
          ),
        ),
      ),
    );

    expect(find.byType(ArtistSongItem), findsOneWidget);
    await widgetTester.tap(find.byType(ArtistSongItem), warnIfMissed: false);
    verify(() => VersionEntry.pushFromSong(nav, artist.url, song.url, artist.name, song.name)).called(1);
  });
}
