// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i5;
import 'package:cifraclub/di/navigator_module.dart' as _i11;
import 'package:cifraclub/di/time_module.dart' as _i12;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i7;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i9;
import 'package:cifraclub/presentation/navigator/app_navigator.dart' as _i8;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i3;
import 'package:cifraclub/presentation/navigator/screen_entry.dart' as _i10;
import 'package:cifraclub/presentation/navigator/screen_path_parser.dart' as _i6;
import 'package:flutter/widgets.dart' as _i4;
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
  final timeModule = _$TimeModule();
  gh.factory<_i3.DeepLinkParser>(() => navigatorModule.getDeepLinkParser());
  gh.singleton<_i4.GlobalKey<_i4.NavigatorState>>(navigatorModule.getNavigatorStateKey());
  gh.factory<_i5.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i6.ScreenPathParser>(() => navigatorModule.getScreenPathParser());
  gh.factory<_i7.TimeRepository>(() => timeModule.getTimeRepository(get<_i5.NtpDataSource>()));
  gh.singleton<_i8.AppNavigator>(navigatorModule.getAppNavigator(get<_i6.ScreenPathParser>()));
  gh.factory<_i9.GetCurrentTime>(() => _i9.GetCurrentTime(get<_i7.TimeRepository>()));
  gh.factoryParam<_i4.RouteInformationParser<Object>, _i10.ScreenEntry?, dynamic>((
    firstScreen,
    _,
  ) =>
      navigatorModule.getAppRouterInformationParser(
        get<_i8.AppNavigator>(),
        get<_i6.ScreenPathParser>(),
        get<_i3.DeepLinkParser>(),
        firstScreen,
      ));
  gh.factory<_i4.RouterDelegate<Object>>(() => navigatorModule.getAppRouterDelegate(
        get<_i8.AppNavigator>(),
        get<_i4.GlobalKey<_i4.NavigatorState>>(),
      ));
  return get;
}

class _$NavigatorModule extends _i11.NavigatorModule {}

class _$TimeModule extends _i12.TimeModule {}
