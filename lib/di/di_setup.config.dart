// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart' as _i137;
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart' as _i73;
import 'package:cifraclub/data/clients/http/network_service.dart' as _i34;
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart' as _i80;
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart' as _i57;
import 'package:cifraclub/data/home/data_source/home_data_source.dart' as _i107;
import 'package:cifraclub/data/search/data_source/search_data_source.dart' as _i114;
import 'package:cifraclub/data/song/data_source/song_data_source.dart' as _i122;
import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart' as _i124;
import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart' as _i58;
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart' as _i24;
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart' as _i39;
import 'package:cifraclub/data/subscription/data_source/persisted_purchase_data_source.dart' as _i43;
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart' as _i132;
import 'package:cifraclub/data/subscription/repository/order_repository_impl.dart' as _i41;
import 'package:cifraclub/data/subscription/repository/persisted_purchase_repository_impl.dart' as _i45;
import 'package:cifraclub/data/subscription/repository/validate_purchase_repository_impl.dart' as _i134;
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart' as _i35;
import 'package:cifraclub/data/version/data_source/user_version_data_source.dart' as _i60;
import 'package:cifraclub/data/version/data_source/version_data_source.dart' as _i64;
import 'package:cifraclub/data/version/repository/version_repository_impl.dart' as _i67;
import 'package:cifraclub/data/youtube/data_source/youtube_data_source.dart' as _i68;
import 'package:cifraclub/data/youtube/repository/youtube_repository_impl.dart' as _i70;
import 'package:cifraclub/di/analytics_module.dart' as _i198;
import 'package:cifraclub/di/app_module.dart' as _i202;
import 'package:cifraclub/di/artist_module.dart' as _i195;
import 'package:cifraclub/di/authentication_module.dart' as _i188;
import 'package:cifraclub/di/bottom_sheet_module.dart' as _i205;
import 'package:cifraclub/di/controllers_module.dart' as _i206;
import 'package:cifraclub/di/device_info_module.dart' as _i209;
import 'package:cifraclub/di/device_module.dart' as _i207;
import 'package:cifraclub/di/firebase_module.dart' as _i191;
import 'package:cifraclub/di/genre_module.dart' as _i201;
import 'package:cifraclub/di/home_module.dart' as _i194;
import 'package:cifraclub/di/in_app_purchase_module.dart' as _i192;
import 'package:cifraclub/di/isar_module.dart' as _i208;
import 'package:cifraclub/di/log_module.dart' as _i189;
import 'package:cifraclub/di/navigator_module.dart' as _i33;
import 'package:cifraclub/di/network_module.dart' as _i204;
import 'package:cifraclub/di/path_module.dart' as _i185;
import 'package:cifraclub/di/permission_module.dart' as _i187;
import 'package:cifraclub/di/remote_config_module.dart' as _i203;
import 'package:cifraclub/di/search_module.dart' as _i190;
import 'package:cifraclub/di/shared_preferences_module.dart' as _i197;
import 'package:cifraclub/di/song_module.dart' as _i196;
import 'package:cifraclub/di/songbook_module.dart' as _i200;
import 'package:cifraclub/di/subscription_module.dart' as _i186;
import 'package:cifraclub/di/time_module.dart' as _i193;
import 'package:cifraclub/di/version_module.dart' as _i199;
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart' as _i136;
import 'package:cifraclub/domain/app/repository/device_info_repository.dart' as _i78;
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart' as _i26;
import 'package:cifraclub/domain/app/repository/share_link_repository.dart' as _i51;
import 'package:cifraclub/domain/app/use_cases/deep_link_handler.dart' as _i77;
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart' as _i27;
import 'package:cifraclub/domain/app/use_cases/open_app.dart' as _i36;
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart' as _i169;
import 'package:cifraclub/domain/app/use_cases/share_link.dart' as _i121;
import 'package:cifraclub/domain/artist/repository/artist_repository.dart' as _i138;
import 'package:cifraclub/domain/artist/use_cases/favorite_unfavorite_artist.dart' as _i144;
import 'package:cifraclub/domain/artist/use_cases/get_album_detail.dart' as _i146;
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart' as _i147;
import 'package:cifraclub/domain/artist/use_cases/get_alphabetical_prefixes_list.dart' as _i12;
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart' as _i148;
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart' as _i149;
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs_filtered_by_search.dart' as _i13;
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart' as _i150;
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart' as _i18;
import 'package:cifraclub/domain/artist/use_cases/get_filtered_artist_songs.dart' as _i19;
import 'package:cifraclub/domain/artist/use_cases/get_is_artist_fan.dart' as _i152;
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart' as _i158;
import 'package:cifraclub/domain/chord/use_cases/get_chords_representation.dart' as _i15;
import 'package:cifraclub/domain/chord/use_cases/get_instrument_chords.dart' as _i20;
import 'package:cifraclub/domain/device/operating_system/models/os_version.dart' as _i111;
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart' as _i21;
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart' as _i56;
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart' as _i110;
import 'package:cifraclub/domain/genre/repository/genres_repository.dart' as _i81;
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart' as _i86;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart' as _i102;
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart' as _i162;
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart' as _i120;
import 'package:cifraclub/domain/home/repository/home_repository.dart' as _i108;
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart' as _i151;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart' as _i153;
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart' as _i179;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart' as _i160;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart' as _i161;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart' as _i180;
import 'package:cifraclub/domain/log/repository/log_repository.dart' as _i30;
import 'package:cifraclub/domain/permission/repository/permission_repository.dart' as _i112;
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart' as _i53;
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart' as _i90;
import 'package:cifraclub/domain/preferences/use_cases/get_list_order_type_preference.dart' as _i92;
import 'package:cifraclub/domain/preferences/use_cases/set_is_pro_preference.dart' as _i118;
import 'package:cifraclub/domain/preferences/use_cases/set_list_order_type_preference.dart' as _i119;
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart' as _i49;
import 'package:cifraclub/domain/remote_config/use_cases/get_artist_image_path.dart' as _i84;
import 'package:cifraclub/domain/remote_config/use_cases/get_image_prefix_url.dart' as _i87;
import 'package:cifraclub/domain/remote_config/use_cases/get_instrument_urls.dart' as _i88;
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart' as _i91;
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart' as _i97;
import 'package:cifraclub/domain/remote_config/use_cases/get_time_between_interstitials.dart' as _i99;
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart' as _i104;
import 'package:cifraclub/domain/search/repository/search_repository.dart' as _i115;
import 'package:cifraclub/domain/search/repository/shazam_repository.dart' as _i54;
import 'package:cifraclub/domain/search/use_cases/search.dart' as _i172;
import 'package:cifraclub/domain/search/use_cases/search_shazam.dart' as _i116;
import 'package:cifraclub/domain/search/use_cases/search_songs.dart' as _i117;
import 'package:cifraclub/domain/section/use_cases/parse_sections.dart' as _i42;
import 'package:cifraclub/domain/section/use_cases/process_sections.dart' as _i48;
import 'package:cifraclub/domain/song/repository/local_songs_repository.dart' as _i109;
import 'package:cifraclub/domain/song/repository/song_repository.dart' as _i123;
import 'package:cifraclub/domain/song/use_cases/get_local_song_image.dart' as _i154;
import 'package:cifraclub/domain/song/use_cases/get_local_songs.dart' as _i155;
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart' as _i159;
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart' as _i125;
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart' as _i59;
import 'package:cifraclub/domain/songbook/use_cases/clear_user_songbooks_on_logout.dart' as _i74;
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart' as _i139;
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart' as _i140;
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites.dart' as _i141;
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart' as _i142;
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart' as _i82;
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart' as _i83;
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart' as _i89;
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_by_id.dart' as _i157;
import 'package:cifraclub/domain/songbook/use_cases/get_songbook_stream_by_id.dart' as _i98;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart' as _i100;
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart' as _i101;
import 'package:cifraclub/domain/songbook/use_cases/get_versions_stream_by_songbook_id.dart' as _i105;
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart' as _i163;
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_recents.dart' as _i181;
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart' as _i164;
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart' as _i165;
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart' as _i171;
import 'package:cifraclub/domain/songbook/use_cases/sort_versions_from_songbook.dart' as _i173;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart' as _i128;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_last_updated.dart' as _i129;
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart' as _i130;
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart' as _i131;
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart' as _i62;
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart' as _i25;
import 'package:cifraclub/domain/subscription/repository/order_repository.dart' as _i40;
import 'package:cifraclub/domain/subscription/repository/persisted_purchase_repository.dart' as _i44;
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart' as _i126;
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart' as _i133;
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart' as _i75;
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart' as _i93;
import 'package:cifraclub/domain/subscription/use_cases/get_persisted_purchase.dart' as _i94;
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart' as _i156;
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart' as _i95;
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart' as _i96;
import 'package:cifraclub/domain/subscription/use_cases/persist_purchase.dart' as _i113;
import 'package:cifraclub/domain/subscription/use_cases/post_persistent_purchase_order.dart' as _i46;
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart' as _i47;
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart' as _i170;
import 'package:cifraclub/domain/subscription/use_cases/update_pro_status_with_purchase_result.dart' as _i127;
import 'package:cifraclub/domain/subscription/use_cases/validate_persisted_purchase.dart' as _i174;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart' as _i175;
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart' as _i176;
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart' as _i63;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart' as _i177;
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart' as _i178;
import 'package:cifraclub/domain/time/repository/time_repository.dart' as _i55;
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart' as _i85;
import 'package:cifraclub/domain/user/repository/authentication_repository.dart' as _i3;
import 'package:cifraclub/domain/user/use_cases/get_credential.dart' as _i16;
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart' as _i17;
import 'package:cifraclub/domain/user/use_cases/logout.dart' as _i31;
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart' as _i37;
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart' as _i38;
import 'package:cifraclub/domain/version/repository/user_version_repository.dart' as _i61;
import 'package:cifraclub/domain/version/repository/version_repository.dart' as _i66;
import 'package:cifraclub/domain/version/use_cases/get_all_instrument_versions.dart' as _i11;
import 'package:cifraclub/domain/version/use_cases/get_auto_scroll_stream.dart' as _i14;
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart' as _i22;
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart' as _i103;
import 'package:cifraclub/domain/youtube/repository/youtube_repository.dart' as _i69;
import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart' as _i106;
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart' as _i143;
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart' as _i145;
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet.dart' as _i166;
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet.dart' as _i167;
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart'
    as _i182;
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart'
    as _i184;
import 'package:cifraclub/presentation/navigator/deep_link_parser.dart' as _i5;
import 'package:cifraclub/presentation/navigator/navigators_controller.dart' as _i168;
import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart' as _i50;
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart' as _i8;
import 'package:cifraclub/presentation/screens/version/middlewares/auto_scroll_middleware.dart' as _i71;
import 'package:cifraclub/presentation/screens/version/middlewares/chord_middleware.dart' as _i72;
import 'package:cifraclub/presentation/screens/version/middlewares/content_middleware.dart' as _i76;
import 'package:cifraclub/presentation/screens/version/middlewares/songbook_middleware.dart' as _i183;
import 'package:cifraclub/presentation/screens/version/middlewares/version_loader_middleware.dart' as _i135;
import 'package:cifraclub/presentation/screens/version/version_reducer.dart' as _i65;
import 'package:cifraclub/presentation/widgets/color_approximator.dart' as _i4;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i79;
import 'package:firebase_core/firebase_core.dart' as _i9;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:in_app_purchase/in_app_purchase.dart' as _i23;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i28;
import 'package:local_songs/pigeon.g.dart' as _i29;
import 'package:nav/nav.dart' as _i32;
import 'package:shared_preferences/shared_preferences.dart' as _i52;

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
  final songModule = _$SongModule();
  final logModule = _$LogModule();
  final timeModule = _$TimeModule();
  final remoteConfigModule = _$RemoteConfigModule();
  final sharedPreferencesModule = _$SharedPreferencesModule();
  final searchModule = _$SearchModule();
  final deviceModule = _$DeviceModule();
  final genreModule = _$GenreModule();
  final versionModule = _$VersionModule();
  final subscriptionModule = _$SubscriptionModule();
  final deviceInfoModule = _$DeviceInfoModule();
  final homeModule = _$HomeModule();
  final permissionModule = _$PermissionModule();
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
  gh.factory<_i11.GetAllInstrumentVersions>(() => _i11.GetAllInstrumentVersions());
  gh.factory<_i12.GetAlphabeticalPrefixesList>(() => _i12.GetAlphabeticalPrefixesList());
  gh.factory<_i13.GetArtistSongsFilteredBySearch>(() => _i13.GetArtistSongsFilteredBySearch());
  gh.factory<_i14.GetAutoScrollStream>(() => _i14.GetAutoScrollStream());
  gh.factory<_i15.GetChordsRepresentation>(() => _i15.GetChordsRepresentation());
  gh.factory<_i16.GetCredential>(() => _i16.GetCredential(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i17.GetCredentialStream>(() => _i17.GetCredentialStream(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i18.GetDefaultInstruments>(() => _i18.GetDefaultInstruments());
  gh.factory<_i19.GetFilteredArtistSongs>(() => _i19.GetFilteredArtistSongs());
  gh.factory<_i20.GetInstrumentChords>(() => _i20.GetInstrumentChords());
  gh.factory<_i21.GetOperatingSystem>(() => _i21.GetOperatingSystem());
  gh.factory<_i22.GetOrderedVersions>(() => _i22.GetOrderedVersions());
  gh.singleton<_i23.InAppPurchase>(inAppPurchaseModule.getInAppPurchase());
  gh.singleton<_i24.InAppPurchaseDataSource>(inAppPurchaseModule.getInAppPurchaseDataSource(gh<_i23.InAppPurchase>()));
  gh.singleton<_i25.InAppPurchaseRepository>(
      inAppPurchaseModule.getInAppPurchaseRepository(gh<_i24.InAppPurchaseDataSource>()));
  gh.factory<_i26.InstalledAppRepository>(() => appModule.getInstalledAppRepository(gh<_i21.GetOperatingSystem>()));
  gh.factory<_i27.IsAppInstalled>(() => _i27.IsAppInstalled(installedAppRepository: gh<_i26.InstalledAppRepository>()));
  await gh.singletonAsync<_i28.Isar>(
    () => isarModule.getIsar(gh<_i7.Directory>(instanceName: 'InternalDocuments')),
    preResolve: true,
  );
  gh.singleton<_i29.LocalSongsHostApi>(songModule.getLocalSongsHostApi());
  gh.singleton<_i30.LogRepository>(logModule.getLogRepository(gh<_i10.FirebaseCrashlytics>()));
  gh.factory<_i31.Logout>(() => _i31.Logout(gh<_i3.AuthenticationRepository>()));
  gh.factoryParam<_i32.Nav, _i33.NavConstructorParams, dynamic>((
    navConstructorParams,
    _,
  ) =>
      navigatorModule.getMainScreenNavigator(
        navConstructorParams,
        gh<_i5.DeepLinkParser>(),
      ));
  gh.factory<_i34.NetworkService>(() => networkModule.getNetworkService(
        gh<_i6.Dio>(),
        gh<_i16.GetCredential>(),
      ));
  gh.factory<_i35.NtpDataSource>(() => timeModule.getNtpDataSource());
  gh.factory<_i36.OpenApp>(() => _i36.OpenApp(installedAppRepository: gh<_i26.InstalledAppRepository>()));
  gh.factory<_i37.OpenLoginPage>(() => _i37.OpenLoginPage(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i38.OpenUserProfilePage>(() => _i38.OpenUserProfilePage(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i39.OrderDataSource>(() => _i39.OrderDataSource(
        networkService: gh<_i34.NetworkService>(),
        getOperatingSystem: gh<_i21.GetOperatingSystem>(),
      ));
  gh.factory<_i40.OrderRepository>(() => _i41.OrderRepositoryImpl(dataSource: gh<_i39.OrderDataSource>()));
  gh.factory<_i42.ParseSections>(() => _i42.ParseSections());
  gh.factory<_i43.PersistedPurchaseDataSource>(() => _i43.PersistedPurchaseDataSource(isar: gh<_i28.Isar>()));
  gh.factory<_i44.PersistedPurchaseRepository>(
      () => _i45.PersistedPurchaseRepositoryImpl(gh<_i43.PersistedPurchaseDataSource>()));
  gh.factory<_i46.PostPersistentPurchaseOrder>(() => _i46.PostPersistentPurchaseOrder(gh<_i40.OrderRepository>()));
  gh.factory<_i47.PostPurchaseOrder>(() => _i47.PostPurchaseOrder(gh<_i40.OrderRepository>()));
  gh.factory<_i48.ProcessSections>(() => _i48.ProcessSections());
  gh.singleton<_i49.RemoteConfigRepository>(remoteConfigModule.getRemoteConfigRepository(gh<_i9.FirebaseApp>()));
  gh.singleton<_i50.SetScreenFromUrl>(
    _i50.SetScreenFromUrl(gh<_i5.DeepLinkParser>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i51.ShareLinkRepository>(() => appModule.getShareLinkRepository(gh<_i21.GetOperatingSystem>()));
  await gh.singletonAsync<_i52.SharedPreferences>(
    () => sharedPreferencesModule.getSharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i53.SharedPreferencesRepository>(
      () => sharedPreferencesModule.getPreferencesRepository(gh<_i52.SharedPreferences>()));
  gh.factory<_i54.ShazamRepository>(() => searchModule.getShazamRepository());
  gh.factory<_i55.TimeRepository>(() => timeModule.getTimeRepository(gh<_i35.NtpDataSource>()));
  gh.factory<_i56.UrlLauncherRepository>(() => deviceModule.getUrlLauncherRepository());
  gh.factory<_i57.UserGenreDataSource>(() => genreModule.getUserGenreDataSource(gh<_i28.Isar>()));
  gh.factory<_i58.UserSongbookDataSource>(() => songbookModule.getUserSongbookDataSource(gh<_i28.Isar>()));
  gh.factory<_i59.UserSongbookRepository>(
      () => songbookModule.getUserSongbookRepository(gh<_i58.UserSongbookDataSource>()));
  gh.factory<_i60.UserVersionDataSource>(() => versionModule.getUserVersionDataSource(gh<_i28.Isar>()));
  gh.factory<_i61.UserVersionRepository>(
      () => versionModule.getUserVersionRepository(gh<_i60.UserVersionDataSource>()));
  gh.factory<_i62.ValidateSongbookName>(() => _i62.ValidateSongbookName(gh<_i59.UserSongbookRepository>()));
  gh.factory<_i63.VerifyProStatus>(() => subscriptionModule.getVerifyProStatus());
  gh.factory<_i64.VersionDataSource>(() => _i64.VersionDataSource(gh<_i34.NetworkService>()));
  gh.factory<_i65.VersionReducer>(() => _i65.VersionReducer());
  gh.factory<_i66.VersionRepository>(() => _i67.VersionRepositoryImpl(gh<_i64.VersionDataSource>()));
  gh.factory<_i68.YouTubeDataSource>(() => _i68.YouTubeDataSource(gh<_i34.NetworkService>()));
  gh.factory<_i69.YouTubeRepository>(() => _i70.YouTubeRepositoryImpl(gh<_i68.YouTubeDataSource>()));
  gh.factoryParam<_i71.AutoScrollMiddleware, double, dynamic>((
    _screenDensity,
    _,
  ) =>
      _i71.AutoScrollMiddleware(
        _screenDensity,
        gh<_i14.GetAutoScrollStream>(),
      ));
  gh.factory<_i72.ChordMiddleware>(() => _i72.ChordMiddleware(
        gh<_i15.GetChordsRepresentation>(),
        gh<_i20.GetInstrumentChords>(),
      ));
  gh.singleton<_i73.CifraClubAPINetworkService>(networkModule.getCifraClubAPINetworkService(
    gh<_i6.Dio>(),
    gh<_i16.GetCredential>(),
  ));
  gh.singleton<_i74.ClearUserSongbooksOnLogout>(_i74.ClearUserSongbooksOnLogout(
    gh<_i59.UserSongbookRepository>(),
    gh<_i61.UserVersionRepository>(),
    gh<_i17.GetCredentialStream>(),
  ));
  gh.factory<_i75.CompletePurchase>(() => _i75.CompletePurchase(gh<_i25.InAppPurchaseRepository>()));
  gh.factory<_i76.ContentMiddleware>(() => _i76.ContentMiddleware(
        gh<_i42.ParseSections>(),
        gh<_i48.ProcessSections>(),
        gh<_i11.GetAllInstrumentVersions>(),
      ));
  gh.factory<_i77.DeepLinkHandler>(() => appModule.getHandleOrGetDeepLink(gh<_i50.SetScreenFromUrl>()));
  gh.singleton<_i78.DeviceInfoRepository>(deviceInfoModule.getDeviceInfoRepository(gh<_i21.GetOperatingSystem>()));
  gh.singleton<_i79.FirebaseAnalytics>(firebaseModule.getFirebaseAnalytics(gh<_i9.FirebaseApp>()));
  gh.factory<_i80.GenresDataSource>(() => genreModule.getGenresDataSource(gh<_i73.CifraClubAPINetworkService>()));
  gh.factory<_i81.GenresRepository>(() => genreModule.getGenresRepository(
        gh<_i80.GenresDataSource>(),
        gh<_i57.UserGenreDataSource>(),
      ));
  gh.factory<_i82.GetAllUserSongbooks>(() => _i82.GetAllUserSongbooks(gh<_i59.UserSongbookRepository>()));
  gh.factory<_i83.GetAllVersionsFromSongbook>(() => _i83.GetAllVersionsFromSongbook(gh<_i61.UserVersionRepository>()));
  gh.factory<_i84.GetArtistImagePathUrl>(() => _i84.GetArtistImagePathUrl(gh<_i49.RemoteConfigRepository>()));
  gh.factory<_i85.GetCurrentTime>(() => _i85.GetCurrentTime(gh<_i55.TimeRepository>()));
  gh.factory<_i86.GetGenres>(() => _i86.GetGenres(genresRepository: gh<_i81.GenresRepository>()));
  gh.factory<_i87.GetImagePrefixUrl>(() => _i87.GetImagePrefixUrl(gh<_i49.RemoteConfigRepository>()));
  gh.factory<_i88.GetInstrumentUrls>(() => _i88.GetInstrumentUrls(gh<_i49.RemoteConfigRepository>()));
  gh.factory<_i89.GetIsFavoriteVersionBySongId>(
      () => _i89.GetIsFavoriteVersionBySongId(gh<_i61.UserVersionRepository>()));
  gh.factory<_i90.GetIsProPreference>(() => _i90.GetIsProPreference(gh<_i53.SharedPreferencesRepository>()));
  gh.factory<_i91.GetListLimitConstants>(() => _i91.GetListLimitConstants(gh<_i49.RemoteConfigRepository>()));
  gh.factory<_i92.GetListOrderTypePreferences>(
      () => _i92.GetListOrderTypePreferences(gh<_i53.SharedPreferencesRepository>()));
  gh.factory<_i93.GetOrders>(() => _i93.GetOrders(gh<_i40.OrderRepository>()));
  gh.factory<_i94.GetPersistedPurchase>(() => _i94.GetPersistedPurchase(gh<_i44.PersistedPurchaseRepository>()));
  gh.factory<_i95.GetProducts>(() => _i95.GetProducts(gh<_i25.InAppPurchaseRepository>()));
  gh.factory<_i96.GetRemoteProStatus>(() => subscriptionModule.getRemoteProStatus(gh<_i93.GetOrders>()));
  gh.factory<_i97.GetRemoteProductsIds>(() => _i97.GetRemoteProductsIds(gh<_i49.RemoteConfigRepository>()));
  gh.factory<_i98.GetSongbookStreamById>(() => _i98.GetSongbookStreamById(gh<_i59.UserSongbookRepository>()));
  gh.factory<_i99.GetTimeBetweenInterstitials>(
      () => _i99.GetTimeBetweenInterstitials(gh<_i49.RemoteConfigRepository>()));
  gh.factory<_i100.GetTotalSongbookVersions>(() => _i100.GetTotalSongbookVersions(gh<_i61.UserVersionRepository>()));
  gh.factory<_i101.GetTotalSongbooks>(() => _i101.GetTotalSongbooks(gh<_i59.UserSongbookRepository>()));
  gh.factory<_i102.GetUserGenresAsStream>(
      () => _i102.GetUserGenresAsStream(genresRepository: gh<_i81.GenresRepository>()));
  gh.factory<_i103.GetVersionData>(() => _i103.GetVersionData(gh<_i66.VersionRepository>()));
  gh.factory<_i104.GetVersionsLimitConstants>(() => _i104.GetVersionsLimitConstants(gh<_i49.RemoteConfigRepository>()));
  gh.factory<_i105.GetVersionsStreamBySongbookId>(
      () => _i105.GetVersionsStreamBySongbookId(gh<_i61.UserVersionRepository>()));
  gh.factory<_i106.GetYouTubeVideos>(() => _i106.GetYouTubeVideos(gh<_i69.YouTubeRepository>()));
  gh.factory<_i107.HomeDataSource>(() => homeModule.getHomeDataSource(gh<_i73.CifraClubAPINetworkService>()));
  gh.factory<_i108.HomeRepository>(() => homeModule.getHomeRepository(gh<_i107.HomeDataSource>()));
  gh.factory<_i109.LocalSongRepository>(() => songModule.getLocalSongRepository(gh<_i29.LocalSongsHostApi>()));
  gh.factory<_i50.OnNewScreenSet>(() => _i50.OnNewScreenSet(gh<_i50.SetScreenFromUrl>()));
  gh.factory<_i110.OpenUrl>(() => _i110.OpenUrl(urlLauncherRepository: gh<_i56.UrlLauncherRepository>()));
  await gh.singletonAsync<_i111.OsVersion>(
    () => deviceInfoModule.getOSVersion(gh<_i78.DeviceInfoRepository>()),
    preResolve: true,
  );
  gh.factory<_i112.PermissionRepository>(() => permissionModule.getPermissionRepository(gh<_i111.OsVersion>()));
  gh.factory<_i113.PersistPurchase>(() => _i113.PersistPurchase(gh<_i44.PersistedPurchaseRepository>()));
  gh.factory<_i114.SearchDataSource>(() => searchModule.getSearchDataSource(gh<_i73.CifraClubAPINetworkService>()));
  gh.factory<_i115.SearchRepository>(() => searchModule.getSearchRepository(gh<_i114.SearchDataSource>()));
  gh.factory<_i116.SearchShazam>(() => _i116.SearchShazam(
        gh<_i54.ShazamRepository>(),
        gh<_i112.PermissionRepository>(),
        gh<_i49.RemoteConfigRepository>(),
      ));
  gh.factory<_i117.SearchSongs>(() => _i117.SearchSongs(searchRepository: gh<_i115.SearchRepository>()));
  gh.factory<_i118.SetIsProPreference>(() => _i118.SetIsProPreference(gh<_i53.SharedPreferencesRepository>()));
  gh.factory<_i119.SetListOrderTypePreferences>(
      () => _i119.SetListOrderTypePreferences(gh<_i53.SharedPreferencesRepository>()));
  gh.factory<_i120.SetUserGenres>(() => _i120.SetUserGenres(genresRepository: gh<_i81.GenresRepository>()));
  gh.factory<_i121.ShareLink>(() => _i121.ShareLink(gh<_i51.ShareLinkRepository>()));
  gh.factory<_i122.SongDataSource>(() => songModule.getSongDataSource(gh<_i73.CifraClubAPINetworkService>()));
  gh.factory<_i123.SongRepository>(() => songModule.getSongRepository(gh<_i122.SongDataSource>()));
  gh.factory<_i124.SongbookDataSource>(
      () => songbookModule.getSongbookDataSource(gh<_i73.CifraClubAPINetworkService>()));
  gh.factory<_i125.SongbookRepository>(() => songbookModule.getSongbookRepository(gh<_i124.SongbookDataSource>()));
  gh.singleton<_i126.SubscriptionRepository>(subscriptionModule.getSubscriptionRepository(
    gh<_i63.VerifyProStatus>(),
    gh<_i90.GetIsProPreference>(),
    gh<_i118.SetIsProPreference>(),
  ));
  gh.factory<_i127.UpdateProStatusWithPurchaseResult>(
      () => _i127.UpdateProStatusWithPurchaseResult(gh<_i126.SubscriptionRepository>()));
  gh.factory<_i128.UpdateSongbookData>(() => _i128.UpdateSongbookData(
        gh<_i125.SongbookRepository>(),
        gh<_i59.UserSongbookRepository>(),
      ));
  gh.factory<_i129.UpdateSongbookLastUpdated>(() => _i129.UpdateSongbookLastUpdated(gh<_i59.UserSongbookRepository>()));
  gh.factory<_i130.UpdateSongbookPreview>(() => _i130.UpdateSongbookPreview(
        gh<_i61.UserVersionRepository>(),
        gh<_i59.UserSongbookRepository>(),
      ));
  gh.factory<_i131.ValidateArtistImagePreview>(() => _i131.ValidateArtistImagePreview(
        gh<_i87.GetImagePrefixUrl>(),
        gh<_i84.GetArtistImagePathUrl>(),
      ));
  gh.factory<_i132.ValidatePurchaseDataSource>(
      () => inAppPurchaseModule.getValidatePurchaseDataSource(gh<_i73.CifraClubAPINetworkService>()));
  gh.factory<_i133.ValidatePurchaseRepository>(() => _i134.ValidatePurchaseRepositoryImpl(
        getOperatingSystem: gh<_i21.GetOperatingSystem>(),
        validatePurchaseDataSource: gh<_i132.ValidatePurchaseDataSource>(),
      ));
  gh.factory<_i135.VersionLoaderMiddleware>(() => _i135.VersionLoaderMiddleware(gh<_i103.GetVersionData>()));
  gh.factory<_i136.AnalyticsRepository>(() => analyticsModule.getAnalyticsRepository(gh<_i79.FirebaseAnalytics>()));
  gh.factory<_i137.ArtistDataSource>(() => artistModule.getGenresDataSource(gh<_i73.CifraClubAPINetworkService>()));
  gh.factory<_i138.ArtistRepository>(() => artistModule.getGenresRepository(gh<_i137.ArtistDataSource>()));
  gh.factory<_i139.ClearVersionsFromSongbook>(() => _i139.ClearVersionsFromSongbook(
        gh<_i125.SongbookRepository>(),
        gh<_i61.UserVersionRepository>(),
        gh<_i130.UpdateSongbookPreview>(),
      ));
  gh.factory<_i140.DeleteSongbook>(() => _i140.DeleteSongbook(
        gh<_i125.SongbookRepository>(),
        gh<_i59.UserSongbookRepository>(),
        gh<_i61.UserVersionRepository>(),
      ));
  gh.factory<_i141.DeleteVersionFromFavorites>(() => _i141.DeleteVersionFromFavorites(
        gh<_i61.UserVersionRepository>(),
        gh<_i125.SongbookRepository>(),
        gh<_i59.UserSongbookRepository>(),
      ));
  gh.factory<_i142.DeleteVersions>(() => _i142.DeleteVersions(
        gh<_i125.SongbookRepository>(),
        gh<_i61.UserVersionRepository>(),
        gh<_i59.UserSongbookRepository>(),
      ));
  gh.factory<_i143.DevBottomSheet>(() => bottomSheetModule.getDevBottomSheet(gh<_i86.GetGenres>()));
  gh.factory<_i144.FavoriteUnfavoriteArtist>(
      () => _i144.FavoriteUnfavoriteArtist(artistRepository: gh<_i138.ArtistRepository>()));
  gh.factory<_i145.GenreBottomSheet>(() => bottomSheetModule.getGenreBottomSheet(gh<_i86.GetGenres>()));
  gh.factory<_i146.GetAlbumDetail>(() => _i146.GetAlbumDetail(artistRepository: gh<_i138.ArtistRepository>()));
  gh.factory<_i147.GetAlbums>(() => _i147.GetAlbums(artistRepository: gh<_i138.ArtistRepository>()));
  gh.factory<_i148.GetArtistInfo>(() => _i148.GetArtistInfo(artistRepository: gh<_i138.ArtistRepository>()));
  gh.factory<_i149.GetArtistSongs>(() => _i149.GetArtistSongs(artistRepository: gh<_i138.ArtistRepository>()));
  gh.factory<_i150.GetArtistVideoLessons>(() => _i150.GetArtistVideoLessons(gh<_i138.ArtistRepository>()));
  gh.factory<_i151.GetHomeInfo>(() => _i151.GetHomeInfo(gh<_i108.HomeRepository>()));
  gh.factory<_i152.GetIsArtistFan>(() => _i152.GetIsArtistFan(artistRepository: gh<_i138.ArtistRepository>()));
  gh.factory<_i153.GetListLimit>(() => _i153.GetListLimit(gh<_i91.GetListLimitConstants>()));
  gh.factory<_i154.GetLocalSongImage>(() => _i154.GetLocalSongImage(gh<_i109.LocalSongRepository>()));
  gh.factory<_i155.GetLocalSongs>(() => _i155.GetLocalSongs(
        gh<_i109.LocalSongRepository>(),
        gh<_i112.PermissionRepository>(),
      ));
  gh.factory<_i156.GetProStatusStream>(() => _i156.GetProStatusStream(gh<_i126.SubscriptionRepository>()));
  gh.factory<_i157.GetSongbookById>(() => _i157.GetSongbookById(gh<_i125.SongbookRepository>()));
  gh.factory<_i158.GetTopArtists>(() => _i158.GetTopArtists(artistRepository: gh<_i138.ArtistRepository>()));
  gh.factory<_i159.GetTopSongs>(() => _i159.GetTopSongs(songRepository: gh<_i123.SongRepository>()));
  gh.factory<_i160.GetVersionsLimit>(() => _i160.GetVersionsLimit(gh<_i104.GetVersionsLimitConstants>()));
  gh.factory<_i161.GetVersionsLimitState>(() => _i161.GetVersionsLimitState(
        gh<_i100.GetTotalSongbookVersions>(),
        gh<_i160.GetVersionsLimit>(),
        gh<_i156.GetProStatusStream>(),
        gh<_i104.GetVersionsLimitConstants>(),
      ));
  gh.factory<_i162.InsertUserGenre>(() => _i162.InsertUserGenre(
        getUserGenresAsStream: gh<_i102.GetUserGenresAsStream>(),
        setUserGenres: gh<_i120.SetUserGenres>(),
      ));
  gh.factory<_i163.InsertUserSongbook>(() => _i163.InsertUserSongbook(
        gh<_i125.SongbookRepository>(),
        gh<_i59.UserSongbookRepository>(),
      ));
  gh.factory<_i164.InsertVersionDataToSongbook>(() => _i164.InsertVersionDataToSongbook(
        gh<_i125.SongbookRepository>(),
        gh<_i59.UserSongbookRepository>(),
        gh<_i61.UserVersionRepository>(),
        gh<_i130.UpdateSongbookPreview>(),
      ));
  gh.factory<_i165.InsertVersionToSongbook>(() => _i165.InsertVersionToSongbook(
        gh<_i103.GetVersionData>(),
        gh<_i164.InsertVersionDataToSongbook>(),
      ));
  gh.factory<_i166.ListOptionsBottomSheet>(() => bottomSheetModule.getListOptionsBottomSheet(
        gh<_i140.DeleteSongbook>(),
        gh<_i128.UpdateSongbookData>(),
        gh<_i62.ValidateSongbookName>(),
        gh<_i139.ClearVersionsFromSongbook>(),
        gh<_i121.ShareLink>(),
        gh<_i8.EditListScreenBuilder>(),
      ));
  gh.factory<_i167.ListenBottomSheet>(() => _i167.ListenBottomSheet(
        gh<_i106.GetYouTubeVideos>(),
        gh<_i154.GetLocalSongImage>(),
        gh<_i155.GetLocalSongs>(),
      ));
  gh.factoryParam<_i168.NavigatorsController, String?, dynamic>((
    deepLinkPath,
    _,
  ) =>
      navigatorModule.getNavigatorsController(
        deepLinkPath,
        gh<_i5.DeepLinkParser>(),
        gh<_i50.OnNewScreenSet>(),
      ));
  gh.factory<_i169.OpenAppOrStore>(() => _i169.OpenAppOrStore(
        openApp: gh<_i36.OpenApp>(),
        openUrl: gh<_i110.OpenUrl>(),
        isAppInstalled: gh<_i27.IsAppInstalled>(),
        getOperatingSystem: gh<_i21.GetOperatingSystem>(),
      ));
  gh.factory<_i170.PurchaseProduct>(() => _i170.PurchaseProduct(
        gh<_i25.InAppPurchaseRepository>(),
        gh<_i126.SubscriptionRepository>(),
      ));
  gh.factory<_i171.RefreshAllSongbooks>(() => _i171.RefreshAllSongbooks(
        gh<_i125.SongbookRepository>(),
        gh<_i59.UserSongbookRepository>(),
        gh<_i61.UserVersionRepository>(),
        gh<_i66.VersionRepository>(),
        gh<_i130.UpdateSongbookPreview>(),
      ));
  gh.factory<_i172.Search>(() => _i172.Search(searchRepository: gh<_i115.SearchRepository>()));
  gh.factory<_i173.SortVersionsFromSongbook>(() => _i173.SortVersionsFromSongbook(
        gh<_i125.SongbookRepository>(),
        gh<_i61.UserVersionRepository>(),
        gh<_i129.UpdateSongbookLastUpdated>(),
      ));
  gh.factory<_i174.ValidatePersistedPurchase>(() => _i174.ValidatePersistedPurchase(
        gh<_i16.GetCredential>(),
        gh<_i46.PostPersistentPurchaseOrder>(),
        gh<_i133.ValidatePurchaseRepository>(),
        gh<_i127.UpdateProStatusWithPurchaseResult>(),
        gh<_i94.GetPersistedPurchase>(),
      ));
  gh.factory<_i175.ValidatePurchase>(() => inAppPurchaseModule.getValidatePurchase(
        gh<_i16.GetCredential>(),
        gh<_i47.PostPurchaseOrder>(),
        gh<_i133.ValidatePurchaseRepository>(),
      ));
  gh.factory<_i176.ValidatePurchases>(() => _i176.ValidatePurchases(
        gh<_i175.ValidatePurchase>(),
        gh<_i75.CompletePurchase>(),
        gh<_i113.PersistPurchase>(),
      ));
  gh.singleton<_i177.WatchForPurchases>(_i177.WatchForPurchases(
    gh<_i25.InAppPurchaseRepository>(),
    gh<_i176.ValidatePurchases>(),
    gh<_i127.UpdateProStatusWithPurchaseResult>(),
  ));
  gh.singleton<_i178.WatchForSubscriptions>(_i178.WatchForSubscriptions(
    gh<_i17.GetCredentialStream>(),
    gh<_i126.SubscriptionRepository>(),
    gh<_i96.GetRemoteProStatus>(),
    gh<_i174.ValidatePersistedPurchase>(),
  ));
  gh.factory<_i179.GetListLimitState>(() => _i179.GetListLimitState(
        gh<_i101.GetTotalSongbooks>(),
        gh<_i156.GetProStatusStream>(),
        gh<_i153.GetListLimit>(),
        gh<_i91.GetListLimitConstants>(),
      ));
  gh.factory<_i180.GetVersionLimitStateByCount>(() => _i180.GetVersionLimitStateByCount(
        gh<_i160.GetVersionsLimit>(),
        gh<_i104.GetVersionsLimitConstants>(),
      ));
  gh.factory<_i181.InsertVersionDataToRecents>(() => _i181.InsertVersionDataToRecents(
        gh<_i164.InsertVersionDataToSongbook>(),
        gh<_i61.UserVersionRepository>(),
      ));
  gh.factory<_i182.SaveVersionToListBottomSheet>(() => bottomSheetModule.getSaveVersionToListBottomSheet(
        gh<_i82.GetAllUserSongbooks>(),
        gh<_i163.InsertUserSongbook>(),
        gh<_i179.GetListLimitState>(),
        gh<_i161.GetVersionsLimitState>(),
        gh<_i165.InsertVersionToSongbook>(),
        gh<_i62.ValidateSongbookName>(),
        gh<_i153.GetListLimit>(),
        gh<_i160.GetVersionsLimit>(),
        gh<_i156.GetProStatusStream>(),
        gh<_i131.ValidateArtistImagePreview>(),
      ));
  gh.factory<_i183.SongbookMiddleware>(() => _i183.SongbookMiddleware(gh<_i181.InsertVersionDataToRecents>()));
  gh.factory<_i184.VersionOptionsBottomSheet>(() => bottomSheetModule.getVersionOptionsBottomSheet(
        gh<_i182.SaveVersionToListBottomSheet>(),
        gh<_i165.InsertVersionToSongbook>(),
        gh<_i89.GetIsFavoriteVersionBySongId>(),
        gh<_i141.DeleteVersionFromFavorites>(),
        gh<_i17.GetCredentialStream>(),
        gh<_i37.OpenLoginPage>(),
        gh<_i121.ShareLink>(),
      ));
  return getIt;
}

class _$PathModule extends _i185.PathModule {}

class _$SubscriptionModule extends _i186.SubscriptionModule {}

class _$PermissionModule extends _i187.PermissionModule {}

class _$AuthenticationModule extends _i188.AuthenticationModule {}

class _$LogModule extends _i189.LogModule {}

class _$SearchModule extends _i190.SearchModule {}

class _$FirebaseModule extends _i191.FirebaseModule {}

class _$InAppPurchaseModule extends _i192.InAppPurchaseModule {}

class _$TimeModule extends _i193.TimeModule {}

class _$HomeModule extends _i194.HomeModule {}

class _$ArtistModule extends _i195.ArtistModule {}

class _$SongModule extends _i196.SongModule {}

class _$SharedPreferencesModule extends _i197.SharedPreferencesModule {}

class _$AnalyticsModule extends _i198.AnalyticsModule {}

class _$VersionModule extends _i199.VersionModule {}

class _$NavigatorModule extends _i33.NavigatorModule {}

class _$SongbookModule extends _i200.SongbookModule {}

class _$GenreModule extends _i201.GenreModule {}

class _$AppModule extends _i202.AppModule {}

class _$RemoteConfigModule extends _i203.RemoteConfigModule {}

class _$NetworkModule extends _i204.NetworkModule {}

class _$BottomSheetModule extends _i205.BottomSheetModule {}

class _$ControllersModule extends _i206.ControllersModule {}

class _$DeviceModule extends _i207.DeviceModule {}

class _$IsarModule extends _i208.IsarModule {}

class _$DeviceInfoModule extends _i209.DeviceInfoModule {}
