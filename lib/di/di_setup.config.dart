// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i24;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i14;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i16;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i9;
import 'package:cifraclub/di/analytics_module.dart' as _i34;
import 'package:cifraclub/di/artist_module.dart' as _i35;
import 'package:cifraclub/di/firebase_module.dart' as _i29;
import 'package:cifraclub/di/genre_module.dart' as _i33;
import 'package:cifraclub/di/log_module.dart' as _i30;
import 'package:cifraclub/di/navigator_module.dart' as _i27;
import 'package:cifraclub/di/network_module.dart' as _i28;
import 'package:cifraclub/di/remote_config_module.dart' as _i32;
import 'package:cifraclub/di/time_module.dart' as _i31;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i23;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i25;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i26;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i17;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i19;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i8;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i10;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i20;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i21;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i12;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i18;
import 'package:cifraclub/presentation/navigator/app_navigator.dart' as _i13;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i3;
import 'package:cifraclub/presentation/navigator/screen_entry.dart' as _i22;
import 'package:cifraclub/presentation/navigator/screen_path_parser.dart' as _i11;
import 'package:dio/dio.dart' as _i4;
import 'package:firebase_analytics/firebase_analytics.dart' as _i15;
import 'package:firebase_core/firebase_core.dart' as _i5;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i6;
import 'package:flutter/widgets.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2; // ignore_for_file: unnecessary_lambdas

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
  final navigatorModule = _$NavigatorModule();
  final networkModule = _$NetworkModule();
  final firebaseModule = _$FirebaseModule();
  final logModule = _$LogModule();
  final timeModule = _$TimeModule();
  final remoteConfigModule = _$RemoteConfigModule();
  final genreModule = _$GenreModule();
  final analyticsModule = _$AnalyticsModule();
  final artistModule = _$ArtistModule();
  gh.factory<_i3.DeepLinkParser>(() => navigatorModule.getDeepLinkParser());
  gh.factory<_i4.Dio>(() => networkModule.getDio());
  await gh.singletonAsync<_i5.FirebaseApp>(
    () => firebaseModule.getFirebaseApp(),
    preResolve: true,
  );
  gh.singleton<_i6.FirebaseCrashlytics>(firebaseModule.getFirebaseCrashlytics(get<_i5.FirebaseApp>()));
  gh.singleton<_i7.GlobalKey<_i7.NavigatorState>>(navigatorModule.getNavigatorStateKey());
  gh.singleton<_i8.LogRepository>(logModule.getLogRepository(get<_i6.FirebaseCrashlytics>()));
  gh.factory<_i9.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.singleton<_i10.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(get<_i5.FirebaseApp>()));
  gh.factory<_i11.ScreenPathParser>(() => navigatorModule.getScreenPathParser());
  gh.factory<_i12.TimeRepository>(() => timeModule.getTimeRepository(get<_i9.NtpDataSource>()));
  gh.singleton<_i13.AppNavigator>(navigatorModule.getAppNavigator(get<_i11.ScreenPathParser>()));
  gh.singleton<_i14.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(get<_i4.Dio>()));
  gh.singleton<_i15.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i5.FirebaseApp>()));
  gh.factory<_i16.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i14.CifraClubAPINetworkService>()));
  gh.factory<_i17.GenresRepository>(() => genreModule.getGenresRepository(get<_i16.GenresDataSource>()));
  gh.factory<_i18.GetCurrentTime>(() => _i18.GetCurrentTime(get<_i12.TimeRepository>()));
  gh.factory<_i19.GetGenres>(() => _i19.GetGenres(genresRepository: get<_i17.GenresRepository>()));
  gh.factory<_i20.GetInstrumentUrls>(() => _i20.GetInstrumentUrls(get<_i10.RemoteConfigRepository>()));
  gh.factory<_i21.GetTimeBetweenInterstitials>(() => _i21.GetTimeBetweenInterstitials(get<_i10.RemoteConfigRepository>()));
  gh.factoryParam<_i7.RouteInformationParser<Object>, _i22.ScreenEntry?, dynamic>((
    firstScreen,
    _,
  ) =>
      navigatorModule.getAppRouterInformationParser(
        get<_i13.AppNavigator>(),
        get<_i11.ScreenPathParser>(),
        get<_i3.DeepLinkParser>(),
        firstScreen,
      ));
  gh.factory<_i7.RouterDelegate<Object>>(() => navigatorModule.getAppRouterDelegate(
        get<_i13.AppNavigator>(),
        get<_i7.GlobalKey<_i7.NavigatorState>>(),
      ));
  gh.factory<_i23.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i15.FirebaseAnalytics>()));
  gh.factory<_i24.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i14.CifraClubAPINetworkService>()));
  gh.factory<_i25.ArtistRepository>(() => artistModule.getGenresRepository(get<_i24.ArtistDataSource>()));
  gh.factory<_i26.GetTopArtists>(() => _i26.GetTopArtists(artistRepository: get<_i25.ArtistRepository>()));
  return get;
}

class _$NavigatorModule extends _i27.NavigatorModule {}

class _$NetworkModule extends _i28.NetworkModule {}

class _$FirebaseModule extends _i29.FirebaseModule {}

class _$LogModule extends _i30.LogModule {}

class _$TimeModule extends _i31.TimeModule {}

class _$RemoteConfigModule extends _i32.RemoteConfigModule {}

class _$GenreModule extends _i33.GenreModule {}

class _$AnalyticsModule extends _i34.AnalyticsModule {}

class _$ArtistModule extends _i35.ArtistModule {}
