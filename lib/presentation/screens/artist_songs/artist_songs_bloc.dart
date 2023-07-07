// coverage:ignore-file
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistSongsBloc extends Cubit<ArtistSongsState> {
  ArtistSongsBloc() : super(ArtistSongsState(artistName: "Artist name"));

  Future<void> init() async {}
}
