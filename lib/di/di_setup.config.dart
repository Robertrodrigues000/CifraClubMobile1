// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i43;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i26;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i28;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i25;
import 'package:cifraclub/data/home/data_souce/home_data_source.dart' as _i35;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i37;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i40;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i20;
import 'package:cifraclub/di/analytics_module.dart' as _i64;
import 'package:cifraclub/di/artist_module.dart' as _i65;
import 'package:cifraclub/di/authentication_module.dart' as _i51;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i66;
import 'package:cifraclub/di/controllers_module.dart' as _i52;
import 'package:cifraclub/di/firebase_module.dart' as _i55;
import 'package:cifraclub/di/genre_module.dart' as _i60;
import 'package:cifraclub/di/home_module.dart' as _i61;
import 'package:cifraclub/di/isar_module.dart' as _i56;
import 'package:cifraclub/di/log_module.dart' as _i57;
import 'package:cifraclub/di/navigator_module.dart' as _i19;
import 'package:cifraclub/di/network_module.dart' as _i53;
import 'package:cifraclub/di/path_module.dart' as _i54;
import 'package:cifraclub/di/remote_config_module.dart' as _i59;
import 'package:cifraclub/di/search_module.dart' as _i62;
import 'package:cifraclub/di/song_module.dart' as _i63;
import 'package:cifraclub/di/time_module.dart' as _i58;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i42;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i44;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i47;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i29;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i31;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i34;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i49;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i39;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i36;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i46;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i16;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i23;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i32;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i33;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i38;
import 'package:cifraclub/domain/search/use_case/search_all_use_case.dart' as _i50;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i41;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i48;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i11;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i10;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i14;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i24;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i30;
import 'package:cifraclub/domain/user/repository/autentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i12;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i13;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i17;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i21;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i22;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/screens/dev/widgets/bottom_sheet/dev_bottom_sheet.dart' as _i45;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i27;
import 'package:firebase_core/firebase_core.dart' as _i8;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i15;
import 'package:nav/nav.dart' as _i18; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final authenticationModule = _$AuthenticationModule();
  final controllersModule = _$ControllersModule();
  final navigatorModule = _$NavigatorModule();
  final networkModule = _$NetworkModule();
  final pathModule = _$PathModule();
  final firebaseModule = _$FirebaseModule();
  final isarModule = _$IsarModule();
  final logModule = _$LogModule();
  final timeModule = _$TimeModule();
  final remoteConfigModule = _$RemoteConfigModule();
  final genreModule = _$GenreModule();
  final homeModule = _$HomeModule();
  final searchModule = _$SearchModule();
  final songModule = _$SongModule();
  final analyticsModule = _$AnalyticsModule();
  final artistModule = _$ArtistModule();
  final bottomSheetModule = _$BottomSheetModule();
  await gh.singletonAsync<_i3.AuthenticationRepository>(
    () => authenticationModule.getAuthenticationRepository(),
    preResolve: true,
  );
  gh.singleton<_i4.ColorApproximator>(controllersModule.getColorApproximator());
  gh.factory<_i5.DeepLinkParser>(() => navigatorModule.getDeepLinkParser());
  gh.factory<_i6.Dio>(() => networkModule.getDio());
  await gh.singletonAsync<_i7.Directory>(
    () => pathModule.getInternalDocument(),
    instanceName: 'InternalDocuments',
    preResolve: true,
  );
  await gh.singletonAsync<_i8.FirebaseApp>(
    () => firebaseModule.getFirebaseApp(),
    preResolve: true,
  );
  gh.singleton<_i9.FirebaseCrashlytics>(firebaseModule.getFirebaseCrashlytics(get<_i8.FirebaseApp>()));
  gh.factory<_i10.GetAllUserSongbooks>(() => _i10.GetAllUserSongbooks(get<_i11.SongbookRepository>()));
  gh.factory<_i12.GetCredential>(() => _i12.GetCredential(get<_i3.AuthenticationRepository>()));
  gh.factory<_i13.GetCredentialStream>(() => _i13.GetCredentialStream(get<_i3.AuthenticationRepository>()));
  gh.factory<_i14.InsertUserSongbook>(() => _i14.InsertUserSongbook(get<_i11.SongbookRepository>()));
  await gh.singletonAsync<_i15.Isar>(
    () => isarModule.getIsar(get<_i7.Directory>(instanceName: 'InternalDocuments')),
    preResolve: true,
  );
  gh.singleton<_i16.LogRepository>(logModule.getLogRepository(get<_i9.FirebaseCrashlytics>()));
  gh.factory<_i17.Logout>(() => _i17.Logout(get<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i18.Nav, _i19.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        get<_i5.DeepLinkParser>(),
      ));
  gh.factory<_i20.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i21.OpenLoginPage>(() => _i21.OpenLoginPage(get<_i3.AuthenticationRepository>()));
  gh.factory<_i22.OpenUserProfilePage>(() => _i22.OpenUserProfilePage(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i23.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(get<_i8.FirebaseApp>()));
  gh.factory<_i24.TimeRepository>(() => timeModule.getTimeRepository(get<_i20.NtpDataSource>()));
  gh.factory<_i25.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(get<_i15.Isar>()));
  gh.singleton<_i26.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(get<_i6.Dio>()));
  gh.singleton<_i27.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i8.FirebaseApp>()));
  gh.factory<_i28.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i26.CifraClubAPINetworkService>()));
  gh.factory<_i29.GenresRepository>(() => genreModule.getGenresRepository(
        get<_i28.GenresDataSource>(),
        get<_i25.UserGenreDataSource>(),
      ));
  gh.factory<_i30.GetCurrentTime>(() => _i30.GetCurrentTime(get<_i24.TimeRepository>()));
  gh.factory<_i31.GetGenres>(() => _i31.GetGenres(genresRepository: get<_i29.GenresRepository>()));
  gh.factory<_i32.GetInstrumentUrls>(() => _i32.GetInstrumentUrls(get<_i23.RemoteConfigRepository>()));
  gh.factory<_i33.GetTimeBetweenInterstitials>(
      () => _i33.GetTimeBetweenInterstitials(get<_i23.RemoteConfigRepository>()));
  gh.factory<_i34.GetUserGenresAsStream>(
      () => _i34.GetUserGenresAsStream(genresRepository: get<_i29.GenresRepository>()));
  gh.factory<_i35.HomeDataSource>(() => homeModule.getHomeDataSource(get<_i26.CifraClubAPINetworkService>()));
  gh.factory<_i36.HomeRepository>(() => homeModule.getHomeRepository(get<_i35.HomeDataSource>()));
  gh.factory<_i37.SearchDataSource>(() => searchModule.getGenresDataSource(get<_i26.CifraClubAPINetworkService>()));
  gh.factory<_i38.SearchRepository>(() => searchModule.getGenresRepository(get<_i37.SearchDataSource>()));
  gh.factory<_i39.SetUserGenres>(() => _i39.SetUserGenres(genresRepository: get<_i29.GenresRepository>()));
  gh.factory<_i40.SongDataSource>(() => songModule.getSongDataSource(get<_i26.CifraClubAPINetworkService>()));
  gh.factory<_i41.SongRepository>(() => songModule.getSongRepository(get<_i40.SongDataSource>()));
  gh.factory<_i42.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i27.FirebaseAnalytics>()));
  gh.factory<_i43.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i26.CifraClubAPINetworkService>()));
  gh.factory<_i44.ArtistRepository>(() => artistModule.getGenresRepository(get<_i43.ArtistDataSource>()));
  gh.factory<_i45.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(get<_i31.GetGenres>()));
  gh.factory<_i46.GetHomeInfo>(() => _i46.GetHomeInfo(get<_i36.HomeRepository>()));
  gh.factory<_i47.GetTopArtists>(() => _i47.GetTopArtists(artistRepository: get<_i44.ArtistRepository>()));
  gh.factory<_i48.GetTopSongs>(() => _i48.GetTopSongs(songRepository: get<_i41.SongRepository>()));
  gh.factory<_i49.InsertUserGenre>(() => _i49.InsertUserGenre(
        getUserGenresAsStream: get<_i34.GetUserGenresAsStream>(),
        setUserGenres: get<_i39.SetUserGenres>(),
      ));
  gh.factory<_i50.SearchAll>(() => _i50.SearchAll(searchRepository: get<_i38.SearchRepository>()));
  return get;
}

class _$AuthenticationModule extends _i51.AuthenticationModule {}

class _$ControllersModule extends _i52.ControllersModule {}

class _$NavigatorModule extends _i19.NavigatorModule {}

class _$NetworkModule extends _i53.NetworkModule {}

class _$PathModule extends _i54.PathModule {}

class _$FirebaseModule extends _i55.FirebaseModule {}

class _$IsarModule extends _i56.IsarModule {}

class _$LogModule extends _i57.LogModule {}

class _$TimeModule extends _i58.TimeModule {}

class _$RemoteConfigModule extends _i59.RemoteConfigModule {}

class _$GenreModule extends _i60.GenreModule {}

class _$HomeModule extends _i61.HomeModule {}

class _$SearchModule extends _i62.SearchModule {}

class _$SongModule extends _i63.SongModule {}

class _$AnalyticsModule extends _i64.AnalyticsModule {}

class _$ArtistModule extends _i65.ArtistModule {}

class _$BottomSheetModule extends _i66.BottomSheetModule {}
