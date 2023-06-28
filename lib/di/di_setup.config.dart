// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i80;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i40;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i43;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i33;
import 'package:cifraclub/data/home/data_source/home_data_source.dart' as _i58;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i64;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i70;
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart' as _i72;
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart' as _i34;
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart' as _i14;
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart' as _i61;
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart' as _i77;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i23;
import 'package:cifraclub/data/version/data_source/user_version_data_source.dart' as _i36;
import 'package:cifraclub/di/analytics_module.dart' as _i133;
import 'package:cifraclub/di/app_module.dart' as _i118;
import 'package:cifraclub/di/artist_module.dart' as _i134;
import 'package:cifraclub/di/authentication_module.dart' as _i112;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i135;
import 'package:cifraclub/di/controllers_module.dart' as _i113;
import 'package:cifraclub/di/device_module.dart' as _i124;
import 'package:cifraclub/di/firebase_module.dart' as _i116;
import 'package:cifraclub/di/genre_module.dart' as _i125;
import 'package:cifraclub/di/home_module.dart' as _i129;
import 'package:cifraclub/di/in_app_purchase_module.dart' as _i117;
import 'package:cifraclub/di/isar_module.dart' as _i119;
import 'package:cifraclub/di/log_module.dart' as _i120;
import 'package:cifraclub/di/navigator_module.dart' as _i22;
import 'package:cifraclub/di/network_module.dart' as _i114;
import 'package:cifraclub/di/order_module.dart' as _i130;
import 'package:cifraclub/di/path_module.dart' as _i115;
import 'package:cifraclub/di/remote_config_module.dart' as _i122;
import 'package:cifraclub/di/search_module.dart' as _i131;
import 'package:cifraclub/di/shared_preferences_module.dart' as _i123;
import 'package:cifraclub/di/song_module.dart' as _i132;
import 'package:cifraclub/di/songbook_module.dart' as _i126;
import 'package:cifraclub/di/subscription_module.dart' as _i128;
import 'package:cifraclub/di/time_module.dart' as _i121;
import 'package:cifraclub/di/version_module.dart' as _i127;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i79;
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart' as _i16;
import 'package:cifraclub/domain/app/repository/share_link_repository.dart' as _i28;
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart' as _i17;
import 'package:cifraclub/domain/app/use_cases/open_app.dart' as _i24;
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart' as _i102;
import 'package:cifraclub/domain/app/use_cases/share_link.dart' as _i69;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i81;
import 'package:cifraclub/domain/artist/use_cases/get_album_detail.dart' as _i86;
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart' as _i87;
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart' as _i88;
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart' as _i89;
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart' as _i90;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i96;
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart' as _i12;
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart' as _i32;
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart' as _i60;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i44;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i47;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i56;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i100;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i68;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i59;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i91;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart' as _i92;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart' as _i110;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart' as _i98;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart' as _i99;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart' as _i111;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i19;
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart' as _i30;
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart' as _i49;
import 'package:cifraclub/domain/preferences/use_cases/set_is_pro_preference.dart' as _i67;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i27;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i48;
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart' as _i50;
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart' as _i52;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i53;
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart' as _i57;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i65;
import 'package:cifraclub/domain/search/use_cases/search_all_use_case.dart' as _i105;
import 'package:cifraclub/domain/search/use_cases/search_songs.dart' as _i66;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i71;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i97;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i73;
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart' as _i35;
import 'package:cifraclub/domain/songbook/use_cases/delete_all_versions.dart' as _i82;
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart' as _i83;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i45;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart' as _i54;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart' as _i55;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i101;
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart' as _i104;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart' as _i75;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart' as _i76;
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart' as _i38;
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart' as _i15;
import 'package:cifraclub/domain/subscription/repository/order_repository.dart' as _i62;
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart' as _i74;
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart' as _i78;
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart' as _i41;
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart' as _i93;
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart' as _i94;
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart' as _i51;
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart' as _i95;
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart' as _i63;
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart' as _i103;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart' as _i106;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart' as _i107;
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart' as _i39;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart' as _i108;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart' as _i109;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i31;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i46;
import 'package:cifraclub/domain/user/repository/authentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i10;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i11;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i20;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i25;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i26;
import 'package:cifraclub/domain/version/repository/user_version_repository.dart' as _i37;
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart' as _i84;
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart' as _i85;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i42;
import 'package:firebase_core/firebase_core.dart' as _i8;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:in_app_purchase/in_app_purchase.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i18;
import 'package:nav/nav.dart' as _i21;
import 'package:shared_preferences/shared_preferences.dart' as _i29; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i28.ShareLinkRepository>(() => appModule.getShareLinkRepository(get<_i12.GetOperatingSystem>()));
  await gh.singletonAsync<_i29.SharedPreferences>(
    () => sharedPreferencesModule.getSharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i30.SharedPreferencesRepository>(
      () => sharedPreferencesModule.getPreferencesRepository(get<_i29.SharedPreferences>()));
  gh.factory<_i31.TimeRepository>(() => timeModule.getTimeRepository(get<_i23.NtpDataSource>()));
  gh.factory<_i32.UrlLauncherRepository>(() => deviceModule.getUrlLauncherRepository());
  gh.factory<_i33.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(get<_i18.Isar>()));
  gh.factory<_i34.UserSongbookDataSource>(() => songbookModule.getUserSongbookDataSource(get<_i18.Isar>()));
  gh.factory<_i35.UserSongbookRepository>(
      () => songbookModule.getUserSongbookRepository(get<_i34.UserSongbookDataSource>()));
  gh.factory<_i36.UserVersionDataSource>(() => versionModule.getUserVersionDataSource(get<_i18.Isar>()));
  gh.factory<_i37.UserVersionRepository>(
      () => versionModule.getUserVersionRepository(get<_i36.UserVersionDataSource>()));
  gh.factory<_i38.ValidateSongbookName>(() => _i38.ValidateSongbookName(get<_i35.UserSongbookRepository>()));
  gh.factory<_i39.VerifyProStatus>(() => subscriptionModule.getVerifyProStatus());
  gh.singleton<_i40.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(
    get<_i6.Dio>(),
    get<_i10.GetCredential>(),
  ));
  gh.factory<_i41.CompletePurchase>(() => inAppPurchaseModule.getCompletePurchase(get<_i15.InAppPurchaseRepository>()));
  gh.singleton<_i42.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(get<_i8.FirebaseApp>()));
  gh.factory<_i43.GenresDataSource>(() => genreModule.getGenresDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i44.GenresRepository>(() => genreModule.getGenresRepository(
        get<_i43.GenresDataSource>(),
        get<_i33.UserGenreDataSource>(),
      ));
  gh.factory<_i45.GetAllUserSongbooks>(() => _i45.GetAllUserSongbooks(get<_i35.UserSongbookRepository>()));
  gh.factory<_i46.GetCurrentTime>(() => _i46.GetCurrentTime(get<_i31.TimeRepository>()));
  gh.factory<_i47.GetGenres>(() => _i47.GetGenres(genresRepository: get<_i44.GenresRepository>()));
  gh.factory<_i48.GetInstrumentUrls>(() => _i48.GetInstrumentUrls(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i49.GetIsProPreference>(() => _i49.GetIsProPreference(get<_i30.SharedPreferencesRepository>()));
  gh.factory<_i50.GetListLimitConstants>(() => _i50.GetListLimitConstants(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i51.GetProducts>(() => _i51.GetProducts(get<_i15.InAppPurchaseRepository>()));
  gh.factory<_i52.GetRemoteProductsIds>(() => _i52.GetRemoteProductsIds(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i53.GetTimeBetweenInterstitials>(
      () => _i53.GetTimeBetweenInterstitials(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i54.GetTotalSongbookVersions>(() => _i54.GetTotalSongbookVersions(get<_i37.UserVersionRepository>()));
  gh.factory<_i55.GetTotalSongbooks>(() => _i55.GetTotalSongbooks(get<_i35.UserSongbookRepository>()));
  gh.factory<_i56.GetUserGenresAsStream>(
      () => _i56.GetUserGenresAsStream(genresRepository: get<_i44.GenresRepository>()));
  gh.factory<_i57.GetVersionsLimitConstants>(() => _i57.GetVersionsLimitConstants(get<_i27.RemoteConfigRepository>()));
  gh.factory<_i58.HomeDataSource>(() => homeModule.getHomeDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i59.HomeRepository>(() => homeModule.getHomeRepository(get<_i58.HomeDataSource>()));
  gh.factory<_i60.OpenUrl>(() => _i60.OpenUrl(urlLauncherRepository: get<_i32.UrlLauncherRepository>()));
  gh.factory<_i61.OrderDataSource>(() => orderModule.getOrderDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i62.OrderRepository>(() => orderModule.getOrderRepository(get<_i61.OrderDataSource>()));
  gh.factory<_i63.PostPurchaseOrder>(() => _i63.PostPurchaseOrder(get<_i62.OrderRepository>()));
  gh.factory<_i64.SearchDataSource>(() => searchModule.getGenresDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i65.SearchRepository>(() => searchModule.getGenresRepository(get<_i64.SearchDataSource>()));
  gh.factory<_i66.SearchSongs>(() => _i66.SearchSongs(searchRepository: get<_i65.SearchRepository>()));
  gh.factory<_i67.SetIsProPreference>(() => _i67.SetIsProPreference(get<_i30.SharedPreferencesRepository>()));
  gh.factory<_i68.SetUserGenres>(() => _i68.SetUserGenres(genresRepository: get<_i44.GenresRepository>()));
  gh.factory<_i69.ShareLink>(() => _i69.ShareLink(get<_i28.ShareLinkRepository>()));
  gh.factory<_i70.SongDataSource>(() => songModule.getSongDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i71.SongRepository>(() => songModule.getSongRepository(get<_i70.SongDataSource>()));
  gh.factory<_i72.SongbookDataSource>(
      () => songbookModule.getSongbookDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i73.SongbookRepository>(() => songbookModule.getSongbookRepository(get<_i72.SongbookDataSource>()));
  gh.singleton<_i74.SubscriptionRepository>(subscriptionModule.getSubscriptionRepository(
    get<_i39.VerifyProStatus>(),
    get<_i49.GetIsProPreference>(),
    get<_i67.SetIsProPreference>(),
  ));
  gh.factory<_i75.UpdateSongbookData>(() => _i75.UpdateSongbookData(
        get<_i73.SongbookRepository>(),
        get<_i35.UserSongbookRepository>(),
      ));
  gh.factory<_i76.UpdateSongbookPreview>(() => _i76.UpdateSongbookPreview(
        get<_i37.UserVersionRepository>(),
        get<_i35.UserSongbookRepository>(),
      ));
  gh.factory<_i77.ValidatePurchaseDataSource>(
      () => inAppPurchaseModule.getValidatePurchaseDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i78.ValidatePurchaseRepository>(() => inAppPurchaseModule.getValidatePurchaseRepository(
        get<_i12.GetOperatingSystem>(),
        get<_i77.ValidatePurchaseDataSource>(),
      ));
  gh.factory<_i79.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(get<_i42.FirebaseAnalytics>()));
  gh.factory<_i80.ArtistDataSource>(() => artistModule.getGenresDataSource(get<_i40.CifraClubAPINetworkService>()));
  gh.factory<_i81.ArtistRepository>(() => artistModule.getGenresRepository(get<_i80.ArtistDataSource>()));
  gh.factory<_i82.DeleteAllVersions>(() => _i82.DeleteAllVersions(
        get<_i73.SongbookRepository>(),
        get<_i37.UserVersionRepository>(),
        get<_i76.UpdateSongbookPreview>(),
      ));
  gh.factory<_i83.DeleteSongbook>(() => _i83.DeleteSongbook(
        get<_i73.SongbookRepository>(),
        get<_i35.UserSongbookRepository>(),
      ));
  gh.factory<_i84.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(get<_i47.GetGenres>()));
  gh.factory<_i85.GenreBottomSheet>(() => bottomSheetModule.getGenreBottomSheet(get<_i47.GetGenres>()));
  gh.factory<_i86.GetAlbumDetail>(() => _i86.GetAlbumDetail(artistRepository: get<_i81.ArtistRepository>()));
  gh.factory<_i87.GetAlbums>(() => _i87.GetAlbums(artistRepository: get<_i81.ArtistRepository>()));
  gh.factory<_i88.GetArtistInfo>(() => _i88.GetArtistInfo(artistRepository: get<_i81.ArtistRepository>()));
  gh.factory<_i89.GetArtistSongs>(() => _i89.GetArtistSongs(artistRepository: get<_i81.ArtistRepository>()));
  gh.factory<_i90.GetArtistVideoLessons>(() => _i90.GetArtistVideoLessons(get<_i81.ArtistRepository>()));
  gh.factory<_i91.GetHomeInfo>(() => _i91.GetHomeInfo(get<_i59.HomeRepository>()));
  gh.factory<_i92.GetListLimit>(() => _i92.GetListLimit(get<_i50.GetListLimitConstants>()));
  gh.factory<_i93.GetOrders>(() => _i93.GetOrders(get<_i62.OrderRepository>()));
  gh.factory<_i94.GetProStatusStream>(() => _i94.GetProStatusStream(get<_i74.SubscriptionRepository>()));
  gh.factory<_i95.GetRemoteProStatus>(() => subscriptionModule.getRemoteProStatus(get<_i93.GetOrders>()));
  gh.factory<_i96.GetTopArtists>(() => _i96.GetTopArtists(artistRepository: get<_i81.ArtistRepository>()));
  gh.factory<_i97.GetTopSongs>(() => _i97.GetTopSongs(songRepository: get<_i71.SongRepository>()));
  gh.factory<_i98.GetVersionsLimit>(() => _i98.GetVersionsLimit(get<_i57.GetVersionsLimitConstants>()));
  gh.factory<_i99.GetVersionsLimitState>(() => _i99.GetVersionsLimitState(
        get<_i54.GetTotalSongbookVersions>(),
        get<_i98.GetVersionsLimit>(),
        get<_i94.GetProStatusStream>(),
        get<_i57.GetVersionsLimitConstants>(),
      ));
  gh.factory<_i100.InsertUserGenre>(() => _i100.InsertUserGenre(
        getUserGenresAsStream: get<_i56.GetUserGenresAsStream>(),
        setUserGenres: get<_i68.SetUserGenres>(),
      ));
  gh.factory<_i101.InsertUserSongbook>(() => _i101.InsertUserSongbook(
        get<_i73.SongbookRepository>(),
        get<_i35.UserSongbookRepository>(),
      ));
  gh.factory<_i102.OpenAppOrStore>(() => _i102.OpenAppOrStore(
        openApp: get<_i24.OpenApp>(),
        openUrl: get<_i60.OpenUrl>(),
        isAppInstalled: get<_i17.IsAppInstalled>(),
        getOperatingSystem: get<_i12.GetOperatingSystem>(),
      ));
  gh.factory<_i103.PurchaseProduct>(() => _i103.PurchaseProduct(
        get<_i15.InAppPurchaseRepository>(),
        get<_i74.SubscriptionRepository>(),
      ));
  gh.factory<_i104.RefreshAllSongbooks>(() => _i104.RefreshAllSongbooks(
        get<_i73.SongbookRepository>(),
        get<_i35.UserSongbookRepository>(),
        get<_i37.UserVersionRepository>(),
        get<_i76.UpdateSongbookPreview>(),
      ));
  gh.factory<_i105.SearchAll>(() => _i105.SearchAll(searchRepository: get<_i65.SearchRepository>()));
  gh.factory<_i106.ValidatePurchase>(() => inAppPurchaseModule.getValidatePurchase(
        get<_i10.GetCredential>(),
        get<_i63.PostPurchaseOrder>(),
        get<_i78.ValidatePurchaseRepository>(),
      ));
  gh.factory<_i107.ValidatePurchases>(() => inAppPurchaseModule.getValidatePurchases(
        get<_i106.ValidatePurchase>(),
        get<_i41.CompletePurchase>(),
      ));
  gh.singleton<_i108.WatchForPurchases>(inAppPurchaseModule.getWatchForPurchases(
    get<_i15.InAppPurchaseRepository>(),
    get<_i74.SubscriptionRepository>(),
    get<_i107.ValidatePurchases>(),
  ));
  gh.singleton<_i109.WatchForSubscriptions>(subscriptionModule.getWatchForSubscriptions(
    get<_i11.GetCredentialStream>(),
    get<_i74.SubscriptionRepository>(),
    get<_i15.InAppPurchaseRepository>(),
    get<_i95.GetRemoteProStatus>(),
  ));
  gh.factory<_i110.GetListLimitState>(() => _i110.GetListLimitState(
        get<_i55.GetTotalSongbooks>(),
        get<_i94.GetProStatusStream>(),
        get<_i92.GetListLimit>(),
        get<_i50.GetListLimitConstants>(),
      ));
  gh.factory<_i111.GetVersionLimitStateByCount>(() => _i111.GetVersionLimitStateByCount(
        get<_i98.GetVersionsLimit>(),
        get<_i57.GetVersionsLimitConstants>(),
      ));
  return get;
}

class _$AuthenticationModule extends _i112.AuthenticationModule {}

class _$ControllersModule extends _i113.ControllersModule {}

class _$NavigatorModule extends _i22.NavigatorModule {}

class _$NetworkModule extends _i114.NetworkModule {}

class _$PathModule extends _i115.PathModule {}

class _$FirebaseModule extends _i116.FirebaseModule {}

class _$InAppPurchaseModule extends _i117.InAppPurchaseModule {}

class _$AppModule extends _i118.AppModule {}

class _$IsarModule extends _i119.IsarModule {}

class _$LogModule extends _i120.LogModule {}

class _$TimeModule extends _i121.TimeModule {}

class _$RemoteConfigModule extends _i122.RemoteConfigModule {}

class _$SharedPreferencesModule extends _i123.SharedPreferencesModule {}

class _$DeviceModule extends _i124.DeviceModule {}

class _$GenreModule extends _i125.GenreModule {}

class _$SongbookModule extends _i126.SongbookModule {}

class _$VersionModule extends _i127.VersionModule {}

class _$SubscriptionModule extends _i128.SubscriptionModule {}

class _$HomeModule extends _i129.HomeModule {}

class _$OrderModule extends _i130.OrderModule {}

class _$SearchModule extends _i131.SearchModule {}

class _$SongModule extends _i132.SongModule {}

class _$AnalyticsModule extends _i133.AnalyticsModule {}

class _$ArtistModule extends _i134.ArtistModule {}

class _$BottomSheetModule extends _i135.BottomSheetModule {}
