import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:typed_result/typed_result.dart';

class ArtistSongsBloc extends Cubit<ArtistSongsState> {
  final GetArtistVideoLessons _getArtistVideoLessons;

  ArtistSongsBloc(this._getArtistVideoLessons) : super(ArtistSongsState());

  Future<void> init(Instrument? instrument, String? artistUrl) async {
    emit(state.copyWith(instrument: instrument));
    await getVideoLessons(instrument, artistUrl ?? "");
  }

  Future<void> getVideoLessons(Instrument? instrument, String artistUrl) async {
    final result = await _getArtistVideoLessons(artistUrl);
    result.when(
        success: (value) => emit(
              state.copyWith(
                videoLessons: _filterVideoLessons(value, instrument),
              ),
            ),
        failure: (error) {
          emit(
            state.copyWith(error: error),
          );
        });
  }

  List<VideoLesson> _filterVideoLessons(List<VideoLesson> videoLessons, Instrument? instrument) {
    if (instrument == null) {
      return videoLessons;
    } else {
      return videoLessons.where((videoLesson) => videoLesson.instrument == instrument).toList();
    }
  }
}
