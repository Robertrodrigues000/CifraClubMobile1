// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i13;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i15;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i9;
import 'package:cifraclub/di/analytics_module.dart' as _i27;
import 'package:cifraclub/di/firebase_module.dart' as _i23;
import 'package:cifraclub/di/genre_module.dart' as _i26;
import 'package:cifraclub/di/log_module.dart' as _i24;
import 'package:cifraclub/di/navigator_module.dart' as _i21;
import 'package:cifraclub/di/network_module.dart' as _i22;
import 'package:cifraclub/di/time_module.dart' as _i25;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i20;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i16;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i18;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i8;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i11;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i17;
import 'package:cifraclub/presentation/navigator/app_navigator.dart' as _i12;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i3;
import 'package:cifraclub/presentation/navigator/screen_entry.dart' as _i19;
import 'package:cifraclub/presentation/navigator/screen_path_parser.dart' as _i10;
import 'package:dio/dio.dart' as _i4;
import 'package:firebase_analytics/firebase_analytics.dart' as _i14;
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
  final genreModule = _$GenreModule();
  final analyticsModule = _$AnalyticsModule();
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
  gh.factory<_i10.ScreenPathParser>(() => navigatorModule.getScreenPathParser());
  gh.factory<_i11.TimeRepository>(() => timeModule.getTimeRepository(get<_i9.NtpDataSource>()));
  gh.singleton<_i12.AppNavigator>(navigatorModule.getAppNavigator(get<_i10.ScreenPathParser>()));
  gh.singleton<_i13.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(get<_i4.Dio>()));
  gh.singleton<_i14.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i5.FirebaseApp>()));
  gh.factory<_i15.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i13.CifraClubAPINetworkService>()));
  gh.factory<_i16.GenresRepository>(() => genreModule.getGenresRepository(get<_i15.GenresDataSource>()));
  gh.factory<_i17.GetCurrentTime>(() => _i17.GetCurrentTime(get<_i11.TimeRepository>()));
  gh.factory<_i18.GetGenres>(() => _i18.GetGenres(genresRepository: get<_i16.GenresRepository>()));
  gh.factoryParam<_i7.RouteInformationParser<Object>, _i19.ScreenEntry?, dynamic>((
    firstScreen,
    _,
  ) =>
      navigatorModule.getAppRouterInformationParser(
        get<_i12.AppNavigator>(),
        get<_i10.ScreenPathParser>(),
        get<_i3.DeepLinkParser>(),
        firstScreen,
      ));
  gh.factory<_i7.RouterDelegate<Object>>(() => navigatorModule.getAppRouterDelegate(
        get<_i12.AppNavigator>(),
        get<_i7.GlobalKey<_i7.NavigatorState>>(),
      ));
  gh.factory<_i20.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i14.FirebaseAnalytics>()));
  return get;
}

class _$NavigatorModule extends _i21.NavigatorModule {}

class _$NetworkModule extends _i22.NetworkModule {}

class _$FirebaseModule extends _i23.FirebaseModule {}

class _$LogModule extends _i24.LogModule {}

class _$TimeModule extends _i25.TimeModule {}

class _$GenreModule extends _i26.GenreModule {}

class _$AnalyticsModule extends _i27.AnalyticsModule {}
