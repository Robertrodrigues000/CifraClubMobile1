import 'dart:async';

import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/more/models/app_item.dart';
import 'package:cifraclub/presentation/screens/more/more_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreBloc extends Cubit<MoreState> {
  final GetCredentialStream _getCredentialStream;
  final OpenAppOrStore _openAppOrStore;
  final IsAppInstalled _isAppInstalled;
  final Logout _logout;
  final OpenUrl _openUrl;
  final OpenLoginPage _openLoginPage;
  final OpenUserProfilePage _openUserProfilePage;

  MoreBloc(
    this._getCredentialStream,
    this._openAppOrStore,
    this._logout,
    this._isAppInstalled,
    this._openUrl,
    this._openLoginPage,
    this._openUserProfilePage,
  ) : super(const MoreState());

  StreamSubscription<UserCredential>? userSubscription;

  Future<void> init(List<AppItem> appList) async {
    userSubscription = _getCredentialStream().listen(_updateCredential);

    List<AppItem> installedApps = [];

    for (var element in appList) {
      if (await _isAppInstalled(element.app)) {
        installedApps.add(element);
      }
    }

    emit(state.copyWith(installedApps: installedApps));
  }

  void _updateCredential(UserCredential? userCredential) {
    emit(state.copyWith(user: userCredential?.user));
  }

  Future<void> logout() => _logout();

  Future<void> openAppOrStore(App app) => _openAppOrStore(app);

  Future<void> openUrl(String url) => _openUrl(url);

  void openLoginPage() => _openLoginPage();

  void openUserProfilePage() => _openUserProfilePage();

  @override
  Future<void> close() {
    userSubscription?.cancel();
    return super.close();
  }
}
