import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';

abstract class GenreBottomSheetState {}

class GenreBottomSheetLoadingState extends GenreBottomSheetState {}

class GenreBottomSheetErrorState extends GenreBottomSheetState {
  final RequestError error;

  GenreBottomSheetErrorState(this.error);
}

class GenreBottomSheetLoadedState extends GenreBottomSheetState {
  final List<GenreItem> genres;

  GenreBottomSheetLoadedState({required this.genres});
}
