import 'package:cifraclub/domain/artist/models/album_detail.dart';
import 'package:cifraclub/domain/artist/models/album_disc.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'album_state.g.dart';

@CopyWith()
class AlbumState {
  final AlbumDetail? album;
  final List<AlbumDisc> discs;
  final bool isLoading;
  final RequestError? error;

  const AlbumState({this.discs = const [], this.album, this.isLoading = false, this.error});
}
