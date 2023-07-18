import 'dart:async';

import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/artist/use_cases/favorite_unfavorite_artist.dart';
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart';
import 'package:cifraclub/domain/artist/use_cases/get_is_artist_fan.dart';
import 'package:cifraclub/domain/artist/use_cases/get_filtered_artist_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/artist/artist_event.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

class ArtistBloc extends Cubit<ArtistState> with SubscriptionHolder {
  final String artistUrl;
  final GetArtistInfo _getArtistInfo;
  final GetArtistSongs _getArtistSongs;
  final GetAlbums _getAlbums;
  final GetDefaultInstruments _getDefaultInstruments;
  final GetFilteredArtistSongs _getFilteredArtistSongs;
  final GetCredentialStream _getCredentialStream;
  final GetIsArtistFan _getIsArtistFan;
  final FavoriteUnfavoriteArtist _favoriteArtist;
  final OpenLoginPage _openLoginView;

  ArtistBloc(
    this.artistUrl,
    this._getArtistSongs,
    this._getArtistInfo,
    this._getAlbums,
    this._getDefaultInstruments,
    this._getFilteredArtistSongs,
    this._getIsArtistFan,
    this._favoriteArtist,
    this._getCredentialStream,
    this._openLoginView,
  ) : super(const ArtistState());

  List<ArtistSong> songs = [];

  final _eventController = PublishSubject<ArtistEvent>();
  final _favoriteController = BehaviorSubject<void>();

  Stream<ArtistEvent> get artistEventStream => _eventController.stream;

  void onFavorite() => _favoriteController.add(null);

  Future<void> init() async {
    fetchArtistInfos();
    initSubscriptions();
  }

  Future<void> fetchArtistInfos() async {
    emit(state.copyWith(isLoading: true));

    final results = await Future.wait([
      _getArtistInfo(artistUrl),
      _getArtistSongs(artistUrl: artistUrl, filter: ArtistSongFilter.cifra),
      _getAlbums(artistUrl)
    ]);

    ArtistInfo? artistInfo;
    List<Album>? albums;
    List<Instrument> filters = [];

    final artistInfoResult = results[0] as Result<ArtistInfo, RequestError>;
    final songsResult = results[1] as Result<List<ArtistSong>, RequestError>;
    final albumsResult = results[2] as Result<List<Album>, RequestError>;

    if (artistInfoResult.isSuccess && songsResult.isSuccess && songsResult.get()!.isNotEmpty) {
      artistInfo = artistInfoResult.get();
      songs = songsResult.get() ?? const [];
      albums = albumsResult.get() ?? const [];
      filters = await _getDefaultInstruments(songs);

      emit(
        state.copyWith(
          albums: albums,
          artistInfo: artistInfo,
          songs: songs,
          instruments: filters,
          isLoading: false,
          error: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          error: artistInfoResult.getError() ?? songsResult.getError(),
        ),
      );
    }
  }

  void initSubscriptions() {
    _getCredentialStream().listen(_updateCredential).addTo(subscriptions);

    _favoriteController
        .debounceTime(
      const Duration(milliseconds: 300),
    )
        .listen((_) {
      _onFavorite();
    }).addTo(subscriptions);
  }

  Future<void> _onFavorite() async {
    bool isFavorite = state.isFavorite;
    final isFavoriteResult = await _favoriteArtist(artistUrl: artistUrl, isFavorite: !isFavorite);
    isFavoriteResult.when(success: (_) {
      emit(state.copyWith(isFavorite: !isFavorite));
    }, failure: (error) {
      _eventController.add(FavoriteError(error: error));
    });
  }

  Future<void> _updateCredential(UserCredential? userCredential) async {
    bool isFavorite = false;
    if (userCredential?.user != null) {
      isFavorite = (await _getIsArtistFan(artistUrl: artistUrl, userId: userCredential!.user!.id!)).get() ?? false;
    }
    emit(state.copyWith(
      isFavorite: isFavorite,
      user: userCredential?.user,
    ));
  }

  void onInstrumentSelected(Instrument? instrument) async {
    if (instrument != state.selectedInstrument) {
      emit(state.copyWith(selectedInstrument: instrument));
      await getFilteredSongs(instrument);
    }
  }

  Future<void> getFilteredSongs(Instrument? instrument) async {
    final filteredSongs = await _getFilteredArtistSongs(songs, instrument);
    emit(state.copyWith(
      songs: filteredSongs,
      isLoading: false,
    ));
  }

  void openLoginPage() => _openLoginView();

  @override
  Future<void> close() {
    _favoriteController.close();
    _eventController.close();
    disposeAll();
    return super.close();
  }
}
