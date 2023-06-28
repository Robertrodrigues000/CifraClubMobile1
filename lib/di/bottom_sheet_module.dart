// coverage:ignore-file
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BottomSheetModule {
  DevBottomSheet getDevBottomSheet(GetGenres getGenres) => DevBottomSheet(getGenres);

  GenreBottomSheet getGenreBottomSheet(GetGenres getGenres) => GenreBottomSheet(getGenres);
}
