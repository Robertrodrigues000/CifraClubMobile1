import 'dart:typed_data';

import 'package:cifraclub/domain/song/use_cases/get_local_song_image.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_songs.dart';
import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ListenBottomSheetBloc extends Cubit<ListenBottomSheetState> {
  final GetYouTubeVideos _getYouTubeVideos;
  final GetLocalSongs _getLocalSongs;
  final GetLocalSongImage _getLocalSongImage;
  final String artistName;
  final String songName;

  ListenBottomSheetBloc(
    this._getYouTubeVideos,
    this._getLocalSongs,
    this._getLocalSongImage, {
    required this.artistName,
    required this.songName,
  }) : super(const ListenBottomSheetState());

  void init() async {
    await getYouTubeVideos();
  }

  Future<void> getYouTubeVideos() async {
    emit(state.copyWith(isLoadingYoutube: true, youtubeError: null));
    final result = await _getYouTubeVideos(artistName: artistName, songName: songName);
    result.when(
      success: (value) {
        emit(state.copyWith(isLoadingYoutube: false, youtubeVideos: value));
      },
      failure: (error) {
        emit(state.copyWith(isLoadingYoutube: false, youtubeError: error));
      },
    );
  }

  Future<void> getLocalSongs() async {
    emit(state.copyWith(isLoadingLocalSongs: true, localSongsError: null));
    final result = await _getLocalSongs(artistName: artistName, songName: songName);

    result.when(
      success: (value) {
        emit(state.copyWith(isLoadingLocalSongs: false, localSongs: value));
      },
      failure: (error) {
        emit(state.copyWith(isLoadingLocalSongs: false, localSongsError: error));
      },
    );
  }

  Future<Uint8List?> getImage(String url) async {
    return _getLocalSongImage(url);
  }
}
