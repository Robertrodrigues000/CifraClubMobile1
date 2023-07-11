import 'dart:async';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
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
  final ValidateSongbookName _validateSongbookName;

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
    this._validateSongbookName,
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

  Future<void> logout() => _logout();

  void openLoginPage() => _openLoginPage();

  void openUserProfilePage() => _openUserProfilePage();

  Future<bool> isValidSongbookName(String name) async {
    final status = await _validateSongbookName(name);

    switch (status) {
      case SongbookNameValidation.existingName:
        return false;
      case SongbookNameValidation.validInput:
        return true;
    }
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
