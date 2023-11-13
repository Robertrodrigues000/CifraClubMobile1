import 'package:cifraclub/domain/artist/models/album_disc.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/album/album_bloc.dart';
import 'package:cifraclub/presentation/screens/album/album_screen.dart';
import 'package:cifraclub/presentation/screens/album/album_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../shared_mocks/domain/artist/models/album_detail_mock.dart';
import '../../../shared_mocks/domain/artist/models/album_disc_song_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _AlbumBlocMock extends Mock implements AlbumBloc {}

class _BuildContextMock extends Mock implements BuildContext {}

class _VersionOptionsBottomSheetMock extends Mock implements VersionOptionsBottomSheet {}

void main() {
  late AlbumBloc bloc;
  late VersionOptionsBottomSheet bottomSheet;

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());

    bloc = _AlbumBlocMock();
    when(bloc.getAlbumDetail).thenAnswer((_) => SynchronousFuture(null));

    final bottomSheetMock = _VersionOptionsBottomSheetMock();
    when(() => bottomSheetMock.show(
          context: any(named: 'context'),
          artistUrl: any(named: 'artistUrl'),
          songUrl: any(named: 'songUrl'),
          songId: any(named: 'songId'),
          isVersionBottomSheet: any(named: 'isVersionBottomSheet'),
          versionData: any(named: 'versionData'),
          onAction: any(named: 'onAction'),
        )).thenAnswer((_) => SynchronousFuture(null));
    bottomSheet = bottomSheetMock;

    bloc = _AlbumBlocMock();
    when(bloc.getAlbumDetail).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.shareLink(any(), any())).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state isLoading, should display loading circle", (widgetTester) async {
    bloc.mockStream(const AlbumState(isLoading: true));
    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AlbumBloc>.value(
          value: bloc,
          child: AlbumScreen(
            versionOptionsBottomSheet: bottomSheet,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ArtistSongItem), findsNothing);
  });

  testWidgets("When state error is not null, should display error widget", (widgetTester) async {
    bloc.mockStream(AlbumState(error: ServerError()));
    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AlbumBloc>.value(
          value: bloc,
          child: AlbumScreen(
            versionOptionsBottomSheet: bottomSheet,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
  });

  group("When state has discs", () {
    testWidgets("and length is 1", (widgetTester) async {
      final discs = [
        AlbumDisc(songs: [getFakeAlbumDiscSong(), getFakeAlbumDiscSong()])
      ];
      bloc.mockStream(AlbumState(discs: discs));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumBloc>.value(
            value: bloc,
            child: AlbumScreen(
              versionOptionsBottomSheet: bottomSheet,
            ),
          ),
        ),
      );

      await widgetTester.pumpAndSettle();
      expect(find.text(appTextEn.disc(1)), findsNothing);
    });

    testWidgets("and length is bigger than 1", (widgetTester) async {
      final discs = [
        AlbumDisc(songs: [getFakeAlbumDiscSong(), getFakeAlbumDiscSong()]),
        AlbumDisc(songs: [getFakeAlbumDiscSong(), getFakeAlbumDiscSong()]),
      ];
      bloc.mockStream(AlbumState(discs: discs));

      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumBloc>.value(
            value: bloc,
            child: AlbumScreen(
              versionOptionsBottomSheet: bottomSheet,
            ),
          ),
        ),
      );

      await widgetTester.pumpAndSettle();
      expect(find.text(appTextEn.disc(1)), findsOneWidget);
    });
  });

  testWidgets("When state disc songs is not null should show album songs", (widgetTester) async {
    final discs = [
      AlbumDisc(songs: [getFakeAlbumDiscSong(), getFakeAlbumDiscSong()])
    ];
    bloc.mockStream(AlbumState(discs: discs));
    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AlbumBloc>.value(
          value: bloc,
          child: AlbumScreen(
            versionOptionsBottomSheet: bottomSheet,
          ),
        ),
      ),
    );

    expect(find.byType(ArtistSongItem), findsWidgets);
  });
  testWidgets("When state disc songs is not null should show album songs", (widgetTester) async {
    final discs = [
      AlbumDisc(songs: [getFakeAlbumDiscSong(), getFakeAlbumDiscSong()])
    ];
    bloc.mockStream(AlbumState(discs: discs));
    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AlbumBloc>.value(
          value: bloc,
          child: AlbumScreen(
            versionOptionsBottomSheet: bottomSheet,
          ),
        ),
      ),
    );
    expect(find.byType(SliverList), findsAtLeastNWidgets(1));
    expect(find.byType(ArtistSongItem), findsWidgets);
  });

  group("When disc songs are displayed, ", () {
    final discs = [
      AlbumDisc(songs: [getFakeAlbumDiscSong(artistSong: getFakeArtistSong(verified: true, videoLessons: 2))])
    ];
    testWidgets("if song doesn't have any version should disable song", (widgetTester) async {
      bloc.mockStream(AlbumState(discs: discs));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumBloc>.value(
            value: bloc,
            child: AlbumScreen(
              versionOptionsBottomSheet: bottomSheet,
            ),
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      final overflowWidget = find.byWidgetPredicate(
        (Widget widget) {
          return widget is SvgPicture &&
              widget.pictureProvider is ExactAssetPicture &&
              (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.overflowIcon;
        },
        description: 'overflow icon',
      );
      expect(overflowWidget, findsNothing);
    });

    testWidgets("if song is verified should show verified icon", (widgetTester) async {
      bloc.mockStream(AlbumState(discs: discs));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumBloc>.value(
            value: bloc,
            child: AlbumScreen(
              versionOptionsBottomSheet: bottomSheet,
            ),
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(
          find.byWidgetPredicate(
            (Widget widget) {
              return widget is SvgPicture &&
                  widget.pictureProvider is ExactAssetPicture &&
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.verifiedIcon;
            },
            description: 'verified icon',
          ),
          findsOneWidget);
    });

    testWidgets("if song has video lessons should show video icon", (widgetTester) async {
      bloc.mockStream(AlbumState(discs: discs));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumBloc>.value(
            value: bloc,
            child: AlbumScreen(
              versionOptionsBottomSheet: bottomSheet,
            ),
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(
          find.byWidgetPredicate(
            (Widget widget) {
              return widget is SvgPicture &&
                  widget.pictureProvider is ExactAssetPicture &&
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.videoLessonIcon;
            },
            description: 'video lesson icon',
          ),
          findsOneWidget);
    });
  });

  testWidgets("When tapping the options icon of a album song, should show bottom sheet", (widgetTester) async {
    final discs = [
      AlbumDisc(songs: [getFakeAlbumDiscSong(artistSong: getFakeArtistSong(verified: true, videoLessons: 2))])
    ];
    bloc.mockStream(AlbumState(discs: discs));

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: TestWrapper(
            child: BlocProvider<AlbumBloc>.value(
              value: bloc,
              child: AlbumScreen(
                versionOptionsBottomSheet: bottomSheet,
              ),
            ),
          ),
        ),
      );
    });
    await widgetTester.tap(find.byKey(const Key("options-icon")));

    verify(() => bottomSheet.show(
          context: any(named: 'context'),
          artistUrl: any(named: 'artistUrl'),
          songUrl: any(named: 'songUrl'),
          songId: any(named: 'songId'),
          isVersionBottomSheet: any(named: 'isVersionBottomSheet'),
          versionData: any(named: 'versionData'),
          onAction: any(named: 'onAction'),
        )).called(1);
  });

  testWidgets('When tap in share icon should call shareLink', (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AlbumBloc>.value(
          value: bloc,
          child: AlbumScreen(
            versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
          ),
        ),
      );
    });

    expect(find.byKey(const Key('share button')), findsOneWidget);

    await widgetTester.tap(find.byKey(const Key('share button')), warnIfMissed: false);

    verify(() => bloc.shareLink(any(), any())).called(1);
  });

  testWidgets("When tap on album song, should navigate to version screen", (widgetTester) async {
    final song = getFakeAlbumDiscSong(artistSong: getFakeArtistSong(verified: true, videoLessons: 2));
    final album = getFakeAlbumDetail();
    final discs = [
      AlbumDisc(songs: [song])
    ];
    bloc.mockStream(AlbumState(discs: discs, album: album));
    final nav = NavMock.getDummy();

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<AlbumBloc>.value(
          value: bloc,
          child: AlbumScreen(
            versionOptionsBottomSheet: _VersionOptionsBottomSheetMock(),
          ),
        ),
        nav: nav,
      );
    });

    expect(find.byType(ArtistSongItem), findsOneWidget);
    await widgetTester.tap(find.byType(ArtistSongItem), warnIfMissed: false);
    verify(() =>
            VersionEntry.pushFromSong(nav, album.artistUrl, song.artistSong?.url ?? "", album.artistName, song.name))
        .called(1);
  });
}
