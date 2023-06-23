import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart';
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ArtistBloc extends Cubit<ArtistState> {
  final String artistUrl;
  final GetArtistInfo _getArtistInfo;
  final GetArtistSongs _getArtistSongs;
  final GetAlbums _getAlbums;
  ArtistBloc(
    this.artistUrl,
    this._getArtistSongs,
    this._getArtistInfo,
    this._getAlbums,
  ) : super(const ArtistState());

  CancelableOperation<Result<List<ArtistSong>, RequestError>>? currentRequest;

  Future<void> getAlbums() async {
    final albumsResult = await _getAlbums(artistUrl);

    emit(
      state.copyWith(
        albums: albumsResult.isSuccess ? albumsResult.get()?.take(4).toList() : const [],
      ),
    );
  }

  Future<void> getArtistInfo() async {
    emit(state.copyWith(isLoading: true));
    final artistInfoResult = await _getArtistInfo(artistUrl);
    emit(
      state.copyWith(
        artistInfo: artistInfoResult.isSuccess ? artistInfoResult.get() : null,
        isLoading: false,
      ),
    );
  }

  Future<void> getArtistSongs() async {
    currentRequest?.cancel();
    currentRequest = _getArtistSongs(artistUrl: artistUrl, filter: ArtistSongFilter.cifra);

    var songsResult = (await currentRequest!.valueOrCancellation(Err(RequestCancelled())))!;
    if (songsResult.getError() is RequestCancelled) {
      return;
    }

    emit(
      state.copyWith(
        songs: songsResult.isSuccess ? songsResult.get()?.take(10).toList() : const [],
      ),
    );
  }
}
