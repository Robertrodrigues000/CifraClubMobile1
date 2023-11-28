import 'dart:async';
import 'dart:ui';

import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_state.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionOptionsBottomSheetBloc extends Cubit<VersionOptionsBottomSheetState> {
  final GetIsFavoriteVersionBySongId _getIsFavoriteVersionBySongId;
  final GetCredentialStream _getCredentialStream;
  final OpenLoginPage _openLoginView;
  final ShareLink _shareLink;
  final OpenAppOrStore _openAppOrStore;
  final IsAppInstalled _isAppInstalled;
  final FavoriteUnfavoriteVersion _favoriteUnfavoriteVersion;
  final int songId;
  final VersionData? versionData;
  final bool isPro;

  VersionOptionsBottomSheetBloc(
    this._getIsFavoriteVersionBySongId,
    this._getCredentialStream,
    this._openLoginView,
    this._shareLink,
    this._openAppOrStore,
    this._isAppInstalled,
    this._favoriteUnfavoriteVersion,
    this.songId,
    this.versionData,
    this.isPro,
  ) : super(const VersionOptionsBottomSheetState(isLoggedIn: false));

  StreamSubscription<UserCredential>? _userSubscription;

  Future<void> init() async {
    _userSubscription = _getCredentialStream().listen(_updateCredential);
    if (versionData != null) {
      final isTunerInstalled = await _isAppInstalled(App.afinador);
      emit(
        state.copyWith(
            originalKey: versionData?.key,
            selectedKey: versionData?.stdKey,
            musicalScale: MusicalScale.getMusicalScaleByKey(versionData?.stdKey),
            selectedVersion: versionData?.versionName,
            instrument: versionData?.instrument,
            tuning: versionData?.tuning?.value,
            capo: "Sem capo",
            isPro: isPro,
            isTunerInstalled: isTunerInstalled),
      );
    }
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }

  Future<VersionOptionsResult> onFavorite(String artistUrl, String songUrl) async {
    bool isFavorite = state.isFavorite;
    return _favoriteUnfavoriteVersion(artistUrl: artistUrl, songUrl: songUrl, songId: songId, isFavorite: isFavorite);
  }

  Future<void> _updateCredential(UserCredential? userCredential) async {
    bool isFavorite = false;
    if (userCredential?.user != null) {
      isFavorite = await _getIsFavoriteVersionBySongId(songId).first;
    }
    emit(state.copyWith(isLoggedIn: userCredential?.isUserLoggedIn ?? false, isFavorite: isFavorite));
  }

  void toggleBeatVisibility() {
    emit(state.copyWith(isBeatVisible: !state.isBeatVisible));
  }

  void toggleTabsVisibility() {
    emit(state.copyWith(isTabVisible: !state.isTabVisible));
  }

  void toggleLeftHanded() {
    emit(state.copyWith(isLeftHanded: !state.isLeftHanded));
  }

  void openLoginPage() => _openLoginView();

  Future<void> openAppOrStore() => _openAppOrStore(App.afinador);

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
