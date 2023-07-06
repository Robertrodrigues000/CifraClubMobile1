import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ArtistBloc extends Cubit<ArtistState> {
  final String artistUrl;
  final GetArtistInfo _getArtistInfo;
  final GetArtistSongs _getArtistSongs;
  final GetAlbums _getAlbums;
  final GetDefaultInstruments _getDefaultInstruments;

  ArtistBloc(
    this.artistUrl,
    this._getArtistSongs,
    this._getArtistInfo,
    this._getAlbums,
    this._getDefaultInstruments,
  ) : super(const ArtistState());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    final results = await Future.wait([
      _getArtistInfo(artistUrl),
      _getArtistSongs(artistUrl: artistUrl, filter: ArtistSongFilter.cifra),
      _getAlbums(artistUrl)
    ]);

    ArtistInfo? artistInfo;
    List<ArtistSong>? songs;
    List<Album>? albums;
    List<Instrument> filters = [];

    final artistInfoResult = results[0] as Result<ArtistInfo, RequestError>;
    final songsResult = results[1] as Result<List<ArtistSong>, RequestError>;
    final albumsResult = results[2] as Result<List<Album>, RequestError>;

    if (artistInfoResult.isSuccess && songsResult.isSuccess && songsResult.get()!.isNotEmpty) {
      artistInfo = artistInfoResult.get();
      songs = songsResult.get();
      albums = albumsResult.get() ?? const [];
      filters = await _getDefaultInstruments(songs!);

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

  void onInstrumentSelected(Instrument? instrument) async {
    if (instrument != state.selectedInstrument) {
      emit(state.copyWith(selectedInstrument: instrument));
    }
  }
}
