// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i30;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i19;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i21;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i27;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i14;
import 'package:cifraclub/di/analytics_module.dart' as _i42;
import 'package:cifraclub/di/artist_module.dart' as _i43;
import 'package:cifraclub/di/authentication_module.dart' as _i34;
import 'package:cifraclub/di/firebase_module.dart' as _i36;
import 'package:cifraclub/di/genre_module.dart' as _i40;
import 'package:cifraclub/di/log_module.dart' as _i37;
import 'package:cifraclub/di/navigator_module.dart' as _i13;
import 'package:cifraclub/di/network_module.dart' as _i35;
import 'package:cifraclub/di/remote_config_module.dart' as _i39;
import 'package:cifraclub/di/song_module.dart' as _i41;
import 'package:cifraclub/di/time_module.dart' as _i38;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i29;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i31;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i32;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i22;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i24;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i10;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i17;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i25;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i26;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i28;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i33;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i18;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i23;
import 'package:cifraclub/domain/user/repository/autentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i8;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i9;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i11;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i15;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i16;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i4;
import 'package:dio/dio.dart' as _i5;
import 'package:firebase_analytics/firebase_analytics.dart' as _i20;
import 'package:firebase_core/firebase_core.dart' as _i6;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nav/nav.dart' as _i12; // ignore_for_file: unnecessary_lambdas

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
  final navigatorModule = _$NavigatorModule();
  final networkModule = _$NetworkModule();
  final firebaseModule = _$FirebaseModule();
  final logModule = _$LogModule();
  final timeModule = _$TimeModule();
  final remoteConfigModule = _$RemoteConfigModule();
  final genreModule = _$GenreModule();
  final songModule = _$SongModule();
  final analyticsModule = _$AnalyticsModule();
  final artistModule = _$ArtistModule();
  await gh.singletonAsync<_i3.AuthenticationRepository>(
    () => authenticationModule.getAuthenticationRepository(),
    preResolve: true,
  );
  gh.factory<_i4.DeepLinkParser>(() => navigatorModule.getDeepLinkParser());
  gh.factory<_i5.Dio>(() => networkModule.getDio());
  await gh.singletonAsync<_i6.FirebaseApp>(
    () => firebaseModule.getFirebaseApp(),
    preResolve: true,
  );
  gh.singleton<_i7.FirebaseCrashlytics>(firebaseModule.getFirebaseCrashlytics(get<_i6.FirebaseApp>()));
  gh.factory<_i8.GetCredential>(() => _i8.GetCredential(get<_i3.AuthenticationRepository>()));
  gh.factory<_i9.GetCredentialStream>(() => _i9.GetCredentialStream(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i10.LogRepository>(logModule.getLogRepository(get<_i7.FirebaseCrashlytics>()));
  gh.factory<_i11.Logout>(() => _i11.Logout(get<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i12.Nav, _i13.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        get<_i4.DeepLinkParser>(),
      ));
  gh.factory<_i14.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i15.OpenLoginPage>(() => _i15.OpenLoginPage(get<_i3.AuthenticationRepository>()));
  gh.factory<_i16.OpenUserProfilePage>(() => _i16.OpenUserProfilePage(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i17.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(get<_i6.FirebaseApp>()));
  gh.factory<_i18.TimeRepository>(() => timeModule.getTimeRepository(get<_i14.NtpDataSource>()));
  gh.singleton<_i19.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(get<_i5.Dio>()));
  gh.singleton<_i20.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i6.FirebaseApp>()));
  gh.factory<_i21.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i19.CifraClubAPINetworkService>()));
  gh.factory<_i22.GenresRepository>(() => genreModule.getGenresRepository(get<_i21.GenresDataSource>()));
  gh.factory<_i23.GetCurrentTime>(() => _i23.GetCurrentTime(get<_i18.TimeRepository>()));
  gh.factory<_i24.GetGenres>(() => _i24.GetGenres(genresRepository: get<_i22.GenresRepository>()));
  gh.factory<_i25.GetInstrumentUrls>(() => _i25.GetInstrumentUrls(get<_i17.RemoteConfigRepository>()));
  gh.factory<_i26.GetTimeBetweenInterstitials>(() => _i26.GetTimeBetweenInterstitials(get<_i17.RemoteConfigRepository>()));
  gh.factory<_i27.SongDataSource>(() => songModule.getSongDataSource(get<_i19.CifraClubAPINetworkService>()));
  gh.factory<_i28.SongRepository>(() => songModule.getSongRepository(get<_i27.SongDataSource>()));
  gh.factory<_i29.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i20.FirebaseAnalytics>()));
  gh.factory<_i30.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i19.CifraClubAPINetworkService>()));
  gh.factory<_i31.ArtistRepository>(() => artistModule.getGenresRepository(get<_i30.ArtistDataSource>()));
  gh.factory<_i32.GetTopArtists>(() => _i32.GetTopArtists(artistRepository: get<_i31.ArtistRepository>()));
  gh.factory<_i33.GetTopSongs>(() => _i33.GetTopSongs(songRepository: get<_i28.SongRepository>()));
  return get;
}

class _$AuthenticationModule extends _i34.AuthenticationModule {}

class _$NavigatorModule extends _i13.NavigatorModule {}

class _$NetworkModule extends _i35.NetworkModule {}

class _$FirebaseModule extends _i36.FirebaseModule {}

class _$LogModule extends _i37.LogModule {}

class _$TimeModule extends _i38.TimeModule {}

class _$RemoteConfigModule extends _i39.RemoteConfigModule {}

class _$GenreModule extends _i40.GenreModule {}

class _$SongModule extends _i41.SongModule {}

class _$AnalyticsModule extends _i42.AnalyticsModule {}

class _$ArtistModule extends _i43.ArtistModule {}
