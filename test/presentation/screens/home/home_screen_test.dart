import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_screen.dart';
import 'package:cifraclub/presentation/bottom_sheets/profile_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_button.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_title.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_entry.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_entry.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../shared_mocks/domain/home/models/highlight_mock.dart';
import '../../../shared_mocks/domain/home/models/news_mock.dart';
import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';
import '../../../shared_mocks/presentation/navigator/nav_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _HomeBlocMock extends Mock implements HomeBloc {}

class _GenreBottomSheetMock extends Mock implements GenreBottomSheet {}

class _BuildContextMock extends Mock implements BuildContext {}

void main() {
  late HomeBloc bloc;
  _GenreBottomSheetMock genreBottomSheetMock = _GenreBottomSheetMock();

  setUpAll(() {
    registerFallbackValue(_BuildContextMock());
    registerFallbackValue(getFakeGenre());
    bloc = _HomeBlocMock();
    when(() => bloc.requestHomeData(genreUrl: any(named: "genreUrl"))).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.insertGenre(any())).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When user is not logged should show Log in option", (widgetTester) async {
    bloc.mockStream(const HomeState(user: null, isPro: false));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.text(appTextEn.login), findsOneWidget);
    expect(find.image(const AssetImage(AppWebp.logoCifraClub)), findsOneWidget);
  });

  testWidgets("when user is pro should show cifra club pro logo", (widgetTester) async {
    bloc.mockStream(const HomeState(user: User(), isPro: true));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.image(const AssetImage(AppWebp.logoCifraClubPro)), findsOneWidget);
  });

  testWidgets("When state isLoading is true then loading should be displayed", (widgetTester) async {
    bloc.mockStream(const HomeState(selectedGenre: "", genres: [], isLoading: true));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("When state error is not null and is connection error then error description widget should be displayed",
      (widgetTester) async {
    bloc.mockStream(HomeState(error: ConnectionError()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text("You are offline"), findsOneWidget);
  });

  testWidgets("When state error is not null and is server error then error description widget should be displayed",
      (widgetTester) async {
    bloc.mockStream(HomeState(error: ServerError()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text("Connection failure"), findsOneWidget);
  });

  testWidgets("When show error widget and click to retry should retry request", (widgetTester) async {
    bloc.mockStream(HomeState(error: ConnectionError()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    await widgetTester.tap(find.byType(CifraClubButton));
    await widgetTester.pumpAndSettle();

    verify(() => bloc.requestHomeData(genreUrl: any(named: "genreUrl"))).called(1);
  });

  testWidgets("When state isLoading is false and error is null should show home sections", (widgetTester) async {
    bloc.mockStream(HomeState(
        selectedGenre: "",
        genres: [],
        isLoading: false,
        highlights: [getFakeHighlight()],
        topArtists: [getFakeArtist()],
        topSongs: [getFakeSong()],
        videoLessons: [getFakeVideoLessons()],
        blog: [getFakeNews()]));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key("highlights"), skipOffstage: false), findsOneWidget);
    expect(find.byKey(const Key("top songs"), skipOffstage: false), findsOneWidget);
    expect(find.byKey(const Key("home top artists"), skipOffstage: false), findsOneWidget);
    expect(find.byKey(const Key("video lessons"), skipOffstage: false), findsOneWidget);
    expect(find.byKey(const Key("blog"), skipOffstage: false), findsOneWidget);
  });

  testWidgets("When state video lessons has more than 3 items, should show more button", (widgetTester) async {
    bloc.mockStream(
      HomeState(
          selectedGenre: "",
          genres: [],
          isLoading: false,
          highlights: [],
          topArtists: [],
          topSongs: [],
          videoLessons: [getFakeVideoLessons(), getFakeVideoLessons(), getFakeVideoLessons(), getFakeVideoLessons()],
          blog: []),
    );

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key("video lessons more button"), skipOffstage: false), findsOneWidget);
  });
  testWidgets("When user is log in and tap in profile photo should open bottom sheet", (widgetTester) async {
    bloc.mockStream(const HomeState(user: User()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
      ),
    );

    await widgetTester.tap(find.byKey(const Key("Open profile")));
    await widgetTester.pump();

    expect(find.byType(ProfileBottomSheet), findsOneWidget);
  });

  testWidgets("When tap in more capsule and return a genre should insert genre", (widgetTester) async {
    bloc.mockStream(const HomeState(user: User()));
    when(() => genreBottomSheetMock.open(any())).thenAnswer((_) => SynchronousFuture(getFakeGenre()));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(genreBottomSheetMock),
        ),
      ),
    );

    await widgetTester.tap(find.byType(FilterCapsule).last);
    await widgetTester.pumpAndSettle();

    verify(() => bloc.insertGenre(any())).called(1);
  });
  group("Should navigate to top songs screen", () {
    testWidgets("When tap on show more songs button", (widgetTester) async {
      bloc.mockStream(HomeState(topSongs: [getFakeSong(), getFakeSong(), getFakeSong()]));
      final nav = NavMock.getDummy();

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
        nav: nav,
      );
      final HomeButton button =
          find.byKey(const Key("top songs button"), skipOffstage: false).evaluate().first.widget as HomeButton;
      button.onTap();
      await widgetTester.pumpAndSettle();
      verify(() => nav.push(screenName: TopSongsEntry.name)).called(1);
    });

    testWidgets("When tap on top songs title", (widgetTester) async {
      bloc.mockStream(HomeState(topSongs: [getFakeSong(), getFakeSong(), getFakeSong()]));
      final nav = NavMock.getDummy();

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
        nav: nav,
      );

      final HomeTitle title =
          find.byKey(const Key("top songs title"), skipOffstage: false).evaluate().first.widget as HomeTitle;
      title.onClick!();
      await widgetTester.pumpAndSettle();
      verify(() => nav.push(screenName: TopSongsEntry.name)).called(1);
    });
  });

  group("Should navigate to top artists screen", () {
    testWidgets("When tap on show more artists button", (widgetTester) async {
      bloc.mockStream(HomeState(topArtists: [getFakeArtist(), getFakeArtist(), getFakeArtist()]));
      final nav = NavMock.getDummy();

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
        nav: nav,
      );

      final HomeButton button =
          find.byKey(const Key("top artists button"), skipOffstage: false).evaluate().first.widget as HomeButton;
      button.onTap();
      await widgetTester.pumpAndSettle();
      verify(() => nav.push(screenName: TopArtistsEntry.name)).called(1);
    });

    testWidgets("When tap on top artists title", (widgetTester) async {
      bloc.mockStream(HomeState(topArtists: [getFakeArtist(), getFakeArtist(), getFakeArtist()]));
      final nav = NavMock.getDummy();

      await widgetTester.pumpWidgetWithWrapper(
        BlocProvider<HomeBloc>.value(
          value: bloc,
          child: HomeScreen(_GenreBottomSheetMock()),
        ),
        nav: nav,
      );

      final HomeTitle title =
          find.byKey(const Key("top artists title"), skipOffstage: false).evaluate().first.widget as HomeTitle;
      title.onClick!();
      await widgetTester.pumpAndSettle();
      verify(() => nav.push(screenName: TopArtistsEntry.name)).called(1);
    });
  });
}
