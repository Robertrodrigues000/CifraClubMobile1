import 'dart:async';

import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongbookBloc extends Cubit<SongbookState> {
  final GetCredentialStream _getCredentialStream;
  final OpenLoginPage _openLoginView;

  SongbookBloc(this._getCredentialStream, this._openLoginView) : super(const SongbookState());

  StreamSubscription<UserCredential>? _userSubscription;

  void init() {
    _userSubscription = _getCredentialStream().listen(_updateCredential);
  }

  void _updateCredential(UserCredential? userCredential) {
    emit(state.copyWith(userCredential: userCredential, selectedSongbookId: ListType.recents.localId));
  }

  void onSelectSongbook(int? songbookId) {
    emit(state.copyWith(selectedSongbookId: songbookId));
  }

  void openLoginPage() => _openLoginView();

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
