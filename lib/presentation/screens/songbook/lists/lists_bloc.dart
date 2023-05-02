import 'dart:async';

import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListsBloc extends Cubit<ListsState> {
  final GetCredentialStream _getCredentialStream;
  final Logout _logout;
  final OpenLoginPage _openLoginPage;
  final OpenUserProfilePage _openUserProfilePage;
  final InsertUserSongbook _insertUserSongbook;
  final RefreshAllSongbooks _refreshAllSongbooks;
  final GetAllUserSongbooks _getAllUserSongbooks;
  StreamSubscription<List<Songbook>>? _songbooksSubscription;
  StreamSubscription<UserCredential>? _userSubscription;

  ListsBloc(this._insertUserSongbook, this._refreshAllSongbooks, this._getAllUserSongbooks, this._getCredentialStream,
      this._logout, this._openLoginPage, this._openUserProfilePage)
      : super(const ListsState());

  void init() {
    _userSubscription = _getCredentialStream().listen(_updateCredential);
    _songbooksSubscription = _getAllUserSongbooks().listen(_onSongbooksUpdated);

    // TODO: Melhorar lógica (fazer automaticamente baseado no horario do ultimo refresh)
    _refreshAllSongbooks();
  }

  @override
  Future<void> close() {
    _songbooksSubscription?.cancel();
    _userSubscription?.cancel();
    return super.close();
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

  Future<void> logout() => _logout();

  void openLoginPage() => _openLoginPage();

  void openUserProfilePage() => _openUserProfilePage();
}
