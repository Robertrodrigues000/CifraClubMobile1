// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i84;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i42;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i45;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i35;
import 'package:cifraclub/data/home/data_source/home_data_source.dart' as _i61;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i67;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i73;
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart' as _i75;
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart' as _i36;
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart' as _i16;
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart' as _i64;
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart' as _i80;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i25;
import 'package:cifraclub/data/version/data_source/user_version_data_source.dart' as _i38;
import 'package:cifraclub/di/analytics_module.dart' as _i138;
import 'package:cifraclub/di/app_module.dart' as _i124;
import 'package:cifraclub/di/artist_module.dart' as _i139;
import 'package:cifraclub/di/authentication_module.dart' as _i117;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i140;
import 'package:cifraclub/di/controllers_module.dart' as _i118;
import 'package:cifraclub/di/device_module.dart' as _i130;
import 'package:cifraclub/di/firebase_module.dart' as _i122;
import 'package:cifraclub/di/genre_module.dart' as _i131;
import 'package:cifraclub/di/home_module.dart' as _i134;
import 'package:cifraclub/di/in_app_purchase_module.dart' as _i123;
import 'package:cifraclub/di/isar_module.dart' as _i125;
import 'package:cifraclub/di/log_module.dart' as _i126;
import 'package:cifraclub/di/navigator_module.dart' as _i24;
import 'package:cifraclub/di/network_module.dart' as _i119;
import 'package:cifraclub/di/order_module.dart' as _i135;
import 'package:cifraclub/di/path_module.dart' as _i120;
import 'package:cifraclub/di/remote_config_module.dart' as _i128;
import 'package:cifraclub/di/search_module.dart' as _i136;
import 'package:cifraclub/di/shared_preferences_module.dart' as _i129;
import 'package:cifraclub/di/song_module.dart' as _i137;
import 'package:cifraclub/di/songbook_module.dart' as _i121;
import 'package:cifraclub/di/subscription_module.dart' as _i133;
import 'package:cifraclub/di/time_module.dart' as _i127;
import 'package:cifraclub/di/version_module.dart' as _i132;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i83;
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart' as _i18;
import 'package:cifraclub/domain/app/repository/share_link_repository.dart' as _i30;
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart' as _i19;
import 'package:cifraclub/domain/app/use_cases/open_app.dart' as _i26;
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart' as _i107;
import 'package:cifraclub/domain/app/use_cases/share_link.dart' as _i72;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i85;
import 'package:cifraclub/domain/artist/use_cases/get_album_detail.dart' as _i91;
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart' as _i92;
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart' as _i93;
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart' as _i94;
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart' as _i95;
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart' as _i13;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i101;
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart' as _i14;
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart' as _i34;
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart' as _i63;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i46;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i50;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i59;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i105;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i71;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i62;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i96;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart' as _i97;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart' as _i115;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart' as _i103;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart' as _i104;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart' as _i116;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i21;
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart' as _i32;
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart' as _i52;
import 'package:cifraclub/domain/preferences/use_cases/set_is_pro_preference.dart' as _i70;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i29;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i51;
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart' as _i53;
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart' as _i55;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i56;
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart' as _i60;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i68;
import 'package:cifraclub/domain/search/use_cases/search_all_use_case.dart' as _i110;
import 'package:cifraclub/domain/search/use_cases/search_songs.dart' as _i69;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i74;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i102;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i76;
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart' as _i37;
import 'package:cifraclub/domain/songbook/use_cases/add_songs_to_songbook.dart' as _i82;
import 'package:cifraclub/domain/songbook/use_cases/clear_songs_from_songbook.dart' as _i86;
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart' as _i87;
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart' as _i88;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i47;
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart' as _i48;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart' as _i57;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart' as _i58;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i106;
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart' as _i109;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart' as _i78;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart' as _i79;
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart' as _i40;
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart' as _i17;
import 'package:cifraclub/domain/subscription/repository/order_repository.dart' as _i65;
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart' as _i77;
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart' as _i81;
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart' as _i43;
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart' as _i98;
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart' as _i99;
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart' as _i54;
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart' as _i100;
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart' as _i66;
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart' as _i108;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart' as _i111;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart' as _i112;
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart' as _i41;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart' as _i113;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart' as _i114;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i33;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i49;
import 'package:cifraclub/domain/user/repository/authentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i11;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i12;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i22;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i27;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i28;
import 'package:cifraclub/domain/version/repository/user_version_repository.dart' as _i39;
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart' as _i89;
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart' as _i90;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart' as _i8;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i44;
import 'package:firebase_core/firebase_core.dart' as _i9;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:in_app_purchase/in_app_purchase.dart' as _i15;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i20;
import 'package:nav/nav.dart' as _i23;
import 'package:shared_preferences/shared_preferences.dart' as _i31; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i13.GetDefaultInstruments>(() => _i13.GetDefaultInstruments());
  gh.factory<_i14.GetOperatingSystem>(() => _i14.GetOperatingSystem());
  gh.singleton<_i15.InAppPurchase>(inAppPurchaseModule.getInAppPurchase());
  gh.singleton<_i16.InAppPurchaseDataSource>(inAppPurchaseModule.getInAppPurchaseDataSource(get<_i15.InAppPurchase>()));
  gh.singleton<_i17.InAppPurchaseRepository>(
      inAppPurchaseModule.getInAppPurchaseRepository(get<_i16.InAppPurchaseDataSource>()));
  gh.factory<_i18.InstalledAppRepository>(() => appModule.getInstalledAppRepository(get<_i14.GetOperatingSystem>()));
  gh.factory<_i19.IsAppInstalled>(
      () => _i19.IsAppInstalled(installedAppRepository: get<_i18.InstalledAppRepository>()));
  await gh.singletonAsync<_i20.Isar>(
    () => isarModule.getIsar(get<_i7.Directory>(instanceName: 'InternalDocuments')),
    preResolve: true,
  );
  gh.singleton<_i21.LogRepository>(logModule.getLogRepository(get<_i10.FirebaseCrashlytics>()));
  gh.factory<_i22.Logout>(() => _i22.Logout(get<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i23.Nav, _i24.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        get<_i5.DeepLinkParser>(),
      ));
  gh.factory<_i25.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i26.OpenApp>(() => _i26.OpenApp(installedAppRepository: get<_i18.InstalledAppRepository>()));
  gh.factory<_i27.OpenLoginPage>(() => _i27.OpenLoginPage(get<_i3.AuthenticationRepository>()));
  gh.factory<_i28.OpenUserProfilePage>(() => _i28.OpenUserProfilePage(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i29.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(get<_i9.FirebaseApp>()));
  gh.factory<_i30.ShareLinkRepository>(() => appModule.getShareLinkRepository(get<_i14.GetOperatingSystem>()));
  await gh.singletonAsync<_i31.SharedPreferences>(
    () => sharedPreferencesModule.getSharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i32.SharedPreferencesRepository>(
      () => sharedPreferencesModule.getPreferencesRepository(get<_i31.SharedPreferences>()));
  gh.factory<_i33.TimeRepository>(() => timeModule.getTimeRepository(get<_i25.NtpDataSource>()));
  gh.factory<_i34.UrlLauncherRepository>(() => deviceModule.getUrlLauncherRepository());
  gh.factory<_i35.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(get<_i20.Isar>()));
  gh.factory<_i36.UserSongbookDataSource>(() => songbookModule.getUserSongbookDataSource(get<_i20.Isar>()));
  gh.factory<_i37.UserSongbookRepository>(
      () => songbookModule.getUserSongbookRepository(get<_i36.UserSongbookDataSource>()));
  gh.factory<_i38.UserVersionDataSource>(() => versionModule.getUserVersionDataSource(get<_i20.Isar>()));
  gh.factory<_i39.UserVersionRepository>(
      () => versionModule.getUserVersionRepository(get<_i38.UserVersionDataSource>()));
  gh.factory<_i40.ValidateSongbookName>(() => _i40.ValidateSongbookName(get<_i37.UserSongbookRepository>()));
  gh.factory<_i41.VerifyProStatus>(() => subscriptionModule.getVerifyProStatus());
  gh.singleton<_i42.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(
    get<_i6.Dio>(),
    get<_i11.GetCredential>(),
  ));
  gh.factory<_i43.CompletePurchase>(() => inAppPurchaseModule.getCompletePurchase(get<_i17.InAppPurchaseRepository>()));
  gh.singleton<_i44.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i9.FirebaseApp>()));
  gh.factory<_i45.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i46.GenresRepository>(() => genreModule.getGenresRepository(
        get<_i45.GenresDataSource>(),
        get<_i35.UserGenreDataSource>(),
      ));
  gh.factory<_i47.GetAllUserSongbooks>(() => _i47.GetAllUserSongbooks(get<_i37.UserSongbookRepository>()));
  gh.factory<_i48.GetAllVersionsFromSongbook>(() => _i48.GetAllVersionsFromSongbook(get<_i39.UserVersionRepository>()));
  gh.factory<_i49.GetCurrentTime>(() => _i49.GetCurrentTime(get<_i33.TimeRepository>()));
  gh.factory<_i50.GetGenres>(() => _i50.GetGenres(genresRepository: get<_i46.GenresRepository>()));
  gh.factory<_i51.GetInstrumentUrls>(() => _i51.GetInstrumentUrls(get<_i29.RemoteConfigRepository>()));
  gh.factory<_i52.GetIsProPreference>(() => _i52.GetIsProPreference(get<_i32.SharedPreferencesRepository>()));
  gh.factory<_i53.GetListLimitConstants>(() => _i53.GetListLimitConstants(get<_i29.RemoteConfigRepository>()));
  gh.factory<_i54.GetProducts>(() => _i54.GetProducts(get<_i17.InAppPurchaseRepository>()));
  gh.factory<_i55.GetRemoteProductsIds>(() => _i55.GetRemoteProductsIds(get<_i29.RemoteConfigRepository>()));
  gh.factory<_i56.GetTimeBetweenInterstitials>(
      () => _i56.GetTimeBetweenInterstitials(get<_i29.RemoteConfigRepository>()));
  gh.factory<_i57.GetTotalSongbookVersions>(() => _i57.GetTotalSongbookVersions(get<_i39.UserVersionRepository>()));
  gh.factory<_i58.GetTotalSongbooks>(() => _i58.GetTotalSongbooks(get<_i37.UserSongbookRepository>()));
  gh.factory<_i59.GetUserGenresAsStream>(
      () => _i59.GetUserGenresAsStream(genresRepository: get<_i46.GenresRepository>()));
  gh.factory<_i60.GetVersionsLimitConstants>(() => _i60.GetVersionsLimitConstants(get<_i29.RemoteConfigRepository>()));
  gh.factory<_i61.HomeDataSource>(() => homeModule.getHomeDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i62.HomeRepository>(() => homeModule.getHomeRepository(get<_i61.HomeDataSource>()));
  gh.factory<_i63.OpenUrl>(() => _i63.OpenUrl(urlLauncherRepository: get<_i34.UrlLauncherRepository>()));
  gh.factory<_i64.OrderDataSource>(() => orderModule.getOrderDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i65.OrderRepository>(() => orderModule.getOrderRepository(get<_i64.OrderDataSource>()));
  gh.factory<_i66.PostPurchaseOrder>(() => _i66.PostPurchaseOrder(get<_i65.OrderRepository>()));
  gh.factory<_i67.SearchDataSource>(() => searchModule.getGenresDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i68.SearchRepository>(() => searchModule.getGenresRepository(get<_i67.SearchDataSource>()));
  gh.factory<_i69.SearchSongs>(() => _i69.SearchSongs(searchRepository: get<_i68.SearchRepository>()));
  gh.factory<_i70.SetIsProPreference>(() => _i70.SetIsProPreference(get<_i32.SharedPreferencesRepository>()));
  gh.factory<_i71.SetUserGenres>(() => _i71.SetUserGenres(genresRepository: get<_i46.GenresRepository>()));
  gh.factory<_i72.ShareLink>(() => _i72.ShareLink(get<_i30.ShareLinkRepository>()));
  gh.factory<_i73.SongDataSource>(() => songModule.getSongDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i74.SongRepository>(() => songModule.getSongRepository(get<_i73.SongDataSource>()));
  gh.factory<_i75.SongbookDataSource>(
      () => songbookModule.getSongbookDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i76.SongbookRepository>(() => songbookModule.getSongbookRepository(get<_i75.SongbookDataSource>()));
  gh.singleton<_i77.SubscriptionRepository>(subscriptionModule.getSubscriptionRepository(
    get<_i41.VerifyProStatus>(),
    get<_i52.GetIsProPreference>(),
    get<_i70.SetIsProPreference>(),
  ));
  gh.factory<_i78.UpdateSongbookData>(() => _i78.UpdateSongbookData(
        get<_i76.SongbookRepository>(),
        get<_i37.UserSongbookRepository>(),
      ));
  gh.factory<_i79.UpdateSongbookPreview>(() => _i79.UpdateSongbookPreview(
        get<_i39.UserVersionRepository>(),
        get<_i37.UserSongbookRepository>(),
      ));
  gh.factory<_i80.ValidatePurchaseDataSource>(
      () => inAppPurchaseModule.getValidatePurchaseDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i81.ValidatePurchaseRepository>(() => inAppPurchaseModule.getValidatePurchaseRepository(
        get<_i14.GetOperatingSystem>(),
        get<_i80.ValidatePurchaseDataSource>(),
      ));
  gh.factory<_i82.AddSongsToSongbook>(() => _i82.AddSongsToSongbook(
        get<_i76.SongbookRepository>(),
        get<_i39.UserVersionRepository>(),
      ));
  gh.factory<_i83.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i44.FirebaseAnalytics>()));
  gh.factory<_i84.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i42.CifraClubAPINetworkService>()));
  gh.factory<_i85.ArtistRepository>(() => artistModule.getGenresRepository(get<_i84.ArtistDataSource>()));
  gh.factory<_i86.ClearSongsFromSongbook>(() => _i86.ClearSongsFromSongbook(
        get<_i76.SongbookRepository>(),
        get<_i39.UserVersionRepository>(),
        get<_i79.UpdateSongbookPreview>(),
      ));
  gh.factory<_i87.DeleteSongbook>(() => _i87.DeleteSongbook(
        get<_i76.SongbookRepository>(),
        get<_i37.UserSongbookRepository>(),
      ));
  gh.factory<_i88.DeleteVersions>(() => _i88.DeleteVersions(
        get<_i76.SongbookRepository>(),
        get<_i39.UserVersionRepository>(),
      ));
  gh.factory<_i89.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(get<_i50.GetGenres>()));
  gh.factory<_i90.GenreBottomSheet>(() => bottomSheetModule.getGenreBottomSheet(get<_i50.GetGenres>()));
  gh.factory<_i91.GetAlbumDetail>(() => _i91.GetAlbumDetail(artistRepository: get<_i85.ArtistRepository>()));
  gh.factory<_i92.GetAlbums>(() => _i92.GetAlbums(artistRepository: get<_i85.ArtistRepository>()));
  gh.factory<_i93.GetArtistInfo>(() => _i93.GetArtistInfo(artistRepository: get<_i85.ArtistRepository>()));
  gh.factory<_i94.GetArtistSongs>(() => _i94.GetArtistSongs(artistRepository: get<_i85.ArtistRepository>()));
  gh.factory<_i95.GetArtistVideoLessons>(() => _i95.GetArtistVideoLessons(get<_i85.ArtistRepository>()));
  gh.factory<_i96.GetHomeInfo>(() => _i96.GetHomeInfo(get<_i62.HomeRepository>()));
  gh.factory<_i97.GetListLimit>(() => _i97.GetListLimit(get<_i53.GetListLimitConstants>()));
  gh.factory<_i98.GetOrders>(() => _i98.GetOrders(get<_i65.OrderRepository>()));
  gh.factory<_i99.GetProStatusStream>(() => _i99.GetProStatusStream(get<_i77.SubscriptionRepository>()));
  gh.factory<_i100.GetRemoteProStatus>(() => subscriptionModule.getRemoteProStatus(get<_i98.GetOrders>()));
  gh.factory<_i101.GetTopArtists>(() => _i101.GetTopArtists(artistRepository: get<_i85.ArtistRepository>()));
  gh.factory<_i102.GetTopSongs>(() => _i102.GetTopSongs(songRepository: get<_i74.SongRepository>()));
  gh.factory<_i103.GetVersionsLimit>(() => _i103.GetVersionsLimit(get<_i60.GetVersionsLimitConstants>()));
  gh.factory<_i104.GetVersionsLimitState>(() => _i104.GetVersionsLimitState(
        get<_i57.GetTotalSongbookVersions>(),
        get<_i103.GetVersionsLimit>(),
        get<_i99.GetProStatusStream>(),
        get<_i60.GetVersionsLimitConstants>(),
      ));
  gh.factory<_i105.InsertUserGenre>(() => _i105.InsertUserGenre(
        getUserGenresAsStream: get<_i59.GetUserGenresAsStream>(),
        setUserGenres: get<_i71.SetUserGenres>(),
      ));
  gh.factory<_i106.InsertUserSongbook>(() => _i106.InsertUserSongbook(
        get<_i76.SongbookRepository>(),
        get<_i37.UserSongbookRepository>(),
      ));
  gh.factory<_i107.OpenAppOrStore>(() => _i107.OpenAppOrStore(
        openApp: get<_i26.OpenApp>(),
        openUrl: get<_i63.OpenUrl>(),
        isAppInstalled: get<_i19.IsAppInstalled>(),
        getOperatingSystem: get<_i14.GetOperatingSystem>(),
      ));
  gh.factory<_i108.PurchaseProduct>(() => _i108.PurchaseProduct(
        get<_i17.InAppPurchaseRepository>(),
        get<_i77.SubscriptionRepository>(),
      ));
  gh.factory<_i109.RefreshAllSongbooks>(() => _i109.RefreshAllSongbooks(
        get<_i76.SongbookRepository>(),
        get<_i37.UserSongbookRepository>(),
        get<_i39.UserVersionRepository>(),
        get<_i79.UpdateSongbookPreview>(),
      ));
  gh.factory<_i110.SearchAll>(() => _i110.SearchAll(searchRepository: get<_i68.SearchRepository>()));
  gh.factory<_i111.ValidatePurchase>(() => inAppPurchaseModule.getValidatePurchase(
        get<_i11.GetCredential>(),
        get<_i66.PostPurchaseOrder>(),
        get<_i81.ValidatePurchaseRepository>(),
      ));
  gh.factory<_i112.ValidatePurchases>(() => inAppPurchaseModule.getValidatePurchases(
        get<_i111.ValidatePurchase>(),
        get<_i43.CompletePurchase>(),
      ));
  gh.singleton<_i113.WatchForPurchases>(inAppPurchaseModule.getWatchForPurchases(
    get<_i17.InAppPurchaseRepository>(),
    get<_i77.SubscriptionRepository>(),
    get<_i112.ValidatePurchases>(),
  ));
  gh.singleton<_i114.WatchForSubscriptions>(subscriptionModule.getWatchForSubscriptions(
    get<_i12.GetCredentialStream>(),
    get<_i77.SubscriptionRepository>(),
    get<_i17.InAppPurchaseRepository>(),
    get<_i100.GetRemoteProStatus>(),
  ));
  gh.factory<_i115.GetListLimitState>(() => _i115.GetListLimitState(
        get<_i58.GetTotalSongbooks>(),
        get<_i99.GetProStatusStream>(),
        get<_i97.GetListLimit>(),
        get<_i53.GetListLimitConstants>(),
      ));
  gh.factory<_i116.GetVersionLimitStateByCount>(() => _i116.GetVersionLimitStateByCount(
        get<_i103.GetVersionsLimit>(),
        get<_i60.GetVersionsLimitConstants>(),
      ));
  return get;
}

class _$AuthenticationModule extends _i117.AuthenticationModule {}

class _$ControllersModule extends _i118.ControllersModule {}

class _$NavigatorModule extends _i24.NavigatorModule {}

class _$NetworkModule extends _i119.NetworkModule {}

class _$PathModule extends _i120.PathModule {}

class _$SongbookModule extends _i121.SongbookModule {}

class _$FirebaseModule extends _i122.FirebaseModule {}

class _$InAppPurchaseModule extends _i123.InAppPurchaseModule {}

class _$AppModule extends _i124.AppModule {}

class _$IsarModule extends _i125.IsarModule {}

class _$LogModule extends _i126.LogModule {}

class _$TimeModule extends _i127.TimeModule {}

class _$RemoteConfigModule extends _i128.RemoteConfigModule {}

class _$SharedPreferencesModule extends _i129.SharedPreferencesModule {}

class _$DeviceModule extends _i130.DeviceModule {}

class _$GenreModule extends _i131.GenreModule {}

class _$VersionModule extends _i132.VersionModule {}

class _$SubscriptionModule extends _i133.SubscriptionModule {}

class _$HomeModule extends _i134.HomeModule {}

class _$OrderModule extends _i135.OrderModule {}

class _$SearchModule extends _i136.SearchModule {}

class _$SongModule extends _i137.SongModule {}

class _$AnalyticsModule extends _i138.AnalyticsModule {}

class _$ArtistModule extends _i139.ArtistModule {}

class _$BottomSheetModule extends _i140.BottomSheetModule {}
