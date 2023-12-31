// coverage:ignore-file
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_recents.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BottomSheetModule {
  DevBottomSheet getDevBottomSheet(GetGenres getGenres) => DevBottomSheet(getGenres);

  GenreBottomSheet getGenreBottomSheet(GetGenres getGenres) => GenreBottomSheet(getGenres);

  ListOptionsBottomSheet getListOptionsBottomSheet(
    DeleteSongbook deleteSongbook,
    UpdateSongbookData updateSongbookData,
    ValidateSongbookName validateSongbookName,
    ClearVersionsFromSongbook clearSongsFromSongbook,
    ShareLink shareLink,
    EditListScreenBuilder editListScreenBuilder,
    ClearRecents clearRecents,
  ) =>
      ListOptionsBottomSheet(
        clearSongsFromSongbook,
        deleteSongbook,
        shareLink,
        updateSongbookData,
        validateSongbookName,
        editListScreenBuilder,
        clearRecents,
      );

  SaveVersionToListBottomSheet getSaveVersionToListBottomSheet(
    final GetAllUserSongbooks getAllUserSongbooks,
    final InsertUserSongbook insertUserSongbook,
    final GetListLimitState getListLimitState,
    final GetVersionsLimitState getVersionsLimitState,
    final InsertVersionToSongbook insertVersionToSongbook,
    final ValidateSongbookName validateSongbookName,
    final GetListLimit getListLimit,
    final GetVersionsLimit getVersionsLimit,
    final GetProStatusStream getProStatusStream,
    final ValidateArtistImagePreview validateArtistImagePreview,
    final GetListLimitConstants getListLimitConstants,
  ) =>
      SaveVersionToListBottomSheet(
        getAllUserSongbooks,
        insertUserSongbook,
        getListLimitState,
        getVersionsLimitState,
        insertVersionToSongbook,
        validateSongbookName,
        getListLimit,
        getVersionsLimit,
        getProStatusStream,
        validateArtistImagePreview,
        getListLimitConstants,
      );

  VersionOptionsBottomSheet getVersionOptionsBottomSheet(
    final SaveVersionToListBottomSheet saveToListBottomSheet,
    final GetIsFavoriteVersionBySongId getIsFavoriteVersionBySongId,
    final GetCredentialStream getCredentialStream,
    final OpenLoginPage openLoginView,
    final ShareLink shareLink,
    final OpenAppOrStore openAppOrStore,
    final IsAppInstalled isAppInstalled,
    final FavoriteUnfavoriteVersion favoriteUnfavoriteVersion,
  ) =>
      VersionOptionsBottomSheet(
        saveToListBottomSheet,
        getIsFavoriteVersionBySongId,
        getCredentialStream,
        openLoginView,
        shareLink,
        openAppOrStore,
        isAppInstalled,
        favoriteUnfavoriteVersion,
      );
}
