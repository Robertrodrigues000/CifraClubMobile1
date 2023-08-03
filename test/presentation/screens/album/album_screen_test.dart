import 'package:cifraclub/domain/artist/models/album_disc.dart';
import 'package:cifraclub/domain/artist/models/album_disc_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/album/album_bloc.dart';
import 'package:cifraclub/presentation/screens/album/album_screen.dart';
import 'package:cifraclub/presentation/screens/album/album_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../shared_mocks/domain/artist/models/album_disc_song_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _AlbumBlocMock extends Mock implements AlbumBloc {}

void main() {
  late AlbumBloc bloc;

  setUpAll(() {
    bloc = _AlbumBlocMock();
    when(bloc.getAlbumDetail).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state isLoading, should display loading circle", (widgetTester) async {
    bloc.mockStream(const AlbumState(isLoading: true));
    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<AlbumBloc>.value(
          value: bloc,
          child: const AlbumScreen(
            name: "A Tempestade",
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
          child: const AlbumScreen(
            name: "A Tempestade",
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
            child: const AlbumScreen(name: "A Tempestade"),
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
            child: const AlbumScreen(name: "A Tempestade"),
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
          child: const AlbumScreen(name: "A Tempestade"),
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
          child: const AlbumScreen(name: "A Tempestade"),
        ),
      ),
    );
    expect(find.byType(SliverList), findsAtLeastNWidgets(1));
    expect(find.byType(ArtistSongItem), findsWidgets);
  });

  group("When disc songs are displayed, ", () {
    final discs = [
      AlbumDisc(songs: [
        const AlbumDiscSong(
            disc: 1,
            id: 1,
            name: "Será",
            order: 1,
            artistSong: ArtistSong(
                id: 1,
                lyrics: 0,
                lyricsId: 0,
                name: "Será",
                bass: 0,
                drums: 0,
                guitar: 0,
                guitarpro: 0,
                harmonica: 0,
                sheet: 0,
                url: "",
                verified: true,
                videoLessons: 2))
      ])
    ];
    testWidgets("if song doesn't have any version should disable song", (widgetTester) async {
      bloc.mockStream(AlbumState(discs: discs));
      await widgetTester.pumpWidget(
        TestWrapper(
          child: BlocProvider<AlbumBloc>.value(
            value: bloc,
            child: const AlbumScreen(name: "A Tempestade"),
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
            child: const AlbumScreen(name: "A Tempestade"),
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
            child: const AlbumScreen(name: "A Tempestade"),
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
      AlbumDisc(songs: [
        const AlbumDiscSong(
            disc: 1,
            id: 1,
            name: "Será",
            order: 1,
            artistSong: ArtistSong(
                id: 1,
                lyrics: 123,
                lyricsId: 232,
                name: "Será",
                bass: 1,
                drums: 2,
                guitar: 13,
                guitarpro: 2,
                harmonica: 1,
                sheet: 0,
                url: "",
                verified: true,
                videoLessons: 2))
      ])
    ];
    bloc.mockStream(AlbumState(discs: discs));

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: TestWrapper(
            child: BlocProvider<AlbumBloc>.value(
              value: bloc,
              child: const AlbumScreen(name: "A Tempestade"),
            ),
          ),
        ),
      );
    });
    await widgetTester.tap(find.byKey(const Key("options-icon")));
    await widgetTester.pumpAndSettle();

    expect(find.byType(DefaultBottomSheet), findsOneWidget);
  });
}
