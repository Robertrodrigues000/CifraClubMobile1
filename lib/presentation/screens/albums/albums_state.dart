import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'albums_state.g.dart';

@CopyWith()
class AlbumsState {
  final List<Album> albums;
  final bool isLoading;
  final RequestError? error;
  const AlbumsState({
    this.error,
    this.albums = const [],
    this.isLoading = false,
  });
}
