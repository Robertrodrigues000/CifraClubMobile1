// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i10;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i11;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i6;
import 'package:cifraclub/di/genre_module.dart' as _i19;
import 'package:cifraclub/di/navigator_module.dart' as _i16;
import 'package:cifraclub/di/network_module.dart' as _i17;
import 'package:cifraclub/di/time_module.dart' as _i18;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i12;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i14;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i8;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i13;
import 'package:cifraclub/presentation/navigator/app_navigator.dart' as _i9;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i3;
import 'package:cifraclub/presentation/navigator/screen_entry.dart' as _i15;
import 'package:cifraclub/presentation/navigator/screen_path_parser.dart' as _i7;
import 'package:dio/dio.dart' as _i4;
import 'package:flutter/widgets.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final navigatorModule = _$NavigatorModule();
  final networkModule = _$NetworkModule();
  final timeModule = _$TimeModule();
  final genreModule = _$GenreModule();
  gh.factory<_i3.DeepLinkParser>(() => navigatorModule.getDeepLinkParser());
  gh.factory<_i4.Dio>(() => networkModule.getDio());
  gh.singleton<_i5.GlobalKey<_i5.NavigatorState>>(navigatorModule.getNavigatorStateKey());
  gh.factory<_i6.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i7.ScreenPathParser>(() => navigatorModule.getScreenPathParser());
  gh.factory<_i8.TimeRepository>(() => timeModule.getTimeRepository(get<_i6.NtpDataSource>()));
  gh.singleton<_i9.AppNavigator>(navigatorModule.getAppNavigator(get<_i7.ScreenPathParser>()));
  gh.singleton<_i10.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(get<_i4.Dio>()));
  gh.factory<_i11.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i10.CifraClubAPINetworkService>()));
  gh.factory<_i12.GenresRepository>(() => genreModule.getGenresRepository(get<_i11.GenresDataSource>()));
  gh.factory<_i13.GetCurrentTime>(() => _i13.GetCurrentTime(get<_i8.TimeRepository>()));
  gh.factory<_i14.GetGenres>(() => _i14.GetGenres(genresRepository: get<_i12.GenresRepository>()));
  gh.factoryParam<_i5.RouteInformationParser<Object>, _i15.ScreenEntry?, dynamic>((
    firstScreen,
    _,
  ) =>
      navigatorModule.getAppRouterInformationParser(
        get<_i9.AppNavigator>(),
        get<_i7.ScreenPathParser>(),
        get<_i3.DeepLinkParser>(),
        firstScreen,
      ));
  gh.factory<_i5.RouterDelegate<Object>>(() => navigatorModule.getAppRouterDelegate(
        get<_i9.AppNavigator>(),
        get<_i5.GlobalKey<_i5.NavigatorState>>(),
      ));
  return get;
}

class _$NavigatorModule extends _i16.NavigatorModule {}

class _$NetworkModule extends _i17.NetworkModule {}

class _$TimeModule extends _i18.TimeModule {}

class _$GenreModule extends _i19.GenreModule {}
