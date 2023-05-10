import 'dart:async';

import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
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
  final GetCredentialStream _getCredentialStream;
  final Logout _logout;
  final OpenLoginPage _openLoginPage;
  final OpenUserProfilePage _openUserProfilePage;
  final InsertUserSongbook _insertUserSongbook;
  final RefreshAllSongbooks _refreshAllSongbooks;
  final GetAllUserSongbooks _getAllUserSongbooks;
  final DeleteSongbook _deleteSongbook;
  final UpdateSongbookData _updateSongbookData;
  StreamSubscription<List<Songbook>>? _songbooksSubscription;
  StreamSubscription<UserCredential>? _userSubscription;

  ListsBloc(
    this._insertUserSongbook,
    this._refreshAllSongbooks,
    this._getAllUserSongbooks,
    this._getCredentialStream,
    this._logout,
    this._openLoginPage,
    this._openUserProfilePage,
    this._getListLimitState,
    this._getTotalSongbooks,
    this._deleteSongbook,
    this._updateSongbookData,
  ) : super(const ListsState());

  StreamSubscription? _getCredentialStreamSubscription;
  StreamSubscription<ListLimitState>? _listLimitStateSubscription;
  StreamSubscription<int>? _totalSongbooksSubscription;

  void init() {
    _getCredentialStreamSubscription = _getCredentialStream().listen(_updateCredential);
    _userSubscription = _getCredentialStream().listen(_updateCredential);
    _songbooksSubscription = _getAllUserSongbooks().listen(_onSongbooksUpdated);

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

  void createNewSongbook(String name) => _insertUserSongbook(name: name);

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
      // ignore: avoid_print
      print(listState);
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

  Future<void> updateSongbookData({required Songbook songbook, String? songbookName, bool? isPublic}) async {
    final result = await _updateSongbookData(songbook: songbook, name: songbookName, isPublic: isPublic);

    result.onFailure(
      (error) async {
        emit(state.copyWith(isError: true));
        await Future.delayed(const Duration(milliseconds: 100));
        emit(state.copyWith(isError: false));
      },
    );
  }

  @override
  Future<void> close() {
    _songbooksSubscription?.cancel();
    _userSubscription?.cancel();
    _listLimitStateSubscription?.cancel();
    _totalSongbooksSubscription?.cancel();
    _getCredentialStreamSubscription?.cancel();
    return super.close();
  }
}
