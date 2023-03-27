import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_screen.dart';
import 'package:cifraclub/presentation/screens/home/widgets/profile_bottom_sheet/profile_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/home/home_state/home_state.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule.dart';
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet.dart';
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
    when(bloc.requestHomeData).thenAnswer((_) => SynchronousFuture(null));
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
    when(() => bloc.insertGenre(any())).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When user is not logged shoud show Log in option", (widgetTester) async {
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

  testWidgets("When state isLoading is false and error is null should show home sections", (widgetTester) async {
    bloc.mockStream(HomeState(
        selectedGenre: "",
        genres: [],
        isLoading: false,
        highlights: [getFakeHighlight()],
        topArtists: [getFakeArtist()],
        topCifras: [getFakeSong()],
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
    expect(find.byKey(const Key("top cifras"), skipOffstage: false), findsOneWidget);
    expect(find.byKey(const Key("home top artists"), skipOffstage: false), findsOneWidget);
    expect(find.byKey(const Key("videolessons"), skipOffstage: false), findsOneWidget);
    expect(find.byKey(const Key("blog"), skipOffstage: false), findsOneWidget);
  });

  testWidgets("When state videolessons has more than 3 itens, should show more button", (widgetTester) async {
    bloc.mockStream(
      HomeState(
          selectedGenre: "",
          genres: [],
          isLoading: false,
          highlights: [],
          topArtists: [],
          topCifras: [],
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

    expect(find.byKey(const Key("videolessons more button"), skipOffstage: false), findsOneWidget);
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
}
