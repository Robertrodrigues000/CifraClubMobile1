import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ListenBottomSheetBloc extends Cubit<ListenBottomSheetState> {
  final GetYouTubeVideos _getYouTubeVideos;

  ListenBottomSheetBloc(
    this._getYouTubeVideos,
  ) : super(const ListenBottomSheetState());

  void init() async {
    await getYouTubeVideos();
  }

  Future<void> getYouTubeVideos() async {
    emit(state.copyWith(isLoadingYoutube: true, youtubeError: null));
    final result = await _getYouTubeVideos(artistName: "sdfasfdsf", songName: "asfdsafsdafas");
    result.when(
      success: (value) {
        emit(state.copyWith(isLoadingYoutube: false, youtubeVideos: value));
      },
      failure: (error) {
        emit(state.copyWith(isLoadingYoutube: false, youtubeError: error));
      },
    );
  }
}
