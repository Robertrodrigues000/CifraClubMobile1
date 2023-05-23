// coverage:ignore-file
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistBloc extends Cubit<ArtistState> {
  ArtistBloc() : super(const ArtistState());
  final songs = List.generate(10, (index) => index + 1);
  final albuns = List.generate(10, (index) => index + 1);

  Future<void> getArtistInfo() async {
    emit(
      state.copyWith(
        songs: songs,
        albuns: albuns,
      ),
    );
  }
}
