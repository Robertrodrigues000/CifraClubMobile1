// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i57;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i32;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i34;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i29;
import 'package:cifraclub/data/home/data_souce/home_data_source.dart' as _i43;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i49;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i52;
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart' as _i54;
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart' as _i30;
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart' as _i14;
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart' as _i46;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i22;
import 'package:cifraclub/di/analytics_module.dart' as _i93;
import 'package:cifraclub/di/app_module.dart' as _i81;
import 'package:cifraclub/di/artist_module.dart' as _i94;
import 'package:cifraclub/di/authentication_module.dart' as _i75;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i95;
import 'package:cifraclub/di/controllers_module.dart' as _i76;
import 'package:cifraclub/di/device_module.dart' as _i86;
import 'package:cifraclub/di/firebase_module.dart' as _i79;
import 'package:cifraclub/di/genre_module.dart' as _i87;
import 'package:cifraclub/di/home_module.dart' as _i89;
import 'package:cifraclub/di/in_app_purchase_module.dart' as _i80;
import 'package:cifraclub/di/isar_module.dart' as _i82;
import 'package:cifraclub/di/log_module.dart' as _i83;
import 'package:cifraclub/di/navigator_module.dart' as _i21;
import 'package:cifraclub/di/network_module.dart' as _i77;
import 'package:cifraclub/di/order_module.dart' as _i90;
import 'package:cifraclub/di/path_module.dart' as _i78;
import 'package:cifraclub/di/remote_config_module.dart' as _i85;
import 'package:cifraclub/di/search_module.dart' as _i91;
import 'package:cifraclub/di/song_module.dart' as _i92;
import 'package:cifraclub/di/songbook_module.dart' as _i88;
import 'package:cifraclub/di/subscription_module.dart' as _i96;
import 'package:cifraclub/di/time_module.dart' as _i84;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i56;
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart' as _i15;
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart' as _i16;
import 'package:cifraclub/domain/app/use_cases/open_app.dart' as _i23;
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart' as _i69;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i58;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i64;
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart' as _i12;
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart' as _i28;
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart' as _i45;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i35;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i38;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i42;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i67;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i51;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i44;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i62;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i18;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i26;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i39;
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart' as _i40;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i41;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i50;
import 'package:cifraclub/domain/search/use_case/search_all_use_case.dart' as _i72;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i53;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i65;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i55;
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart' as _i31;
import 'package:cifraclub/domain/songbook/use_cases/get_all_songbooks.dart' as _i61;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i36;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i68;
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart' as _i71;
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart' as _i66;
import 'package:cifraclub/domain/subscription/repository/order_repository.dart' as _i47;
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart' as _i73;
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart' as _i63;
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart' as _i74;
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart' as _i48;
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart' as _i70;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i27;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i37;
import 'package:cifraclub/domain/user/repository/autentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i10;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i11;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i19;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i24;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i25;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/screens/dev/widgets/bottom_sheet/dev_bottom_sheet.dart' as _i59;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet.dart' as _i60;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i33;
import 'package:firebase_core/firebase_core.dart' as _i8;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:in_app_purchase/in_app_purchase.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i17;
import 'package:nav/nav.dart' as _i20; // ignore_for_file: unnecessary_lambdas

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
  final inAppPurchaseModule = _$InAppPurchaseModule();
  final appModule = _$AppModule();
  final isarModule = _$IsarModule();
  final logModule = _$LogModule();
  final timeModule = _$TimeModule();
  final remoteConfigModule = _$RemoteConfigModule();
  final deviceModule = _$DeviceModule();
  final genreModule = _$GenreModule();
  final songbookModule = _$SongbookModule();
  final homeModule = _$HomeModule();
  final orderModule = _$OrderModule();
  final searchModule = _$SearchModule();
  final songModule = _$SongModule();
  final analyticsModule = _$AnalyticsModule();
  final artistModule = _$ArtistModule();
  final bottomSheetModule = _$BottomSheetModule();
  final subscriptionModule = _$SubscriptionModule();
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
  gh.factory<_i10.GetCredential>(() => _i10.GetCredential(get<_i3.AuthenticationRepository>()));
  gh.factory<_i11.GetCredentialStream>(() => _i11.GetCredentialStream(get<_i3.AuthenticationRepository>()));
  gh.factory<_i12.GetOperatingSystem>(() => _i12.GetOperatingSystem());
  gh.singleton<_i13.InAppPurchase>(inAppPurchaseModule.getInAppPurchase());
  gh.factory<_i14.InAppPurchaseDataSource>(
      () => inAppPurchaseModule.getInAppPurchaseDataSource(get<_i13.InAppPurchase>()));
  gh.factory<_i15.InstalledAppRepository>(() => appModule.getInstalledAppRepository(get<_i12.GetOperatingSystem>()));
  gh.factory<_i16.IsAppInstalled>(
      () => _i16.IsAppInstalled(installedAppRepository: get<_i15.InstalledAppRepository>()));
  await gh.singletonAsync<_i17.Isar>(
    () => isarModule.getIsar(get<_i7.Directory>(instanceName: 'InternalDocuments')),
    preResolve: true,
  );
  gh.singleton<_i18.LogRepository>(logModule.getLogRepository(get<_i9.FirebaseCrashlytics>()));
  gh.factory<_i19.Logout>(() => _i19.Logout(get<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i20.Nav, _i21.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        get<_i5.DeepLinkParser>(),
      ));
  gh.factory<_i22.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i23.OpenApp>(() => _i23.OpenApp(installedAppRepository: get<_i15.InstalledAppRepository>()));
  gh.factory<_i24.OpenLoginPage>(() => _i24.OpenLoginPage(get<_i3.AuthenticationRepository>()));
  gh.factory<_i25.OpenUserProfilePage>(() => _i25.OpenUserProfilePage(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i26.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(get<_i8.FirebaseApp>()));
  gh.factory<_i27.TimeRepository>(() => timeModule.getTimeRepository(get<_i22.NtpDataSource>()));
  gh.factory<_i28.UrlLauncherRepository>(() => deviceModule.getUrlLauncherRepository());
  gh.factory<_i29.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(get<_i17.Isar>()));
  gh.factory<_i30.UserSongbookDataSource>(() => songbookModule.getUserSongbookDataSource(get<_i17.Isar>()));
  gh.factory<_i31.UserSongbookRepository>(
      () => songbookModule.getUserSongbookRepository(get<_i30.UserSongbookDataSource>()));
  gh.singleton<_i32.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(
    get<_i6.Dio>(),
    get<_i10.GetCredential>(),
  ));
  gh.singleton<_i33.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i8.FirebaseApp>()));
  gh.factory<_i34.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i32.CifraClubAPINetworkService>()));
  gh.factory<_i35.GenresRepository>(() => genreModule.getGenresRepository(
        get<_i34.GenresDataSource>(),
        get<_i29.UserGenreDataSource>(),
      ));
  gh.factory<_i36.GetAllUserSongbooks>(() => _i36.GetAllUserSongbooks(get<_i31.UserSongbookRepository>()));
  gh.factory<_i37.GetCurrentTime>(() => _i37.GetCurrentTime(get<_i27.TimeRepository>()));
  gh.factory<_i38.GetGenres>(() => _i38.GetGenres(genresRepository: get<_i35.GenresRepository>()));
  gh.factory<_i39.GetInstrumentUrls>(() => _i39.GetInstrumentUrls(get<_i26.RemoteConfigRepository>()));
  gh.factory<_i40.GetRemoteProductsIds>(() => _i40.GetRemoteProductsIds(get<_i26.RemoteConfigRepository>()));
  gh.factory<_i41.GetTimeBetweenInterstitials>(
      () => _i41.GetTimeBetweenInterstitials(get<_i26.RemoteConfigRepository>()));
  gh.factory<_i42.GetUserGenresAsStream>(
      () => _i42.GetUserGenresAsStream(genresRepository: get<_i35.GenresRepository>()));
  gh.factory<_i43.HomeDataSource>(() => homeModule.getHomeDataSource(get<_i32.CifraClubAPINetworkService>()));
  gh.factory<_i44.HomeRepository>(() => homeModule.getHomeRepository(get<_i43.HomeDataSource>()));
  gh.factory<_i45.OpenUrl>(() => _i45.OpenUrl(urlLauncherRepository: get<_i28.UrlLauncherRepository>()));
  gh.factory<_i46.OrderDataSource>(() => orderModule.getOrderDataSource(get<_i32.CifraClubAPINetworkService>()));
  gh.factory<_i47.OrderRepository>(() => orderModule.getOrderRepository(get<_i46.OrderDataSource>()));
  gh.factory<_i48.PostPurchaseOrder>(() => _i48.PostPurchaseOrder(get<_i47.OrderRepository>()));
  gh.factory<_i49.SearchDataSource>(() => searchModule.getGenresDataSource(get<_i32.CifraClubAPINetworkService>()));
  gh.factory<_i50.SearchRepository>(() => searchModule.getGenresRepository(get<_i49.SearchDataSource>()));
  gh.factory<_i51.SetUserGenres>(() => _i51.SetUserGenres(genresRepository: get<_i35.GenresRepository>()));
  gh.factory<_i52.SongDataSource>(() => songModule.getSongDataSource(get<_i32.CifraClubAPINetworkService>()));
  gh.factory<_i53.SongRepository>(() => songModule.getSongRepository(get<_i52.SongDataSource>()));
  gh.factory<_i54.SongbookDataSource>(
      () => songbookModule.getSongbookDataSource(get<_i32.CifraClubAPINetworkService>()));
  gh.factory<_i55.SongbookRepository>(() => songbookModule.getSongbookRepository(get<_i54.SongbookDataSource>()));
  gh.factory<_i56.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i33.FirebaseAnalytics>()));
  gh.factory<_i57.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i32.CifraClubAPINetworkService>()));
  gh.factory<_i58.ArtistRepository>(() => artistModule.getGenresRepository(get<_i57.ArtistDataSource>()));
  gh.factory<_i59.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(get<_i38.GetGenres>()));
  gh.factory<_i60.GenreBottomSheet>(() => bottomSheetModule.getGenreBottomSheet(get<_i38.GetGenres>()));
  gh.factory<_i61.GetAllSongbooks>(() => _i61.GetAllSongbooks(get<_i55.SongbookRepository>()));
  gh.factory<_i62.GetHomeInfo>(() => _i62.GetHomeInfo(get<_i44.HomeRepository>()));
  gh.factory<_i63.GetOrders>(() => _i63.GetOrders(get<_i47.OrderRepository>()));
  gh.factory<_i64.GetTopArtists>(() => _i64.GetTopArtists(artistRepository: get<_i58.ArtistRepository>()));
  gh.factory<_i65.GetTopSongs>(() => _i65.GetTopSongs(songRepository: get<_i53.SongRepository>()));
  gh.factory<_i66.InAppPurchaseRepository>(() => inAppPurchaseModule.getInAppPurchaseRepository(
        get<_i14.InAppPurchaseDataSource>(),
        get<_i48.PostPurchaseOrder>(),
        get<_i63.GetOrders>(),
      ));
  gh.factory<_i67.InsertUserGenre>(() => _i67.InsertUserGenre(
        getUserGenresAsStream: get<_i42.GetUserGenresAsStream>(),
        setUserGenres: get<_i51.SetUserGenres>(),
      ));
  gh.factory<_i68.InsertUserSongbook>(() => _i68.InsertUserSongbook(
        get<_i55.SongbookRepository>(),
        get<_i31.UserSongbookRepository>(),
      ));
  gh.factory<_i69.OpenAppOrStore>(() => _i69.OpenAppOrStore(
        openApp: get<_i23.OpenApp>(),
        openUrl: get<_i45.OpenUrl>(),
        isAppInstalled: get<_i16.IsAppInstalled>(),
        getOperatingSystem: get<_i12.GetOperatingSystem>(),
      ));
  gh.factory<_i70.PurchaseProduct>(() => _i70.PurchaseProduct(get<_i66.InAppPurchaseRepository>()));
  gh.factory<_i71.RefreshAllSongbooks>(() => _i71.RefreshAllSongbooks(
        get<_i55.SongbookRepository>(),
        get<_i31.UserSongbookRepository>(),
      ));
  gh.factory<_i72.SearchAll>(() => _i72.SearchAll(searchRepository: get<_i50.SearchRepository>()));
  gh.singleton<_i73.SubscriptionRepository>(
      subscriptionModule.getSubscriptionRepository(get<_i66.InAppPurchaseRepository>()));
  gh.factory<_i74.GetProducts>(() => _i74.GetProducts(get<_i66.InAppPurchaseRepository>()));
  return get;
}

class _$AuthenticationModule extends _i75.AuthenticationModule {}

class _$ControllersModule extends _i76.ControllersModule {}

class _$NavigatorModule extends _i21.NavigatorModule {}

class _$NetworkModule extends _i77.NetworkModule {}

class _$PathModule extends _i78.PathModule {}

class _$FirebaseModule extends _i79.FirebaseModule {}

class _$InAppPurchaseModule extends _i80.InAppPurchaseModule {}

class _$AppModule extends _i81.AppModule {}

class _$IsarModule extends _i82.IsarModule {}

class _$LogModule extends _i83.LogModule {}

class _$TimeModule extends _i84.TimeModule {}

class _$RemoteConfigModule extends _i85.RemoteConfigModule {}

class _$DeviceModule extends _i86.DeviceModule {}

class _$GenreModule extends _i87.GenreModule {}

class _$SongbookModule extends _i88.SongbookModule {}

class _$HomeModule extends _i89.HomeModule {}

class _$OrderModule extends _i90.OrderModule {}

class _$SearchModule extends _i91.SearchModule {}

class _$SongModule extends _i92.SongModule {}

class _$AnalyticsModule extends _i93.AnalyticsModule {}

class _$ArtistModule extends _i94.ArtistModule {}

class _$BottomSheetModule extends _i95.BottomSheetModule {}

class _$SubscriptionModule extends _i96.SubscriptionModule {}
