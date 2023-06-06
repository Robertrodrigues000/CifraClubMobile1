import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ArtistBloc extends Cubit<ArtistState> {
  final GetArtistSongs _getArtistSongs;
  final String artistUrl;
  ArtistBloc(
    this.artistUrl,
    this._getArtistSongs,
  ) : super(const ArtistState());

  final albuns = List.generate(10, (index) => index + 1);

  CancelableOperation<Result<List<ArtistSong>, RequestError>>? currentRequest;

  Future<void> getArtistSongs() async {
    currentRequest?.cancel();
    currentRequest = _getArtistSongs(artistUrl: artistUrl, filter: ArtistSongFilter.cifra);

    var songsResult = (await currentRequest!.valueOrCancellation(Err(RequestCancelled())))!;
    if (songsResult.getError() is RequestCancelled) {
      return;
    }

    emit(
      state.copyWith(
        songs: songsResult.isSuccess ? songsResult.get()! : const [],
        albuns: albuns,
      ),
    );
  }
}
