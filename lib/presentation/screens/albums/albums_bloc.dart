import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/albums/albums_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class AlbumsBloc extends Cubit<AlbumsState> {
  final String? artistUrl;
  final GetAlbums _getAlbums;
  AlbumsBloc(this.artistUrl, this._getAlbums) : super(const AlbumsState());

  Future<void> init() async {
    await getAlbums();
  }

  Future<void> getAlbums() async {
    emit(state.copyWith(isLoading: true));
    final albumsResult = await _getAlbums(artistUrl ?? "");

    albumsResult.when(
        success: (value) => emit(
              state.copyWith(
                albums: albumsResult.isSuccess ? albumsResult.get() : const [],
                isLoading: false,
                error: null,
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
        });
  }
}
