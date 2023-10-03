import 'dart:async';
import 'dart:ui';

import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionOptionsBottomSheetBloc extends Cubit<VersionOptionsBottomSheetState> {
  final InsertVersionToSongbook _insertVersionToSongbook;
  final GetIsFavoriteVersionBySongId _getIsFavoriteVersionBySongId;
  final DeleteVersionFromFavorites _deleteVersionFromFavorites;
  final GetCredentialStream _getCredentialStream;
  final OpenLoginPage _openLoginView;
  final ShareLink _shareLink;
  final int songId;

  VersionOptionsBottomSheetBloc(this._insertVersionToSongbook, this._getIsFavoriteVersionBySongId,
      this._deleteVersionFromFavorites, this._getCredentialStream, this._openLoginView, this._shareLink, this.songId)
      : super(const VersionOptionsBottomSheetState(isLoggedIn: false));

  StreamSubscription<UserCredential>? _userSubscription;

  void init() {
    _userSubscription = _getCredentialStream().listen(_updateCredential);
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }

  Future<VersionOptionsResult> onFavorite(String artistUrl, String songUrl) async {
    bool isFavorite = state.isFavorite;
    if (isFavorite) {
      final result = await _deleteVersionFromFavorites(songId: songId);
      return result.isSuccess ? UnFavoriteVersionSuccess() : UnFavoriteVersionError();
    } else {
      final result = await _insertVersionToSongbook(
          artistUrl: artistUrl, songUrl: songUrl, songbookId: ListType.favorites.localId);
      return result.isSuccess ? FavoriteVersionSuccess() : FavoriteVersionError();
    }
  }

  Future<void> _updateCredential(UserCredential? userCredential) async {
    bool isFavorite = false;
    if (userCredential?.user != null) {
      isFavorite = await _getIsFavoriteVersionBySongId(songId).first;
    }
    emit(state.copyWith(isLoggedIn: userCredential?.isUserLoggedIn ?? false, isFavorite: isFavorite));
  }

  void openLoginPage() => _openLoginView();

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
