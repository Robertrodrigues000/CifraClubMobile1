import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_song_image.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_songs.dart';
import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/widgets/library_song_tile.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/widgets/youtube_video_tile.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shared_mocks/domain/song/models/local_song_mock.dart';
import '../../../shared_mocks/domain/youtube/models/youtube_video_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ListenBottomSheetBlocMock extends Mock implements ListenBottomSheetBloc {}

class _GetYouTubeVideosMock extends Mock implements GetYouTubeVideos {}

class _GetLocalSongsMock extends Mock implements GetLocalSongs {}

class _GetLocalSongImageMock extends Mock implements GetLocalSongImage {}

void main() {
  late _ListenBottomSheetBlocMock bloc;

  setUpAll(() {
    bloc = _ListenBottomSheetBlocMock();
    when(() => bloc.getImage(any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.getLocalSongs()).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.getYouTubeVideos()).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When tap on tab bar should change to corretly tab", (widgetTester) async {
    bloc.mockStream(
      ListenBottomSheetState(
        youtubeVideos: [getFakeYouTubeVideo(), getFakeYouTubeVideo()],
        localSongs: [getFakeLocalSong(), getFakeLocalSong()],
      ),
    );

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () {
                ListenBottomSheet(
                  _GetYouTubeVideosMock(),
                  _GetLocalSongImageMock(),
                  _GetLocalSongsMock(),
                ).open(context: context, bloc: bloc, artistName: "", songName: "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(YouTubeVideoTile), findsNWidgets(2));

    await widgetTester.tap(find.text(appTextEn.library));
    await widgetTester.pumpAndSettle();
    expect(find.byType(LibrarySongTile), findsNWidgets(2));
  });

  testWidgets("While youtube requesting should show the loading indicator", (widgetTester) async {
    bloc.mockStream(const ListenBottomSheetState(isLoadingYoutube: true));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () {
                ListenBottomSheet(
                  _GetYouTubeVideosMock(),
                  _GetLocalSongImageMock(),
                  _GetLocalSongsMock(),
                ).open(context: context, bloc: bloc, artistName: "", songName: "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pump();

    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  testWidgets("When an error occurs in the youtube request should show error widget", (widgetTester) async {
    bloc.mockStream(ListenBottomSheetState(youtubeError: ServerError(statusCode: 404)));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () {
                ListenBottomSheet(
                  _GetYouTubeVideosMock(),
                  _GetLocalSongImageMock(),
                  _GetLocalSongsMock(),
                ).open(context: context, bloc: bloc, artistName: "", songName: "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pump();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
  });

  testWidgets("When youtube video is empty should show error widget", (widgetTester) async {
    bloc.mockStream(const ListenBottomSheetState(youtubeVideos: []));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () {
                ListenBottomSheet(
                  _GetYouTubeVideosMock(),
                  _GetLocalSongImageMock(),
                  _GetLocalSongsMock(),
                ).open(context: context, bloc: bloc, artistName: "", songName: "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pump();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text(appTextEn.youtubeResultNotFound), findsOneWidget);
  });

  testWidgets("When an error occurs in the local songs request should show error widget", (widgetTester) async {
    bloc.mockStream(ListenBottomSheetState(localSongsError: LocalSongPermissionError(PermissionStatus.denied)));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () {
                ListenBottomSheet(
                  _GetYouTubeVideosMock(),
                  _GetLocalSongImageMock(),
                  _GetLocalSongsMock(),
                ).open(context: context, bloc: bloc, artistName: "", songName: "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(appTextEn.library));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text(appTextEn.localSongsPermissionDenied), findsOneWidget);
  });

  testWidgets("When local songs is empty should show error widget", (widgetTester) async {
    bloc.mockStream(const ListenBottomSheetState(localSongs: []));

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () {
                ListenBottomSheet(
                  _GetYouTubeVideosMock(),
                  _GetLocalSongImageMock(),
                  _GetLocalSongsMock(),
                ).open(context: context, bloc: bloc, artistName: "", songName: "");
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text(appTextEn.library));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text(appTextEn.localSongsResultNotFound), findsOneWidget);
  });
}
