import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListsBloc extends Cubit<ListsState> {
  ListsBloc(this._getCredentialStream, this._logout, this._openLoginPage, this._openUserProfilePage)
      : super(ListsState());
  final GetCredentialStream _getCredentialStream;
  final Logout _logout;
  final OpenLoginPage _openLoginPage;
  final OpenUserProfilePage _openUserProfilePage;

  void init() {
    _getCredentialStream().listen(_updateCredential);
  }

  void _updateCredential(UserCredential? userCredential) {
    emit(state.copyWith(user: userCredential?.user));
  }

  void getLists() {
    final userlists = List.generate(10, (index) => "UserList $index");
    final specialLists = List.generate(4, (index) => "SpecialList $index");

    emit(
      state.copyWith(
        userLists: userlists,
        specialLists: specialLists,
      ),
    );
  }

  // coverage:ignore-start
  void syncList() {
    emit(state.copyWith(isSyncing: !state.isSyncing));
  }
  // coverage:ignore-end

  Future<void> logout() => _logout();

  void openLoginPage() => _openLoginPage();

  void openUserProfilePage() => _openUserProfilePage();
}
