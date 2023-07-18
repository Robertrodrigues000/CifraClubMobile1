import 'package:cifraclub/domain/shared/request_error.dart';

abstract class ArtistEvent {}

class FavoriteError extends ArtistEvent {
  final RequestError error;

  FavoriteError({required this.error});
}
