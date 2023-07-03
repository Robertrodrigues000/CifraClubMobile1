// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i83;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i41;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i44;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i34;
import 'package:cifraclub/data/home/data_source/home_data_source.dart' as _i60;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i66;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i72;
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart' as _i74;
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart' as _i35;
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart' as _i15;
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart' as _i63;
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart' as _i79;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i24;
import 'package:cifraclub/data/version/data_source/user_version_data_source.dart' as _i37;
import 'package:cifraclub/di/analytics_module.dart' as _i137;
import 'package:cifraclub/di/app_module.dart' as _i123;
import 'package:cifraclub/di/artist_module.dart' as _i138;
import 'package:cifraclub/di/authentication_module.dart' as _i116;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i139;
import 'package:cifraclub/di/controllers_module.dart' as _i117;
import 'package:cifraclub/di/device_module.dart' as _i129;
import 'package:cifraclub/di/firebase_module.dart' as _i121;
import 'package:cifraclub/di/genre_module.dart' as _i130;
import 'package:cifraclub/di/home_module.dart' as _i133;
import 'package:cifraclub/di/in_app_purchase_module.dart' as _i122;
import 'package:cifraclub/di/isar_module.dart' as _i124;
import 'package:cifraclub/di/log_module.dart' as _i125;
import 'package:cifraclub/di/navigator_module.dart' as _i23;
import 'package:cifraclub/di/network_module.dart' as _i118;
import 'package:cifraclub/di/order_module.dart' as _i134;
import 'package:cifraclub/di/path_module.dart' as _i119;
import 'package:cifraclub/di/remote_config_module.dart' as _i127;
import 'package:cifraclub/di/search_module.dart' as _i135;
import 'package:cifraclub/di/shared_preferences_module.dart' as _i128;
import 'package:cifraclub/di/song_module.dart' as _i136;
import 'package:cifraclub/di/songbook_module.dart' as _i120;
import 'package:cifraclub/di/subscription_module.dart' as _i132;
import 'package:cifraclub/di/time_module.dart' as _i126;
import 'package:cifraclub/di/version_module.dart' as _i131;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i82;
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart' as _i17;
import 'package:cifraclub/domain/app/repository/share_link_repository.dart' as _i29;
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart' as _i18;
import 'package:cifraclub/domain/app/use_cases/open_app.dart' as _i25;
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart' as _i106;
import 'package:cifraclub/domain/app/use_cases/share_link.dart' as _i71;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i84;
import 'package:cifraclub/domain/artist/use_cases/get_album_detail.dart' as _i90;
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart' as _i91;
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart' as _i92;
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart' as _i93;
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart' as _i94;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i100;
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart' as _i13;
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart' as _i33;
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart' as _i62;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i45;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i49;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i58;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i104;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i70;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i61;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i95;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart' as _i96;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart' as _i114;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart' as _i102;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart' as _i103;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart' as _i115;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i20;
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart' as _i31;
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart' as _i51;
import 'package:cifraclub/domain/preferences/use_cases/set_is_pro_preference.dart' as _i69;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i28;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i50;
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart' as _i52;
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart' as _i54;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i55;
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart' as _i59;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i67;
import 'package:cifraclub/domain/search/use_cases/search_all_use_case.dart' as _i109;
import 'package:cifraclub/domain/search/use_cases/search_songs.dart' as _i68;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i73;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i101;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i75;
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart' as _i36;
import 'package:cifraclub/domain/songbook/use_cases/add_songs_to_songbook.dart' as _i81;
import 'package:cifraclub/domain/songbook/use_cases/clear_songs_from_songbook.dart' as _i85;
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart' as _i86;
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart' as _i87;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i46;
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart' as _i47;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart' as _i56;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart' as _i57;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i105;
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart' as _i108;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart' as _i77;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart' as _i78;
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart' as _i39;
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart' as _i16;
import 'package:cifraclub/domain/subscription/repository/order_repository.dart' as _i64;
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart' as _i76;
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart' as _i80;
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart' as _i42;
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart' as _i97;
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart' as _i98;
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart' as _i53;
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart' as _i99;
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart' as _i65;
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart' as _i107;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart' as _i110;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart' as _i111;
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart' as _i40;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart' as _i112;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart' as _i113;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i32;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i48;
import 'package:cifraclub/domain/user/repository/authentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i11;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i12;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i21;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i26;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i27;
import 'package:cifraclub/domain/version/repository/user_version_repository.dart' as _i38;
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart' as _i88;
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart' as _i89;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart' as _i8;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i43;
import 'package:firebase_core/firebase_core.dart' as _i9;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:in_app_purchase/in_app_purchase.dart' as _i14;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i19;
import 'package:nav/nav.dart' as _i22;
import 'package:shared_preferences/shared_preferences.dart' as _i30; // ignore_for_file: unnecessary_lambdas

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
  final songbookModule = _$SongbookModule();
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
  final versionModule = _$VersionModule();
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
  gh.factory<_i8.EditListScreenBuilder>(() => songbookModule.getEditListScreenBuilder());
  await gh.singletonAsync<_i9.FirebaseApp>(
    () => firebaseModule.getFirebaseApp(),
    preResolve: true,
  );
  gh.singleton<_i10.FirebaseCrashlytics>(firebaseModule.getFirebaseCrashlytics(get<_i9.FirebaseApp>()));
  gh.factory<_i11.GetCredential>(() => _i11.GetCredential(get<_i3.AuthenticationRepository>()));
  gh.factory<_i12.GetCredentialStream>(() => _i12.GetCredentialStream(get<_i3.AuthenticationRepository>()));
  gh.factory<_i13.GetOperatingSystem>(() => _i13.GetOperatingSystem());
  gh.singleton<_i14.InAppPurchase>(inAppPurchaseModule.getInAppPurchase());
  gh.singleton<_i15.InAppPurchaseDataSource>(inAppPurchaseModule.getInAppPurchaseDataSource(get<_i14.InAppPurchase>()));
  gh.singleton<_i16.InAppPurchaseRepository>(
      inAppPurchaseModule.getInAppPurchaseRepository(get<_i15.InAppPurchaseDataSource>()));
  gh.factory<_i17.InstalledAppRepository>(() => appModule.getInstalledAppRepository(get<_i13.GetOperatingSystem>()));
  gh.factory<_i18.IsAppInstalled>(
      () => _i18.IsAppInstalled(installedAppRepository: get<_i17.InstalledAppRepository>()));
  await gh.singletonAsync<_i19.Isar>(
    () => isarModule.getIsar(get<_i7.Directory>(instanceName: 'InternalDocuments')),
    preResolve: true,
  );
  gh.singleton<_i20.LogRepository>(logModule.getLogRepository(get<_i10.FirebaseCrashlytics>()));
  gh.factory<_i21.Logout>(() => _i21.Logout(get<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i22.Nav, _i23.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        get<_i5.DeepLinkParser>(),
      ));
  gh.factory<_i24.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i25.OpenApp>(() => _i25.OpenApp(installedAppRepository: get<_i17.InstalledAppRepository>()));
  gh.factory<_i26.OpenLoginPage>(() => _i26.OpenLoginPage(get<_i3.AuthenticationRepository>()));
  gh.factory<_i27.OpenUserProfilePage>(() => _i27.OpenUserProfilePage(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i28.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(get<_i9.FirebaseApp>()));
  gh.factory<_i29.ShareLinkRepository>(() => appModule.getShareLinkRepository(get<_i13.GetOperatingSystem>()));
  await gh.singletonAsync<_i30.SharedPreferences>(
    () => sharedPreferencesModule.getSharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i31.SharedPreferencesRepository>(
      () => sharedPreferencesModule.getPreferencesRepository(get<_i30.SharedPreferences>()));
  gh.factory<_i32.TimeRepository>(() => timeModule.getTimeRepository(get<_i24.NtpDataSource>()));
  gh.factory<_i33.UrlLauncherRepository>(() => deviceModule.getUrlLauncherRepository());
  gh.factory<_i34.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(get<_i19.Isar>()));
  gh.factory<_i35.UserSongbookDataSource>(() => songbookModule.getUserSongbookDataSource(get<_i19.Isar>()));
  gh.factory<_i36.UserSongbookRepository>(
      () => songbookModule.getUserSongbookRepository(get<_i35.UserSongbookDataSource>()));
  gh.factory<_i37.UserVersionDataSource>(() => versionModule.getUserVersionDataSource(get<_i19.Isar>()));
  gh.factory<_i38.UserVersionRepository>(
      () => versionModule.getUserVersionRepository(get<_i37.UserVersionDataSource>()));
  gh.factory<_i39.ValidateSongbookName>(() => _i39.ValidateSongbookName(get<_i36.UserSongbookRepository>()));
  gh.factory<_i40.VerifyProStatus>(() => subscriptionModule.getVerifyProStatus());
  gh.singleton<_i41.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(
    get<_i6.Dio>(),
    get<_i11.GetCredential>(),
  ));
  gh.factory<_i42.CompletePurchase>(() => inAppPurchaseModule.getCompletePurchase(get<_i16.InAppPurchaseRepository>()));
  gh.singleton<_i43.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i9.FirebaseApp>()));
  gh.factory<_i44.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i45.GenresRepository>(() => genreModule.getGenresRepository(
        get<_i44.GenresDataSource>(),
        get<_i34.UserGenreDataSource>(),
      ));
  gh.factory<_i46.GetAllUserSongbooks>(() => _i46.GetAllUserSongbooks(get<_i36.UserSongbookRepository>()));
  gh.factory<_i47.GetAllVersionsFromSongbook>(() => _i47.GetAllVersionsFromSongbook(get<_i38.UserVersionRepository>()));
  gh.factory<_i48.GetCurrentTime>(() => _i48.GetCurrentTime(get<_i32.TimeRepository>()));
  gh.factory<_i49.GetGenres>(() => _i49.GetGenres(genresRepository: get<_i45.GenresRepository>()));
  gh.factory<_i50.GetInstrumentUrls>(() => _i50.GetInstrumentUrls(get<_i28.RemoteConfigRepository>()));
  gh.factory<_i51.GetIsProPreference>(() => _i51.GetIsProPreference(get<_i31.SharedPreferencesRepository>()));
  gh.factory<_i52.GetListLimitConstants>(() => _i52.GetListLimitConstants(get<_i28.RemoteConfigRepository>()));
  gh.factory<_i53.GetProducts>(() => _i53.GetProducts(get<_i16.InAppPurchaseRepository>()));
  gh.factory<_i54.GetRemoteProductsIds>(() => _i54.GetRemoteProductsIds(get<_i28.RemoteConfigRepository>()));
  gh.factory<_i55.GetTimeBetweenInterstitials>(
      () => _i55.GetTimeBetweenInterstitials(get<_i28.RemoteConfigRepository>()));
  gh.factory<_i56.GetTotalSongbookVersions>(() => _i56.GetTotalSongbookVersions(get<_i38.UserVersionRepository>()));
  gh.factory<_i57.GetTotalSongbooks>(() => _i57.GetTotalSongbooks(get<_i36.UserSongbookRepository>()));
  gh.factory<_i58.GetUserGenresAsStream>(
      () => _i58.GetUserGenresAsStream(genresRepository: get<_i45.GenresRepository>()));
  gh.factory<_i59.GetVersionsLimitConstants>(() => _i59.GetVersionsLimitConstants(get<_i28.RemoteConfigRepository>()));
  gh.factory<_i60.HomeDataSource>(() => homeModule.getHomeDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i61.HomeRepository>(() => homeModule.getHomeRepository(get<_i60.HomeDataSource>()));
  gh.factory<_i62.OpenUrl>(() => _i62.OpenUrl(urlLauncherRepository: get<_i33.UrlLauncherRepository>()));
  gh.factory<_i63.OrderDataSource>(() => orderModule.getOrderDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i64.OrderRepository>(() => orderModule.getOrderRepository(get<_i63.OrderDataSource>()));
  gh.factory<_i65.PostPurchaseOrder>(() => _i65.PostPurchaseOrder(get<_i64.OrderRepository>()));
  gh.factory<_i66.SearchDataSource>(() => searchModule.getGenresDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i67.SearchRepository>(() => searchModule.getGenresRepository(get<_i66.SearchDataSource>()));
  gh.factory<_i68.SearchSongs>(() => _i68.SearchSongs(searchRepository: get<_i67.SearchRepository>()));
  gh.factory<_i69.SetIsProPreference>(() => _i69.SetIsProPreference(get<_i31.SharedPreferencesRepository>()));
  gh.factory<_i70.SetUserGenres>(() => _i70.SetUserGenres(genresRepository: get<_i45.GenresRepository>()));
  gh.factory<_i71.ShareLink>(() => _i71.ShareLink(get<_i29.ShareLinkRepository>()));
  gh.factory<_i72.SongDataSource>(() => songModule.getSongDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i73.SongRepository>(() => songModule.getSongRepository(get<_i72.SongDataSource>()));
  gh.factory<_i74.SongbookDataSource>(
      () => songbookModule.getSongbookDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i75.SongbookRepository>(() => songbookModule.getSongbookRepository(get<_i74.SongbookDataSource>()));
  gh.singleton<_i76.SubscriptionRepository>(subscriptionModule.getSubscriptionRepository(
    get<_i40.VerifyProStatus>(),
    get<_i51.GetIsProPreference>(),
    get<_i69.SetIsProPreference>(),
  ));
  gh.factory<_i77.UpdateSongbookData>(() => _i77.UpdateSongbookData(
        get<_i75.SongbookRepository>(),
        get<_i36.UserSongbookRepository>(),
      ));
  gh.factory<_i78.UpdateSongbookPreview>(() => _i78.UpdateSongbookPreview(
        get<_i38.UserVersionRepository>(),
        get<_i36.UserSongbookRepository>(),
      ));
  gh.factory<_i79.ValidatePurchaseDataSource>(
      () => inAppPurchaseModule.getValidatePurchaseDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i80.ValidatePurchaseRepository>(() => inAppPurchaseModule.getValidatePurchaseRepository(
        get<_i13.GetOperatingSystem>(),
        get<_i79.ValidatePurchaseDataSource>(),
      ));
  gh.factory<_i81.AddSongsToSongbook>(() => _i81.AddSongsToSongbook(
        get<_i75.SongbookRepository>(),
        get<_i38.UserVersionRepository>(),
      ));
  gh.factory<_i82.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i43.FirebaseAnalytics>()));
  gh.factory<_i83.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i41.CifraClubAPINetworkService>()));
  gh.factory<_i84.ArtistRepository>(() => artistModule.getGenresRepository(get<_i83.ArtistDataSource>()));
  gh.factory<_i85.ClearSongsFromSongbook>(() => _i85.ClearSongsFromSongbook(
        get<_i75.SongbookRepository>(),
        get<_i38.UserVersionRepository>(),
        get<_i78.UpdateSongbookPreview>(),
      ));
  gh.factory<_i86.DeleteSongbook>(() => _i86.DeleteSongbook(
        get<_i75.SongbookRepository>(),
        get<_i36.UserSongbookRepository>(),
      ));
  gh.factory<_i87.DeleteVersions>(() => _i87.DeleteVersions(
        get<_i75.SongbookRepository>(),
        get<_i38.UserVersionRepository>(),
      ));
  gh.factory<_i88.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(get<_i49.GetGenres>()));
  gh.factory<_i89.GenreBottomSheet>(() => bottomSheetModule.getGenreBottomSheet(get<_i49.GetGenres>()));
  gh.factory<_i90.GetAlbumDetail>(() => _i90.GetAlbumDetail(artistRepository: get<_i84.ArtistRepository>()));
  gh.factory<_i91.GetAlbums>(() => _i91.GetAlbums(artistRepository: get<_i84.ArtistRepository>()));
  gh.factory<_i92.GetArtistInfo>(() => _i92.GetArtistInfo(artistRepository: get<_i84.ArtistRepository>()));
  gh.factory<_i93.GetArtistSongs>(() => _i93.GetArtistSongs(artistRepository: get<_i84.ArtistRepository>()));
  gh.factory<_i94.GetArtistVideoLessons>(() => _i94.GetArtistVideoLessons(get<_i84.ArtistRepository>()));
  gh.factory<_i95.GetHomeInfo>(() => _i95.GetHomeInfo(get<_i61.HomeRepository>()));
  gh.factory<_i96.GetListLimit>(() => _i96.GetListLimit(get<_i52.GetListLimitConstants>()));
  gh.factory<_i97.GetOrders>(() => _i97.GetOrders(get<_i64.OrderRepository>()));
  gh.factory<_i98.GetProStatusStream>(() => _i98.GetProStatusStream(get<_i76.SubscriptionRepository>()));
  gh.factory<_i99.GetRemoteProStatus>(() => subscriptionModule.getRemoteProStatus(get<_i97.GetOrders>()));
  gh.factory<_i100.GetTopArtists>(() => _i100.GetTopArtists(artistRepository: get<_i84.ArtistRepository>()));
  gh.factory<_i101.GetTopSongs>(() => _i101.GetTopSongs(songRepository: get<_i73.SongRepository>()));
  gh.factory<_i102.GetVersionsLimit>(() => _i102.GetVersionsLimit(get<_i59.GetVersionsLimitConstants>()));
  gh.factory<_i103.GetVersionsLimitState>(() => _i103.GetVersionsLimitState(
        get<_i56.GetTotalSongbookVersions>(),
        get<_i102.GetVersionsLimit>(),
        get<_i98.GetProStatusStream>(),
        get<_i59.GetVersionsLimitConstants>(),
      ));
  gh.factory<_i104.InsertUserGenre>(() => _i104.InsertUserGenre(
        getUserGenresAsStream: get<_i58.GetUserGenresAsStream>(),
        setUserGenres: get<_i70.SetUserGenres>(),
      ));
  gh.factory<_i105.InsertUserSongbook>(() => _i105.InsertUserSongbook(
        get<_i75.SongbookRepository>(),
        get<_i36.UserSongbookRepository>(),
      ));
  gh.factory<_i106.OpenAppOrStore>(() => _i106.OpenAppOrStore(
        openApp: get<_i25.OpenApp>(),
        openUrl: get<_i62.OpenUrl>(),
        isAppInstalled: get<_i18.IsAppInstalled>(),
        getOperatingSystem: get<_i13.GetOperatingSystem>(),
      ));
  gh.factory<_i107.PurchaseProduct>(() => _i107.PurchaseProduct(
        get<_i16.InAppPurchaseRepository>(),
        get<_i76.SubscriptionRepository>(),
      ));
  gh.factory<_i108.RefreshAllSongbooks>(() => _i108.RefreshAllSongbooks(
        get<_i75.SongbookRepository>(),
        get<_i36.UserSongbookRepository>(),
        get<_i38.UserVersionRepository>(),
        get<_i78.UpdateSongbookPreview>(),
      ));
  gh.factory<_i109.SearchAll>(() => _i109.SearchAll(searchRepository: get<_i67.SearchRepository>()));
  gh.factory<_i110.ValidatePurchase>(() => inAppPurchaseModule.getValidatePurchase(
        get<_i11.GetCredential>(),
        get<_i65.PostPurchaseOrder>(),
        get<_i80.ValidatePurchaseRepository>(),
      ));
  gh.factory<_i111.ValidatePurchases>(() => inAppPurchaseModule.getValidatePurchases(
        get<_i110.ValidatePurchase>(),
        get<_i42.CompletePurchase>(),
      ));
  gh.singleton<_i112.WatchForPurchases>(inAppPurchaseModule.getWatchForPurchases(
    get<_i16.InAppPurchaseRepository>(),
    get<_i76.SubscriptionRepository>(),
    get<_i111.ValidatePurchases>(),
  ));
  gh.singleton<_i113.WatchForSubscriptions>(subscriptionModule.getWatchForSubscriptions(
    get<_i12.GetCredentialStream>(),
    get<_i76.SubscriptionRepository>(),
    get<_i16.InAppPurchaseRepository>(),
    get<_i99.GetRemoteProStatus>(),
  ));
  gh.factory<_i114.GetListLimitState>(() => _i114.GetListLimitState(
        get<_i57.GetTotalSongbooks>(),
        get<_i98.GetProStatusStream>(),
        get<_i96.GetListLimit>(),
        get<_i52.GetListLimitConstants>(),
      ));
  gh.factory<_i115.GetVersionLimitStateByCount>(() => _i115.GetVersionLimitStateByCount(
        get<_i102.GetVersionsLimit>(),
        get<_i59.GetVersionsLimitConstants>(),
      ));
  return get;
}

class _$AuthenticationModule extends _i116.AuthenticationModule {}

class _$ControllersModule extends _i117.ControllersModule {}

class _$NavigatorModule extends _i23.NavigatorModule {}

class _$NetworkModule extends _i118.NetworkModule {}

class _$PathModule extends _i119.PathModule {}

class _$SongbookModule extends _i120.SongbookModule {}

class _$FirebaseModule extends _i121.FirebaseModule {}

class _$InAppPurchaseModule extends _i122.InAppPurchaseModule {}

class _$AppModule extends _i123.AppModule {}

class _$IsarModule extends _i124.IsarModule {}

class _$LogModule extends _i125.LogModule {}

class _$TimeModule extends _i126.TimeModule {}

class _$RemoteConfigModule extends _i127.RemoteConfigModule {}

class _$SharedPreferencesModule extends _i128.SharedPreferencesModule {}

class _$DeviceModule extends _i129.DeviceModule {}

class _$GenreModule extends _i130.GenreModule {}

class _$VersionModule extends _i131.VersionModule {}

class _$SubscriptionModule extends _i132.SubscriptionModule {}

class _$HomeModule extends _i133.HomeModule {}

class _$OrderModule extends _i134.OrderModule {}

class _$SearchModule extends _i135.SearchModule {}

class _$SongModule extends _i136.SongModule {}

class _$AnalyticsModule extends _i137.AnalyticsModule {}

class _$ArtistModule extends _i138.ArtistModule {}

class _$BottomSheetModule extends _i139.BottomSheetModule {}
