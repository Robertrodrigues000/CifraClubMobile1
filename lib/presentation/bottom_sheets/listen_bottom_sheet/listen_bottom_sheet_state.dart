import 'package:copy_with_extension/copy_with_extension.dart';

@CopyWith()
class ListenBottomSheetState {
  final List<String> youtubeVideos;

  const ListenBottomSheetState({this.youtubeVideos = const []});
}
