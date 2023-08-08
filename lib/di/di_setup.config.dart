// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i111;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i58;
import 'package:cifraclub/data/clients/http/network_service.dart' as _i28;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i62;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i48;
import 'package:cifraclub/data/home/data_source/home_data_source.dart' as _i87;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i91;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i98;
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart' as _i100;
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart' as _i49;
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart' as _i19;
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart' as _i33;
import 'package:cifraclub/data/subscription/data_source/persisted_purchase_data_source.dart' as _i37;
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart' as _i107;
import 'package:cifraclub/data/subscription/repository/order_repository_impl.dart' as _i35;
import 'package:cifraclub/data/subscription/repository/persisted_purchase_repository_impl.dart' as _i39;
import 'package:cifraclub/data/subscription/repository/validate_purchase_repository_impl.dart' as _i109;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i29;
import 'package:cifraclub/data/version/data_source/user_version_data_source.dart' as _i51;
import 'package:cifraclub/data/version/data_source/version_data_source.dart' as _i55;
import 'package:cifraclub/data/version/repository/version_repository.dart' as _i57;
import 'package:cifraclub/di/analytics_module.dart' as _i149;
import 'package:cifraclub/di/app_module.dart' as _i150;
import 'package:cifraclub/di/artist_module.dart' as _i151;
import 'package:cifraclub/di/authentication_module.dart' as _i152;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i153;
import 'package:cifraclub/di/controllers_module.dart' as _i154;
import 'package:cifraclub/di/device_module.dart' as _i155;
import 'package:cifraclub/di/firebase_module.dart' as _i156;
import 'package:cifraclub/di/genre_module.dart' as _i157;
import 'package:cifraclub/di/home_module.dart' as _i158;
import 'package:cifraclub/di/in_app_purchase_module.dart' as _i159;
import 'package:cifraclub/di/isar_module.dart' as _i160;
import 'package:cifraclub/di/log_module.dart' as _i161;
import 'package:cifraclub/di/navigator_module.dart' as _i27;
import 'package:cifraclub/di/network_module.dart' as _i162;
import 'package:cifraclub/di/path_module.dart' as _i163;
import 'package:cifraclub/di/remote_config_module.dart' as _i164;
import 'package:cifraclub/di/search_module.dart' as _i165;
import 'package:cifraclub/di/shared_preferences_module.dart' as _i166;
import 'package:cifraclub/di/song_module.dart' as _i167;
import 'package:cifraclub/di/songbook_module.dart' as _i168;
import 'package:cifraclub/di/subscription_module.dart' as _i169;
import 'package:cifraclub/di/time_module.dart' as _i170;
import 'package:cifraclub/di/version_module.dart' as _i171;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i110;
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart' as _i21;
import 'package:cifraclub/domain/app/repository/share_link_repository.dart' as _i43;
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart' as _i22;
import 'package:cifraclub/domain/app/use_cases/open_app.dart' as _i30;
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart' as _i138;
import 'package:cifraclub/domain/app/use_cases/share_link.dart' as _i97;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i112;
import 'package:cifraclub/domain/artist/use_cases/favorite_unfavorite_artist.dart' as _i117;
import 'package:cifraclub/domain/artist/use_cases/get_album_detail.dart' as _i119;
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart' as _i120;
import 'package:cifraclub/domain/artist/use_cases/get_alphabetical_prefixes_list.dart' as _i11;
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart' as _i122;
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart' as _i123;
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart' as _i124;
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart' as _i14;
import 'package:cifraclub/domain/artist/use_cases/get_filtered_artist_songs.dart' as _i15;
import 'package:cifraclub/domain/artist/use_cases/get_is_artist_fan.dart' as _i126;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i129;
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart' as _i16;
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart' as _i47;
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart' as _i89;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i63;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i67;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i83;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i133;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i96;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i88;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i125;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart' as _i127;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart' as _i147;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart' as _i131;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart' as _i132;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart' as _i148;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i24;
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart' as _i45;
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart' as _i71;
import 'package:cifraclub/domain/preferences/use_cases/get_list_order_type_preference.dart' as _i73;
import 'package:cifraclub/domain/preferences/use_cases/set_is_pro_preference.dart' as _i94;
import 'package:cifraclub/domain/preferences/use_cases/set_list_order_type_preference.dart' as _i95;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i42;
import 'package:cifraclub/domain/remote_config/use_cases/get_artist_image_path.dart' as _i65;
import 'package:cifraclub/domain/remote_config/use_cases/get_image_prefix_url.dart' as _i68;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i69;
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart' as _i72;
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart' as _i78;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i80;
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart' as _i85;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i92;
import 'package:cifraclub/domain/search/use_cases/search_all_use_case.dart' as _i141;
import 'package:cifraclub/domain/search/use_cases/search_songs.dart' as _i93;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i99;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i130;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i101;
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart' as _i50;
import 'package:cifraclub/domain/songbook/use_cases/clear_songs_from_songbook.dart' as _i113;
import 'package:cifraclub/domain/songbook/use_cases/clear_user_songbooks_on_logout.dart' as _i59;
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart' as _i114;
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart' as _i115;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i121;
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart' as _i64;
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart' as _i70;
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_stream_by_id.dart' as _i79;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart' as _i81;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart' as _i82;
import 'package:cifraclub/domain/songbook/use_cases/get_versions_stream_by_songbook_id.dart' as _i86;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i134;
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart' as _i135;
import 'package:cifraclub/domain/songbook/use_cases/insert_versions_to_songbook.dart' as _i136;
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart' as _i140;
import 'package:cifraclub/domain/songbook/use_cases/sort_versions_from_songbook.dart' as _i102;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart' as _i105;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart' as _i106;
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart' as _i53;
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart' as _i20;
import 'package:cifraclub/domain/subscription/repository/order_repository.dart' as _i34;
import 'package:cifraclub/domain/subscription/repository/persisted_purchase_repository.dart' as _i38;
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart' as _i103;
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart' as _i108;
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart' as _i60;
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart' as _i74;
import 'package:cifraclub/domain/subscription/use_cases/get_persisted_purchase.dart' as _i75;
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart' as _i128;
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart' as _i76;
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart' as _i77;
import 'package:cifraclub/domain/subscription/use_cases/persist_purchase.dart' as _i90;
import 'package:cifraclub/domain/subscription/use_cases/post_persistent_purchase_order.dart' as _i40;
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart' as _i41;
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart' as _i139;
import 'package:cifraclub/domain/subscription/use_cases/update_pro_status_with_purchase_result.dart' as _i104;
import 'package:cifraclub/domain/subscription/use_cases/validate_persisted_purchase.dart' as _i142;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart' as _i143;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart' as _i144;
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart' as _i54;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart' as _i145;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart' as _i146;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i46;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i66;
import 'package:cifraclub/domain/user/repository/authentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i12;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i13;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i25;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i31;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i32;
import 'package:cifraclub/domain/version/repository/user_version_repository.dart' as _i52;
import 'package:cifraclub/domain/version/repository/version_repository.dart' as _i56;
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart' as _i17;
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart' as _i84;
import 'package:cifraclub/domain/version/use_cases/parse_sections.dart' as _i36;
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart' as _i116;
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart' as _i118;
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet.dart' as _i137;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart' as _i8;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i61;
import 'package:firebase_core/firebase_core.dart' as _i9;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:in_app_purchase/in_app_purchase.dart' as _i18;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i23;
import 'package:nav/nav.dart' as _i26;
import 'package:shared_preferences/shared_preferences.dart' as _i44;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
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
  gh.singleton<_i10.FirebaseCrashlytics>(firebaseModule.getFirebaseCrashlytics(gh<_i9.FirebaseApp>()));
  gh.factory<_i11.GetAlphabeticalPrefixesList>(() => _i11.GetAlphabeticalPrefixesList());
  gh.factory<_i12.GetCredential>(() => _i12.GetCredential(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i13.GetCredentialStream>(() => _i13.GetCredentialStream(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i14.GetDefaultInstruments>(() => _i14.GetDefaultInstruments());
  gh.factory<_i15.GetFilteredArtistSongs>(() => _i15.GetFilteredArtistSongs());
  gh.factory<_i16.GetOperatingSystem>(() => _i16.GetOperatingSystem());
  gh.factory<_i17.GetOrderedVersions>(() => _i17.GetOrderedVersions());
  gh.singleton<_i18.InAppPurchase>(inAppPurchaseModule.getInAppPurchase());
  gh.singleton<_i19.InAppPurchaseDataSource>(inAppPurchaseModule.getInAppPurchaseDataSource(gh<_i18.InAppPurchase>()));
  gh.singleton<_i20.InAppPurchaseRepository>(
      inAppPurchaseModule.getInAppPurchaseRepository(gh<_i19.InAppPurchaseDataSource>()));
  gh.factory<_i21.InstalledAppRepository>(() => appModule.getInstalledAppRepository(gh<_i16.GetOperatingSystem>()));
  gh.factory<_i22.IsAppInstalled>(() => _i22.IsAppInstalled(installedAppRepository: gh<_i21.InstalledAppRepository>()));
  await gh.singletonAsync<_i23.Isar>(
    () => isarModule.getIsar(gh<_i7.Directory>(instanceName: 'InternalDocuments')),
    preResolve: true,
  );
  gh.singleton<_i24.LogRepository>(logModule.getLogRepository(gh<_i10.FirebaseCrashlytics>()));
  gh.factory<_i25.Logout>(() => _i25.Logout(gh<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i26.Nav, _i27.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        gh<_i5.DeepLinkParser>(),
      ));
  gh.factory<_i28.NetworkService>(() => networkModule.getNetworkService(
        gh<_i6.Dio>(),
        gh<_i12.GetCredential>(),
      ));
  gh.factory<_i29.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i30.OpenApp>(() => _i30.OpenApp(installedAppRepository: gh<_i21.InstalledAppRepository>()));
  gh.factory<_i31.OpenLoginPage>(() => _i31.OpenLoginPage(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i32.OpenUserProfilePage>(() => _i32.OpenUserProfilePage(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i33.OrderDataSource>(() => _i33.OrderDataSource(
        networkService: gh<_i28.NetworkService>(),
        getOperatingSystem: gh<_i16.GetOperatingSystem>(),
      ));
  gh.factory<_i34.OrderRepository>(() => _i35.OrderRepositoryImpl(dataSource: gh<_i33.OrderDataSource>()));
  gh.factory<_i36.ParseSections>(() => _i36.ParseSections());
  gh.factory<_i37.PersistedPurchaseDataSource>(() => _i37.PersistedPurchaseDataSource(isar: gh<_i23.Isar>()));
  gh.factory<_i38.PersistedPurchaseRepository>(
      () => _i39.PersistedPurchaseRepositoryImpl(gh<_i37.PersistedPurchaseDataSource>()));
  gh.factory<_i40.PostPersistentPurchaseOrder>(() => _i40.PostPersistentPurchaseOrder(gh<_i34.OrderRepository>()));
  gh.factory<_i41.PostPurchaseOrder>(() => _i41.PostPurchaseOrder(gh<_i34.OrderRepository>()));
  gh.singleton<_i42.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(gh<_i9.FirebaseApp>()));
  gh.factory<_i43.ShareLinkRepository>(() => appModule.getShareLinkRepository(gh<_i16.GetOperatingSystem>()));
  await gh.singletonAsync<_i44.SharedPreferences>(
    () => sharedPreferencesModule.getSharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i45.SharedPreferencesRepository>(
      () => sharedPreferencesModule.getPreferencesRepository(gh<_i44.SharedPreferences>()));
  gh.factory<_i46.TimeRepository>(() => timeModule.getTimeRepository(gh<_i29.NtpDataSource>()));
  gh.factory<_i47.UrlLauncherRepository>(() => deviceModule.getUrlLauncherRepository());
  gh.factory<_i48.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(gh<_i23.Isar>()));
  gh.factory<_i49.UserSongbookDataSource>(() => songbookModule.getUserSongbookDataSource(gh<_i23.Isar>()));
  gh.factory<_i50.UserSongbookRepository>(
      () => songbookModule.getUserSongbookRepository(gh<_i49.UserSongbookDataSource>()));
  gh.factory<_i51.UserVersionDataSource>(() => versionModule.getUserVersionDataSource(gh<_i23.Isar>()));
  gh.factory<_i52.UserVersionRepository>(
      () => versionModule.getUserVersionRepository(gh<_i51.UserVersionDataSource>()));
  gh.factory<_i53.ValidateSongbookName>(() => _i53.ValidateSongbookName(gh<_i50.UserSongbookRepository>()));
  gh.factory<_i54.VerifyProStatus>(() => subscriptionModule.getVerifyProStatus());
  gh.factory<_i55.VersionDataSource>(() => _i55.VersionDataSource(gh<_i28.NetworkService>()));
  gh.factory<_i56.VersionRepository>(() => _i57.VersionRepositoryImpl(gh<_i55.VersionDataSource>()));
  gh.singleton<_i58.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(
    gh<_i6.Dio>(),
    gh<_i12.GetCredential>(),
  ));
  gh.singleton<_i59.ClearUserSongbooksOnLogout>(_i59.ClearUserSongbooksOnLogout(
    gh<_i50.UserSongbookRepository>(),
    gh<_i52.UserVersionRepository>(),
    gh<_i13.GetCredentialStream>(),
  ));
  gh.factory<_i60.CompletePurchase>(() => _i60.CompletePurchase(gh<_i20.InAppPurchaseRepository>()));
  gh.singleton<_i61.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(gh<_i9.FirebaseApp>()));
  gh.factory<_i62.GenresDataSource>(() => genreModule.getGenresDataSource(gh<_i58.CifraClubAPINetworkService>()));
  gh.factory<_i63.GenresRepository>(() => genreModule.getGenresRepository(
        gh<_i62.GenresDataSource>(),
        gh<_i48.UserGenreDataSource>(),
      ));
  gh.factory<_i64.GetAllVersionsFromSongbook>(() => _i64.GetAllVersionsFromSongbook(gh<_i52.UserVersionRepository>()));
  gh.factory<_i65.GetArtistImagePathUrl>(() => _i65.GetArtistImagePathUrl(gh<_i42.RemoteConfigRepository>()));
  gh.factory<_i66.GetCurrentTime>(() => _i66.GetCurrentTime(gh<_i46.TimeRepository>()));
  gh.factory<_i67.GetGenres>(() => _i67.GetGenres(genresRepository: gh<_i63.GenresRepository>()));
  gh.factory<_i68.GetImagePrefixUrl>(() => _i68.GetImagePrefixUrl(gh<_i42.RemoteConfigRepository>()));
  gh.factory<_i69.GetInstrumentUrls>(() => _i69.GetInstrumentUrls(gh<_i42.RemoteConfigRepository>()));
  gh.factory<_i70.GetIsFavoriteVersionBySongId>(
      () => _i70.GetIsFavoriteVersionBySongId(gh<_i52.UserVersionRepository>()));
  gh.factory<_i71.GetIsProPreference>(() => _i71.GetIsProPreference(gh<_i45.SharedPreferencesRepository>()));
  gh.factory<_i72.GetListLimitConstants>(() => _i72.GetListLimitConstants(gh<_i42.RemoteConfigRepository>()));
  gh.factory<_i73.GetListOrderTypePreferences>(
      () => _i73.GetListOrderTypePreferences(gh<_i45.SharedPreferencesRepository>()));
  gh.factory<_i74.GetOrders>(() => _i74.GetOrders(gh<_i34.OrderRepository>()));
  gh.factory<_i75.GetPersistedPurchase>(() => _i75.GetPersistedPurchase(gh<_i38.PersistedPurchaseRepository>()));
  gh.factory<_i76.GetProducts>(() => _i76.GetProducts(gh<_i20.InAppPurchaseRepository>()));
  gh.factory<_i77.GetRemoteProStatus>(() => subscriptionModule.getRemoteProStatus(gh<_i74.GetOrders>()));
  gh.factory<_i78.GetRemoteProductsIds>(() => _i78.GetRemoteProductsIds(gh<_i42.RemoteConfigRepository>()));
  gh.factory<_i79.GetSongbookStreamById>(() => _i79.GetSongbookStreamById(gh<_i50.UserSongbookRepository>()));
  gh.factory<_i80.GetTimeBetweenInterstitials>(
      () => _i80.GetTimeBetweenInterstitials(gh<_i42.RemoteConfigRepository>()));
  gh.factory<_i81.GetTotalSongbookVersions>(() => _i81.GetTotalSongbookVersions(gh<_i52.UserVersionRepository>()));
  gh.factory<_i82.GetTotalSongbooks>(() => _i82.GetTotalSongbooks(gh<_i50.UserSongbookRepository>()));
  gh.factory<_i83.GetUserGenresAsStream>(
      () => _i83.GetUserGenresAsStream(genresRepository: gh<_i63.GenresRepository>()));
  gh.factory<_i84.GetVersionData>(() => _i84.GetVersionData(gh<_i56.VersionRepository>()));
  gh.factory<_i85.GetVersionsLimitConstants>(() => _i85.GetVersionsLimitConstants(gh<_i42.RemoteConfigRepository>()));
  gh.factory<_i86.GetVersionsStreamBySongbookId>(
      () => _i86.GetVersionsStreamBySongbookId(gh<_i52.UserVersionRepository>()));
  gh.factory<_i87.HomeDataSource>(() => homeModule.getHomeDataSource(gh<_i58.CifraClubAPINetworkService>()));
  gh.factory<_i88.HomeRepository>(() => homeModule.getHomeRepository(gh<_i87.HomeDataSource>()));
  gh.factory<_i89.OpenUrl>(() => _i89.OpenUrl(urlLauncherRepository: gh<_i47.UrlLauncherRepository>()));
  gh.factory<_i90.PersistPurchase>(() => _i90.PersistPurchase(gh<_i38.PersistedPurchaseRepository>()));
  gh.factory<_i91.SearchDataSource>(() => searchModule.getGenresDataSource(gh<_i58.CifraClubAPINetworkService>()));
  gh.factory<_i92.SearchRepository>(() => searchModule.getGenresRepository(gh<_i91.SearchDataSource>()));
  gh.factory<_i93.SearchSongs>(() => _i93.SearchSongs(searchRepository: gh<_i92.SearchRepository>()));
  gh.factory<_i94.SetIsProPreference>(() => _i94.SetIsProPreference(gh<_i45.SharedPreferencesRepository>()));
  gh.factory<_i95.SetListOrderTypePreferences>(
      () => _i95.SetListOrderTypePreferences(gh<_i45.SharedPreferencesRepository>()));
  gh.factory<_i96.SetUserGenres>(() => _i96.SetUserGenres(genresRepository: gh<_i63.GenresRepository>()));
  gh.factory<_i97.ShareLink>(() => _i97.ShareLink(gh<_i43.ShareLinkRepository>()));
  gh.factory<_i98.SongDataSource>(() => songModule.getSongDataSource(gh<_i58.CifraClubAPINetworkService>()));
  gh.factory<_i99.SongRepository>(() => songModule.getSongRepository(gh<_i98.SongDataSource>()));
  gh.factory<_i100.SongbookDataSource>(
      () => songbookModule.getSongbookDataSource(gh<_i58.CifraClubAPINetworkService>()));
  gh.factory<_i101.SongbookRepository>(() => songbookModule.getSongbookRepository(gh<_i100.SongbookDataSource>()));
  gh.factory<_i102.SortVersionsFromSongbook>(() => _i102.SortVersionsFromSongbook(
        gh<_i101.SongbookRepository>(),
        gh<_i52.UserVersionRepository>(),
      ));
  gh.singleton<_i103.SubscriptionRepository>(subscriptionModule.getSubscriptionRepository(
    gh<_i54.VerifyProStatus>(),
    gh<_i71.GetIsProPreference>(),
    gh<_i94.SetIsProPreference>(),
  ));
  gh.factory<_i104.UpdateProStatusWithPurchaseResult>(
      () => _i104.UpdateProStatusWithPurchaseResult(gh<_i103.SubscriptionRepository>()));
  gh.factory<_i105.UpdateSongbookData>(() => _i105.UpdateSongbookData(
        gh<_i101.SongbookRepository>(),
        gh<_i50.UserSongbookRepository>(),
      ));
  gh.factory<_i106.UpdateSongbookPreview>(() => _i106.UpdateSongbookPreview(
        gh<_i52.UserVersionRepository>(),
        gh<_i50.UserSongbookRepository>(),
      ));
  gh.factory<_i107.ValidatePurchaseDataSource>(
      () => inAppPurchaseModule.getValidatePurchaseDataSource(gh<_i58.CifraClubAPINetworkService>()));
  gh.factory<_i108.ValidatePurchaseRepository>(() => _i109.ValidatePurchaseRepositoryImpl(
        getOperatingSystem: gh<_i16.GetOperatingSystem>(),
        validatePurchaseDataSource: gh<_i107.ValidatePurchaseDataSource>(),
      ));
  gh.factory<_i110.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(gh<_i61.FirebaseAnalytics>()));
  gh.factory<_i111.ArtistDataSource>(() => artistModule.getGenresDataSource(gh<_i58.CifraClubAPINetworkService>()));
  gh.factory<_i112.ArtistRepository>(() => artistModule.getGenresRepository(gh<_i111.ArtistDataSource>()));
  gh.factory<_i113.ClearSongsFromSongbook>(() => _i113.ClearSongsFromSongbook(
        gh<_i101.SongbookRepository>(),
        gh<_i52.UserVersionRepository>(),
        gh<_i106.UpdateSongbookPreview>(),
      ));
  gh.factory<_i114.DeleteSongbook>(() => _i114.DeleteSongbook(
        gh<_i101.SongbookRepository>(),
        gh<_i50.UserSongbookRepository>(),
        gh<_i52.UserVersionRepository>(),
      ));
  gh.factory<_i115.DeleteVersions>(() => _i115.DeleteVersions(
        gh<_i101.SongbookRepository>(),
        gh<_i52.UserVersionRepository>(),
        gh<_i50.UserSongbookRepository>(),
      ));
  gh.factory<_i116.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(gh<_i67.GetGenres>()));
  gh.factory<_i117.FavoriteUnfavoriteArtist>(
      () => _i117.FavoriteUnfavoriteArtist(artistRepository: gh<_i112.ArtistRepository>()));
  gh.factory<_i118.GenreBottomSheet>(() => bottomSheetModule.getGenreBottomSheet(gh<_i67.GetGenres>()));
  gh.factory<_i119.GetAlbumDetail>(() => _i119.GetAlbumDetail(artistRepository: gh<_i112.ArtistRepository>()));
  gh.factory<_i120.GetAlbums>(() => _i120.GetAlbums(artistRepository: gh<_i112.ArtistRepository>()));
  gh.factory<_i121.GetAllUserSongbooks>(() => _i121.GetAllUserSongbooks(
        gh<_i50.UserSongbookRepository>(),
        gh<_i68.GetImagePrefixUrl>(),
        gh<_i65.GetArtistImagePathUrl>(),
      ));
  gh.factory<_i122.GetArtistInfo>(() => _i122.GetArtistInfo(artistRepository: gh<_i112.ArtistRepository>()));
  gh.factory<_i123.GetArtistSongs>(() => _i123.GetArtistSongs(artistRepository: gh<_i112.ArtistRepository>()));
  gh.factory<_i124.GetArtistVideoLessons>(() => _i124.GetArtistVideoLessons(gh<_i112.ArtistRepository>()));
  gh.factory<_i125.GetHomeInfo>(() => _i125.GetHomeInfo(gh<_i88.HomeRepository>()));
  gh.factory<_i126.GetIsArtistFan>(() => _i126.GetIsArtistFan(artistRepository: gh<_i112.ArtistRepository>()));
  gh.factory<_i127.GetListLimit>(() => _i127.GetListLimit(gh<_i72.GetListLimitConstants>()));
  gh.factory<_i128.GetProStatusStream>(() => _i128.GetProStatusStream(gh<_i103.SubscriptionRepository>()));
  gh.factory<_i129.GetTopArtists>(() => _i129.GetTopArtists(artistRepository: gh<_i112.ArtistRepository>()));
  gh.factory<_i130.GetTopSongs>(() => _i130.GetTopSongs(songRepository: gh<_i99.SongRepository>()));
  gh.factory<_i131.GetVersionsLimit>(() => _i131.GetVersionsLimit(gh<_i85.GetVersionsLimitConstants>()));
  gh.factory<_i132.GetVersionsLimitState>(() => _i132.GetVersionsLimitState(
        gh<_i81.GetTotalSongbookVersions>(),
        gh<_i131.GetVersionsLimit>(),
        gh<_i128.GetProStatusStream>(),
        gh<_i85.GetVersionsLimitConstants>(),
      ));
  gh.factory<_i133.InsertUserGenre>(() => _i133.InsertUserGenre(
        getUserGenresAsStream: gh<_i83.GetUserGenresAsStream>(),
        setUserGenres: gh<_i96.SetUserGenres>(),
      ));
  gh.factory<_i134.InsertUserSongbook>(() => _i134.InsertUserSongbook(
        gh<_i101.SongbookRepository>(),
        gh<_i50.UserSongbookRepository>(),
      ));
  gh.factory<_i135.InsertVersionToSongbook>(() => _i135.InsertVersionToSongbook(
        gh<_i101.SongbookRepository>(),
        gh<_i52.UserVersionRepository>(),
        gh<_i50.UserSongbookRepository>(),
      ));
  gh.factory<_i136.InsertVersionsToSongbook>(() => _i136.InsertVersionsToSongbook(
        gh<_i101.SongbookRepository>(),
        gh<_i52.UserVersionRepository>(),
        gh<_i50.UserSongbookRepository>(),
      ));
  gh.factory<_i137.ListOptionsBottomSheet>(() => bottomSheetModule.getListOptionsBottomSheet(
        gh<_i114.DeleteSongbook>(),
        gh<_i105.UpdateSongbookData>(),
        gh<_i53.ValidateSongbookName>(),
        gh<_i113.ClearSongsFromSongbook>(),
        gh<_i97.ShareLink>(),
        gh<_i8.EditListScreenBuilder>(),
      ));
  gh.factory<_i138.OpenAppOrStore>(() => _i138.OpenAppOrStore(
        openApp: gh<_i30.OpenApp>(),
        openUrl: gh<_i89.OpenUrl>(),
        isAppInstalled: gh<_i22.IsAppInstalled>(),
        getOperatingSystem: gh<_i16.GetOperatingSystem>(),
      ));
  gh.factory<_i139.PurchaseProduct>(() => _i139.PurchaseProduct(
        gh<_i20.InAppPurchaseRepository>(),
        gh<_i103.SubscriptionRepository>(),
      ));
  gh.factory<_i140.RefreshAllSongbooks>(() => _i140.RefreshAllSongbooks(
        gh<_i101.SongbookRepository>(),
        gh<_i50.UserSongbookRepository>(),
        gh<_i52.UserVersionRepository>(),
        gh<_i106.UpdateSongbookPreview>(),
      ));
  gh.factory<_i141.SearchAll>(() => _i141.SearchAll(searchRepository: gh<_i92.SearchRepository>()));
  gh.factory<_i142.ValidatePersistedPurchase>(() => _i142.ValidatePersistedPurchase(
        gh<_i12.GetCredential>(),
        gh<_i40.PostPersistentPurchaseOrder>(),
        gh<_i108.ValidatePurchaseRepository>(),
        gh<_i104.UpdateProStatusWithPurchaseResult>(),
        gh<_i75.GetPersistedPurchase>(),
      ));
  gh.factory<_i143.ValidatePurchase>(() => inAppPurchaseModule.getValidatePurchase(
        gh<_i12.GetCredential>(),
        gh<_i41.PostPurchaseOrder>(),
        gh<_i108.ValidatePurchaseRepository>(),
      ));
  gh.factory<_i144.ValidatePurchases>(() => _i144.ValidatePurchases(
        gh<_i143.ValidatePurchase>(),
        gh<_i60.CompletePurchase>(),
        gh<_i90.PersistPurchase>(),
      ));
  gh.singleton<_i145.WatchForPurchases>(_i145.WatchForPurchases(
    gh<_i20.InAppPurchaseRepository>(),
    gh<_i144.ValidatePurchases>(),
    gh<_i104.UpdateProStatusWithPurchaseResult>(),
  ));
  gh.singleton<_i146.WatchForSubscriptions>(_i146.WatchForSubscriptions(
    gh<_i13.GetCredentialStream>(),
    gh<_i103.SubscriptionRepository>(),
    gh<_i77.GetRemoteProStatus>(),
    gh<_i142.ValidatePersistedPurchase>(),
  ));
  gh.factory<_i147.GetListLimitState>(() => _i147.GetListLimitState(
        gh<_i82.GetTotalSongbooks>(),
        gh<_i128.GetProStatusStream>(),
        gh<_i127.GetListLimit>(),
        gh<_i72.GetListLimitConstants>(),
      ));
  gh.factory<_i148.GetVersionLimitStateByCount>(() => _i148.GetVersionLimitStateByCount(
        gh<_i131.GetVersionsLimit>(),
        gh<_i85.GetVersionsLimitConstants>(),
      ));
  return getIt;
}

class _$AnalyticsModule extends _i149.AnalyticsModule {}

class _$AppModule extends _i150.AppModule {}

class _$ArtistModule extends _i151.ArtistModule {}

class _$AuthenticationModule extends _i152.AuthenticationModule {}

class _$BottomSheetModule extends _i153.BottomSheetModule {}

class _$ControllersModule extends _i154.ControllersModule {}

class _$DeviceModule extends _i155.DeviceModule {}

class _$FirebaseModule extends _i156.FirebaseModule {}

class _$GenreModule extends _i157.GenreModule {}

class _$HomeModule extends _i158.HomeModule {}

class _$InAppPurchaseModule extends _i159.InAppPurchaseModule {}

class _$IsarModule extends _i160.IsarModule {}

class _$LogModule extends _i161.LogModule {}

class _$NavigatorModule extends _i27.NavigatorModule {}

class _$NetworkModule extends _i162.NetworkModule {}

class _$PathModule extends _i163.PathModule {}

class _$RemoteConfigModule extends _i164.RemoteConfigModule {}

class _$SearchModule extends _i165.SearchModule {}

class _$SharedPreferencesModule extends _i166.SharedPreferencesModule {}

class _$SongModule extends _i167.SongModule {}

class _$SongbookModule extends _i168.SongbookModule {}

class _$SubscriptionModule extends _i169.SubscriptionModule {}

class _$TimeModule extends _i170.TimeModule {}

class _$VersionModule extends _i171.VersionModule {}
