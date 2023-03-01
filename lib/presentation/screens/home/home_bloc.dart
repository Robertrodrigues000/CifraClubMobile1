// coverage:ignore-file
import 'dart:async';

import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class HomeBloc extends Cubit<HomeState> {
  final GetCredentialStream _getCredentialsStream;
  final OpenLoginPage _openLoginView;
  final OpenUserProfilePage _openUserProfilePage;
  final Logout _logout;
  final GetUserGenresAsStream _getUserGenresAsStream;
  final GetHomeInfo _getHomeInfo;
  StreamSubscription? _credentialStreamSubscription;

  HomeBloc(
    this._getUserGenresAsStream,
    this._getCredentialsStream,
    this._openLoginView,
    this._openUserProfilePage,
    this._logout,
    this._getHomeInfo,
  ) : super(HomeLoadingState(user: null, isPro: false));
  List<int> highlights = List.generate(10, (index) => index + 1);
  List<int> topArtists = List.generate(4, (index) => index + 1);
  List<int> topCifras = List.generate(10, (index) => index + 1);
  List<int> videoLessons = List.generate(4, (index) => index + 1);
  List<int> blogPosts = List.generate(5, (index) => index + 1);
  List<String> genres = [];

  void onGenreSelected(String genre) async {
    emit(
      HomeLoadedState(
        highlights: highlights,
        topCifras: topCifras,
        topArtists: topArtists,
        videoLessons: videoLessons,
        blog: blogPosts,
        selectedGenre: genre,
        genres: genres,
        user: state.user,
        isPro: state.isPro,
      ),
    );
  }

  void getUserInfo() async {
    final credentialStream = _getCredentialsStream();
    _subscribeToCredentialsStream(credentialStream);
  }

  void _subscribeToCredentialsStream(Stream<UserCredential> credentialsStream) {
    _credentialStreamSubscription = credentialsStream.listen(_updateStateWithNewCredential);
  }

  void _updateStateWithNewCredential(UserCredential credential) {
    if (credential.isUserLoggedIn) {
      emit(state.copyWith(credential.user, true));
    } else {
      emit(state.copyWith(null, false));
    }
  }

  Future<void> requestHomeData() async {
    emit(HomeLoadingState(user: state.user, isPro: state.isPro));
    await Future.delayed(const Duration(seconds: 2));
    var homeinfo = await _getHomeInfo("sertanejo");

    homeinfo.when(
      success: (value) {
        print(value);
      },
      failure: (error) {},
    );

    var stream = _getUserGenresAsStream();
    var firstValueOfStream = await stream.first;
    var genreNames = firstValueOfStream.map((e) => e.name).toList();
    genres = genreNames;

    emit(
      HomeLoadedState(
        user: state.user,
        highlights: highlights,
        topCifras: topCifras,
        topArtists: topArtists,
        videoLessons: videoLessons,
        blog: blogPosts,
        selectedGenre: genreNames.first,
        genres: genreNames,
        isPro: state.isPro,
      ),
    );
  }

  void openLoginPage() => _openLoginView();

  void openProfilePage() => _openUserProfilePage();

  void logoutUser() => _logout();

  @override
  Future<void> close() {
    _credentialStreamSubscription?.cancel();
    return super.close();
  }
}
