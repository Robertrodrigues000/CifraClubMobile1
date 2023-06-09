// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i75;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i37;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i40;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i32;
import 'package:cifraclub/data/home/data_souce/home_data_source.dart' as _i55;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i61;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i66;
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart' as _i68;
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart' as _i33;
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart' as _i14;
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart' as _i58;
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart' as _i72;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i23;
import 'package:cifraclub/di/analytics_module.dart' as _i126;
import 'package:cifraclub/di/app_module.dart' as _i112;
import 'package:cifraclub/di/artist_module.dart' as _i127;
import 'package:cifraclub/di/authentication_module.dart' as _i106;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i128;
import 'package:cifraclub/di/controllers_module.dart' as _i107;
import 'package:cifraclub/di/device_module.dart' as _i118;
import 'package:cifraclub/di/firebase_module.dart' as _i110;
import 'package:cifraclub/di/genre_module.dart' as _i119;
import 'package:cifraclub/di/home_module.dart' as _i122;
import 'package:cifraclub/di/in_app_purchase_module.dart' as _i111;
import 'package:cifraclub/di/isar_module.dart' as _i113;
import 'package:cifraclub/di/log_module.dart' as _i114;
import 'package:cifraclub/di/navigator_module.dart' as _i22;
import 'package:cifraclub/di/network_module.dart' as _i108;
import 'package:cifraclub/di/order_module.dart' as _i123;
import 'package:cifraclub/di/path_module.dart' as _i109;
import 'package:cifraclub/di/remote_config_module.dart' as _i116;
import 'package:cifraclub/di/search_module.dart' as _i124;
import 'package:cifraclub/di/shared_preferences_module.dart' as _i117;
import 'package:cifraclub/di/song_module.dart' as _i125;
import 'package:cifraclub/di/songbook_module.dart' as _i120;
import 'package:cifraclub/di/subscription_module.dart' as _i121;
import 'package:cifraclub/di/time_module.dart' as _i115;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i74;
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart' as _i16;
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart' as _i17;
import 'package:cifraclub/domain/app/use_cases/open_app.dart' as _i24;
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart' as _i96;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i76;
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart' as _i82;
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart' as _i83;
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart' as _i84;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i92;
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart' as _i12;
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart' as _i31;
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart' as _i57;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i41;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i44;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i54;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i94;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i65;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i56;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i85;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart' as _i86;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart' as _i104;
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart' as _i90;
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit_state.dart' as _i91;
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit_state_by_count.dart' as _i105;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i19;
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart' as _i29;
import 'package:cifraclub/domain/preferences/use_case/get_is_pro_preference.dart' as _i46;
import 'package:cifraclub/domain/preferences/use_case/set_is_pro_preference.dart' as _i64;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i27;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i45;
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart' as _i47;
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart' as _i49;
import 'package:cifraclub/domain/remote_config/use_cases/get_tabs_limit_constants.dart' as _i50;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i51;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i62;
import 'package:cifraclub/domain/search/use_case/search_all_use_case.dart' as _i99;
import 'package:cifraclub/domain/search/use_case/search_songs.dart' as _i63;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i67;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i93;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i69;
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart' as _i34;
import 'package:cifraclub/domain/songbook/use_cases/delete_all_cifras.dart' as _i77;
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart' as _i78;
import 'package:cifraclub/domain/songbook/use_cases/get_all_songbooks.dart' as _i81;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i42;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_cifras.dart' as _i52;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart' as _i53;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i95;
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart' as _i98;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart' as _i71;
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart' as _i35;
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart' as _i15;
import 'package:cifraclub/domain/subscription/repository/order_repository.dart' as _i59;
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart' as _i70;
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart' as _i73;
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart' as _i38;
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart' as _i87;
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart' as _i88;
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart' as _i48;
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart' as _i89;
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart' as _i60;
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart' as _i97;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart' as _i100;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart' as _i101;
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart' as _i36;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart' as _i102;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart' as _i103;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i30;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i43;
import 'package:cifraclub/domain/user/repository/autentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i10;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i11;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i20;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i25;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i26;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/screens/dev/widgets/bottom_sheet/dev_bottom_sheet.dart' as _i79;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet.dart' as _i80;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i39;
import 'package:firebase_core/firebase_core.dart' as _i8;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:in_app_purchase/in_app_purchase.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i18;
import 'package:nav/nav.dart' as _i21;
import 'package:shared_preferences/shared_preferences.dart' as _i28; // ignore_for_file: unnecessary_lambdas

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
  final sharedPreferencesModule = _$SharedPreferencesModule();
  final deviceModule = _$DeviceModule();
  final genreModule = _$GenreModule();
  final songbookModule = _$SongbookModule();
  final subscriptionModule = _$SubscriptionModule();
  final homeModule = _$HomeModule();
  final orderModule = _$OrderModule();
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
  gh.factory<_i10.GetCredential>(() => _i10.GetCredential(get<_i3.AuthenticationRepository>()));
  gh.factory<_i11.GetCredentialStream>(() => _i11.GetCredentialStream(get<_i3.AuthenticationRepository>()));
  gh.factory<_i12.GetOperatingSystem>(() => _i12.GetOperatingSystem());
  gh.singleton<_i13.InAppPurchase>(inAppPurchaseModule.getInAppPurchase());
  gh.singleton<_i14.InAppPurchaseDataSource>(inAppPurchaseModule.getInAppPurchaseDataSource(get<_i13.InAppPurchase>()));
  gh.singleton<_i15.InAppPurchaseRepository>(
      inAppPurchaseModule.getInAppPurchaseRepository(get<_i14.InAppPurchaseDataSource>()));
  gh.factory<_i16.InstalledAppRepository>(() => appModule.getInstalledAppRepository(get<_i12.GetOperatingSystem>()));
  gh.factory<_i17.IsAppInstalled>(
      () => _i17.IsAppInstalled(installedAppRepository: get<_i16.InstalledAppRepository>()));
  await gh.singletonAsync<_i18.Isar>(
    () => isarModule.getIsar(get<_i7.Directory>(instanceName: 'InternalDocuments')),
    preResolve: true,
  );
  gh.singleton<_i19.LogRepository>(logModule.getLogRepository(get<_i9.FirebaseCrashlytics>()));
  gh.factory<_i20.Logout>(() => _i20.Logout(get<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i21.Nav, _i22.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        get<_i5.DeepLinkParser>(),
      ));
  gh.factory<_i23.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i24.OpenApp>(() => _i24.OpenApp(installedAppRepository: get<_i16.InstalledAppRepository>()));
  gh.factory<_i25.OpenLoginPage>(() => _i25.OpenLoginPage(get<_i3.AuthenticationRepository>()));
  gh.factory<_i26.OpenUserProfilePage>(() => _i26.OpenUserProfilePage(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i27.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(get<_i8.FirebaseApp>()));
  await gh.singletonAsync<_i28.SharedPreferences>(
    () => sharedPreferencesModule.getSharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i29.SharedPreferencesRepository>(
      () => sharedPreferencesModule.getPreferencesRepository(get<_i28.SharedPreferences>()));
  gh.factory<_i30.TimeRepository>(() => timeModule.getTimeRepository(get<_i23.NtpDataSource>()));
  gh.factory<_i31.UrlLauncherRepository>(() => deviceModule.getUrlLauncherRepository());
  gh.factory<_i32.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(get<_i18.Isar>()));
  gh.factory<_i33.UserSongbookDataSource>(() => songbookModule.getUserSongbookDataSource(get<_i18.Isar>()));
  gh.factory<_i34.UserSongbookRepository>(
      () => songbookModule.getUserSongbookRepository(get<_i33.UserSongbookDataSource>()));
  gh.factory<_i35.ValidateSongbookName>(() => _i35.ValidateSongbookName(get<_i34.UserSongbookRepository>()));
  gh.factory<_i36.VerifyProStatus>(() => subscriptionModule.getVerifyProStatus());
  gh.singleton<_i37.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(
    get<_i6.Dio>(),
    get<_i10.GetCredential>(),
  ));
  gh.factory<_i38.CompletePurchase>(() => inAppPurchaseModule.getCompletePurchase(get<_i15.InAppPurchaseRepository>()));
  gh.singleton<_i39.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i8.FirebaseApp>()));
  gh.factory<_i40.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i41.GenresRepository>(() => genreModule.getGenresRepository(
        get<_i40.GenresDataSource>(),
        get<_i32.UserGenreDataSource>(),
      ));
  gh.factory<_i42.GetAllUserSongbooks>(() => _i42.GetAllUserSongbooks(get<_i34.UserSongbookRepository>()));
  gh.factory<_i43.GetCurrentTime>(() => _i43.GetCurrentTime(get<_i30.TimeRepository>()));
  gh.factory<_i44.GetGenres>(() => _i44.GetGenres(genresRepository: get<_i41.GenresRepository>()));
  gh.factory<_i45.GetInstrumentUrls>(() => _i45.GetInstrumentUrls(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i46.GetIsProPreference>(() => _i46.GetIsProPreference(get<_i29.SharedPreferencesRepository>()));
  gh.factory<_i47.GetListLimitConstants>(() => _i47.GetListLimitConstants(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i48.GetProducts>(() => _i48.GetProducts(get<_i15.InAppPurchaseRepository>()));
  gh.factory<_i49.GetRemoteProductsIds>(() => _i49.GetRemoteProductsIds(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i50.GetTabsLimitConstants>(() => _i50.GetTabsLimitConstants(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i51.GetTimeBetweenInterstitials>(
      () => _i51.GetTimeBetweenInterstitials(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i52.GetTotalSongbookCifras>(() => _i52.GetTotalSongbookCifras(get<_i34.UserSongbookRepository>()));
  gh.factory<_i53.GetTotalSongbooks>(() => _i53.GetTotalSongbooks(get<_i34.UserSongbookRepository>()));
  gh.factory<_i54.GetUserGenresAsStream>(
      () => _i54.GetUserGenresAsStream(genresRepository: get<_i41.GenresRepository>()));
  gh.factory<_i55.HomeDataSource>(() => homeModule.getHomeDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i56.HomeRepository>(() => homeModule.getHomeRepository(get<_i55.HomeDataSource>()));
  gh.factory<_i57.OpenUrl>(() => _i57.OpenUrl(urlLauncherRepository: get<_i31.UrlLauncherRepository>()));
  gh.factory<_i58.OrderDataSource>(() => orderModule.getOrderDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i59.OrderRepository>(() => orderModule.getOrderRepository(get<_i58.OrderDataSource>()));
  gh.factory<_i60.PostPurchaseOrder>(() => _i60.PostPurchaseOrder(get<_i59.OrderRepository>()));
  gh.factory<_i61.SearchDataSource>(() => searchModule.getGenresDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i62.SearchRepository>(() => searchModule.getGenresRepository(get<_i61.SearchDataSource>()));
  gh.factory<_i63.SearchSongs>(() => _i63.SearchSongs(searchRepository: get<_i62.SearchRepository>()));
  gh.factory<_i64.SetIsProPreference>(() => _i64.SetIsProPreference(get<_i29.SharedPreferencesRepository>()));
  gh.factory<_i65.SetUserGenres>(() => _i65.SetUserGenres(genresRepository: get<_i41.GenresRepository>()));
  gh.factory<_i66.SongDataSource>(() => songModule.getSongDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i67.SongRepository>(() => songModule.getSongRepository(get<_i66.SongDataSource>()));
  gh.factory<_i68.SongbookDataSource>(
      () => songbookModule.getSongbookDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i69.SongbookRepository>(() => songbookModule.getSongbookRepository(get<_i68.SongbookDataSource>()));
  gh.singleton<_i70.SubscriptionRepository>(subscriptionModule.getSubscriptionRepository(
    get<_i36.VerifyProStatus>(),
    get<_i46.GetIsProPreference>(),
    get<_i64.SetIsProPreference>(),
  ));
  gh.factory<_i71.UpdateSongbookData>(() => _i71.UpdateSongbookData(
        get<_i69.SongbookRepository>(),
        get<_i34.UserSongbookRepository>(),
      ));
  gh.factory<_i72.ValidatePurchaseDataSource>(
      () => inAppPurchaseModule.getValidatePurchaseDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i73.ValidatePurchaseRepository>(() => inAppPurchaseModule.getValidatePurchaseRepository(
        get<_i12.GetOperatingSystem>(),
        get<_i72.ValidatePurchaseDataSource>(),
      ));
  gh.factory<_i74.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i39.FirebaseAnalytics>()));
  gh.factory<_i75.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i37.CifraClubAPINetworkService>()));
  gh.factory<_i76.ArtistRepository>(() => artistModule.getGenresRepository(get<_i75.ArtistDataSource>()));
  gh.factory<_i77.DeleteAllCifras>(() => _i77.DeleteAllCifras(
        get<_i69.SongbookRepository>(),
        get<_i34.UserSongbookRepository>(),
      ));
  gh.factory<_i78.DeleteSongbook>(() => _i78.DeleteSongbook(
        get<_i69.SongbookRepository>(),
        get<_i34.UserSongbookRepository>(),
      ));
  gh.factory<_i79.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(get<_i44.GetGenres>()));
  gh.factory<_i80.GenreBottomSheet>(() => bottomSheetModule.getGenreBottomSheet(get<_i44.GetGenres>()));
  gh.factory<_i81.GetAllSongbooks>(() => _i81.GetAllSongbooks(get<_i69.SongbookRepository>()));
  gh.factory<_i82.GetArtistInfo>(() => _i82.GetArtistInfo(artistRepository: get<_i76.ArtistRepository>()));
  gh.factory<_i83.GetArtistSongs>(() => _i83.GetArtistSongs(artistRepository: get<_i76.ArtistRepository>()));
  gh.factory<_i84.GetArtistVideoLessons>(() => _i84.GetArtistVideoLessons(get<_i76.ArtistRepository>()));
  gh.factory<_i85.GetHomeInfo>(() => _i85.GetHomeInfo(get<_i56.HomeRepository>()));
  gh.factory<_i86.GetListLimit>(() => _i86.GetListLimit(get<_i47.GetListLimitConstants>()));
  gh.factory<_i87.GetOrders>(() => _i87.GetOrders(get<_i59.OrderRepository>()));
  gh.factory<_i88.GetProStatusStream>(() => _i88.GetProStatusStream(get<_i70.SubscriptionRepository>()));
  gh.factory<_i89.GetRemoteProStatus>(() => subscriptionModule.getRemoteProStatus(get<_i87.GetOrders>()));
  gh.factory<_i90.GetTabsLimit>(() => _i90.GetTabsLimit(get<_i50.GetTabsLimitConstants>()));
  gh.factory<_i91.GetTabsLimitState>(() => _i91.GetTabsLimitState(
        get<_i52.GetTotalSongbookCifras>(),
        get<_i90.GetTabsLimit>(),
        get<_i88.GetProStatusStream>(),
        get<_i50.GetTabsLimitConstants>(),
      ));
  gh.factory<_i92.GetTopArtists>(() => _i92.GetTopArtists(artistRepository: get<_i76.ArtistRepository>()));
  gh.factory<_i93.GetTopSongs>(() => _i93.GetTopSongs(songRepository: get<_i67.SongRepository>()));
  gh.factory<_i94.InsertUserGenre>(() => _i94.InsertUserGenre(
        getUserGenresAsStream: get<_i54.GetUserGenresAsStream>(),
        setUserGenres: get<_i65.SetUserGenres>(),
      ));
  gh.factory<_i95.InsertUserSongbook>(() => _i95.InsertUserSongbook(
        get<_i69.SongbookRepository>(),
        get<_i34.UserSongbookRepository>(),
      ));
  gh.factory<_i96.OpenAppOrStore>(() => _i96.OpenAppOrStore(
        openApp: get<_i24.OpenApp>(),
        openUrl: get<_i57.OpenUrl>(),
        isAppInstalled: get<_i17.IsAppInstalled>(),
        getOperatingSystem: get<_i12.GetOperatingSystem>(),
      ));
  gh.factory<_i97.PurchaseProduct>(() => _i97.PurchaseProduct(
        get<_i15.InAppPurchaseRepository>(),
        get<_i70.SubscriptionRepository>(),
      ));
  gh.factory<_i98.RefreshAllSongbooks>(() => _i98.RefreshAllSongbooks(
        get<_i69.SongbookRepository>(),
        get<_i34.UserSongbookRepository>(),
      ));
  gh.factory<_i99.SearchAll>(() => _i99.SearchAll(searchRepository: get<_i62.SearchRepository>()));
  gh.factory<_i100.ValidatePurchase>(() => inAppPurchaseModule.getValidatePurchase(
        get<_i10.GetCredential>(),
        get<_i60.PostPurchaseOrder>(),
        get<_i73.ValidatePurchaseRepository>(),
      ));
  gh.factory<_i101.ValidatePurchases>(() => inAppPurchaseModule.getValidatePurchases(
        get<_i100.ValidatePurchase>(),
        get<_i38.CompletePurchase>(),
      ));
  gh.singleton<_i102.WatchForPurchases>(inAppPurchaseModule.getWatchForPurchases(
    get<_i15.InAppPurchaseRepository>(),
    get<_i70.SubscriptionRepository>(),
    get<_i101.ValidatePurchases>(),
  ));
  gh.singleton<_i103.WatchForSubscriptions>(subscriptionModule.getWatchForSubscriptions(
    get<_i11.GetCredentialStream>(),
    get<_i70.SubscriptionRepository>(),
    get<_i15.InAppPurchaseRepository>(),
    get<_i89.GetRemoteProStatus>(),
  ));
  gh.factory<_i104.GetListLimitState>(() => _i104.GetListLimitState(
        get<_i53.GetTotalSongbooks>(),
        get<_i88.GetProStatusStream>(),
        get<_i86.GetListLimit>(),
        get<_i47.GetListLimitConstants>(),
      ));
  gh.factory<_i105.GetTabLimitStateByCount>(() => _i105.GetTabLimitStateByCount(
        get<_i90.GetTabsLimit>(),
        get<_i50.GetTabsLimitConstants>(),
      ));
  return get;
}

class _$AuthenticationModule extends _i106.AuthenticationModule {}

class _$ControllersModule extends _i107.ControllersModule {}

class _$NavigatorModule extends _i22.NavigatorModule {}

class _$NetworkModule extends _i108.NetworkModule {}

class _$PathModule extends _i109.PathModule {}

class _$FirebaseModule extends _i110.FirebaseModule {}

class _$InAppPurchaseModule extends _i111.InAppPurchaseModule {}

class _$AppModule extends _i112.AppModule {}

class _$IsarModule extends _i113.IsarModule {}

class _$LogModule extends _i114.LogModule {}

class _$TimeModule extends _i115.TimeModule {}

class _$RemoteConfigModule extends _i116.RemoteConfigModule {}

class _$SharedPreferencesModule extends _i117.SharedPreferencesModule {}

class _$DeviceModule extends _i118.DeviceModule {}

class _$GenreModule extends _i119.GenreModule {}

class _$SongbookModule extends _i120.SongbookModule {}

class _$SubscriptionModule extends _i121.SubscriptionModule {}

class _$HomeModule extends _i122.HomeModule {}

class _$OrderModule extends _i123.OrderModule {}

class _$SearchModule extends _i124.SearchModule {}

class _$SongModule extends _i125.SongModule {}

class _$AnalyticsModule extends _i126.AnalyticsModule {}

class _$ArtistModule extends _i127.ArtistModule {}

class _$BottomSheetModule extends _i128.BottomSheetModule {}
