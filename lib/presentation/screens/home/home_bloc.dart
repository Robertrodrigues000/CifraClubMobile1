import 'dart:async';

import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart';
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class HomeBloc extends Cubit<HomeState> with GenresCapsuleMixin {
  final GetCredentialStream _getCredentialsStream;
  final OpenLoginPage _openLoginView;
  final OpenUserProfilePage _openUserProfilePage;
  final Logout _logout;
  final GetHomeInfo _getHomeInfo;
  StreamSubscription? _credentialStreamSubscription;
  CancelableOperation<Result<HomeInfo, RequestError>>? currentRequest;
  final GetProStatusStream _getProStatusStream;

  @override
  final GetUserGenresAsStream getUserGenresAsStream;

  @override
  final InsertUserGenre insertUserGenre;

  HomeBloc(
    this.getUserGenresAsStream,
    this.insertUserGenre,
    this._getCredentialsStream,
    this._openLoginView,
    this._openUserProfilePage,
    this._logout,
    this._getHomeInfo,
    this._getProStatusStream,
  ) : super(const HomeState(user: null, isPro: false));

  StreamSubscription? _getProStatusSubscription;

  void init() {
    _credentialStreamSubscription = _getCredentialsStream().listen(_updateStateWithNewCredential);
    _getProStatusSubscription = _getProStatusStream().listen(_updateProStatus);
    initGenres();

    requestHomeData(genreUrl: state.selectedGenre);
  }

  @override
  void emitGenres(List<Genre> genres) async {
    emit(state.copyWith(genres: genres));
    if (state.selectedGenre != null && genres.every((element) => element.url != state.selectedGenre)) {
      emit(state.copyWith(selectedGenre: null));
      await requestHomeData();
    }
  }

  @override
  void newGenre(Genre genre) async {
    emit(state.copyWith(selectedGenre: genre.url));
    await requestHomeData(genreUrl: genre.url);
  }

  void onGenreSelected(String? genreUrl) async {
    if (genreUrl != state.selectedGenre) {
      emit(state.copyWith(selectedGenre: genreUrl));
      await requestHomeData(genreUrl: genreUrl);
    }
  }

  void _updateStateWithNewCredential(UserCredential credential) {
    if (credential.isUserLoggedIn) {
      emit(state.copyWith(user: credential.user));
    } else {
      emit(state.copyWith(user: null));
    }
  }

  void _updateProStatus(bool isPro) {
    emit(state.copyWith(isPro: isPro));
  }

  Future<void> requestHomeData({String? genreUrl = ""}) async {
    emit(state.copyWith(isLoading: true, error: null));
    currentRequest?.cancel();
    currentRequest = _getHomeInfo(genreUrl);

    var result = await currentRequest!.valueOrCancellation(Err(RequestCancelled()));

    result?.when(
      success: (homeInfo) => emit(
        state.copyWith(
          highlights: homeInfo.highlights,
          topArtists: homeInfo.artists,
          topSongs: homeInfo.songs,
          videoLessons: homeInfo.videoLessons,
          blog: homeInfo.news?.take(4).toList(),
          isLoading: false,
        ),
      ),
      failure: (error) {
        if (error is! RequestCancelled) {
          emit(
            state.copyWith(
              error: error,
              isLoading: false,
            ),
          );
        }
      },
    );
  }

  void openLoginPage() => _openLoginView();

  void openProfilePage() => _openUserProfilePage();

  void logoutUser() => _logout();

  @override
  Future<void> close() {
    _credentialStreamSubscription?.cancel();
    _getProStatusSubscription?.cancel();
    return super.close();
  }
}
