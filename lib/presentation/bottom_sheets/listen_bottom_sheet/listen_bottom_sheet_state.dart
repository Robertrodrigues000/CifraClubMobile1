import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/youtube/models/youtube_video.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

part 'listen_bottom_sheet_state.g.dart';

@CopyWith()
@immutable
class ListenBottomSheetState {
  final List<YouTubeVideo> youtubeVideos;
  final bool isLoadingYoutube;
  final RequestError? youtubeError;

  const ListenBottomSheetState({
    this.youtubeVideos = const [],
    this.isLoadingYoutube = false,
    this.youtubeError,
  });
}
