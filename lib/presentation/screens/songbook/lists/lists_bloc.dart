import 'dart:async';
import 'dart:ui';

import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_all_cifras.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ListsBloc extends Cubit<ListsState> {
  final GetListLimitState _getListLimitState;
  final GetTotalSongbooks _getTotalSongbooks;
  final GetListLimit _getListLimit;
  final InsertUserSongbook _insertUserSongbook;
  final GetCredentialStream _getCredentialStream;
  final Logout _logout;
  final OpenLoginPage _openLoginPage;
  final OpenUserProfilePage _openUserProfilePage;
  final RefreshAllSongbooks _refreshAllSongbooks;
  final GetAllUserSongbooks _getAllUserSongbooks;
  final GetProStatusStream _getProStatusStream;
  final DeleteSongbook _deleteSongbook;
  final UpdateSongbookData _updateSongbookData;
  final ValidateSongbookName _validateSongbookName;
  final DeleteAllCifras _deleteAllCifras;
  final ShareLink _shareLink;

  ListsBloc(
    this._getListLimitState,
    this._getTotalSongbooks,
    this._insertUserSongbook,
    this._getListLimit,
    this._getCredentialStream,
    this._logout,
    this._openLoginPage,
    this._openUserProfilePage,
    this._refreshAllSongbooks,
    this._getAllUserSongbooks,
    this._getProStatusStream,
    this._deleteSongbook,
    this._updateSongbookData,
    this._validateSongbookName,
    this._deleteAllCifras,
    this._shareLink,
  ) : super(const ListsState());

  StreamSubscription<List<Songbook>>? _songbooksSubscription;
  StreamSubscription<UserCredential>? _userSubscription;
  StreamSubscription? _getCredentialStreamSubscription;
  StreamSubscription<ListLimitState>? _listLimitStateSubscription;
  StreamSubscription<int>? _totalSongbooksSubscription;
  StreamSubscription? _getProStatusSubscription;

  void init() {
    _getCredentialStreamSubscription = _getCredentialStream().listen(_updateCredential);
    _userSubscription = _getCredentialStream().listen(_updateCredential);
    _songbooksSubscription = _getAllUserSongbooks().listen(_onSongbooksUpdated);
    _getProStatusSubscription = _getProStatusStream().listen(_updateProStatus);
    // TODO: Melhorar lógica (fazer automaticamente baseado no horario do ultimo refresh)
    _refreshAllSongbooks();
  }

  void _onSongbooksUpdated(List<Songbook> songbooks) {
    emit(
      state.copyWith(
        userLists: songbooks.where((element) => element.type == ListType.user).toList(growable: false),
        specialLists: songbooks.where((element) => element.type != ListType.user).toList(growable: false),
      ),
    );
  }

  void _updateCredential(UserCredential? userCredential) {
    emit(state.copyWith(user: userCredential?.user));
  }

  Future<void> _updateProStatus(bool isPro) async {
    final listLimit = _getListLimit(isPro);
    emit(state.copyWith(listLimit: listLimit, isPro: isPro));
  }

  Future<Result<Songbook, RequestError>> createNewSongbook(String name) => _insertUserSongbook(name: name);

  Future<void> syncList() async {
    if (state.isSyncing) {
      return;
    }
    emit(state.copyWith(isSyncing: true));
    await _refreshAllSongbooks();
    emit(state.copyWith(isSyncing: false));
  }

  Future<void> initListLimitStreams() async {
    _listLimitStateSubscription = _getListLimitState().listen((listState) {
      emit(state.copyWith(listState: listState));
    });

    _totalSongbooksSubscription = _getTotalSongbooks().listen((total) {
      emit(state.copyWith(listCount: total));
    });
  }

  Future<void> deleteSongbook(int? songbookId) async {
    final result = await _deleteSongbook(songbookId!);

    result.when(
      // ignore: avoid_print
      success: (_) => print("DeleteSongbookSucess"),
      // ignore: avoid_print
      failure: (e) => print("Error delete songbook $e"),
    );
  }

  Future<void> logout() => _logout();

  void openLoginPage() => _openLoginPage();

  void openUserProfilePage() => _openUserProfilePage();

  Future<Result<void, RequestError>> updateSongbookData({
    required Songbook songbook,
    String? songbookName,
    bool? isPublic,
  }) async {
    return _updateSongbookData(songbook: songbook, name: songbookName, isPublic: isPublic);
  }

  Future<bool> isValidSongbookName(String name) async {
    final status = await _validateSongbookName(name);

    switch (status) {
      case SongbookNameValidation.existingName:
        return false;
      case SongbookNameValidation.validInput:
        return true;
    }
  }

  Future<void> clearList(int? songbookId) async {
    if (songbookId == null) {
      logger?.sendNonFatalCrash(exception: "Clear songbook with null Id"); // coverage:ignore-line
    } else {
      await _deleteAllCifras(songbookId);
    }
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }

  @override
  Future<void> close() {
    _songbooksSubscription?.cancel();
    _userSubscription?.cancel();
    _listLimitStateSubscription?.cancel();
    _totalSongbooksSubscription?.cancel();
    _getCredentialStreamSubscription?.cancel();
    _getProStatusSubscription?.cancel();
    return super.close();
  }
}
