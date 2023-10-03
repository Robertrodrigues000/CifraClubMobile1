import 'dart:ui';

import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/artist/use_cases/get_album_detail.dart';
import 'package:cifraclub/presentation/screens/album/album_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class AlbumBloc extends Cubit<AlbumState> {
  final String? artistUrl;
  final String? albumUrl;
  final GetAlbumDetail _getAlbumDetail;
  final ShareLink _shareLink;
  AlbumBloc(this.artistUrl, this.albumUrl, this._getAlbumDetail, this._shareLink) : super(const AlbumState());

  Future<void> init() async {
    await getAlbumDetail();
  }

  Future<void> getAlbumDetail() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAlbumDetail(artistUrl: artistUrl ?? "", albumUrl: albumUrl ?? "");

    result.when(
        success: (value) => emit(
              state.copyWith(
                album: value,
                discs: value.discs,
                isLoading: false,
                error: null,
              ),
            ),
        failure: (error) {
          emit(
            state.copyWith(
              error: error,
              isLoading: false,
            ),
          );
        });
  }

  Future<void> shareLink(String link, Rect? rect) async {
    await _shareLink(link: link, sharePositionOrigin: rect);
  }
}
