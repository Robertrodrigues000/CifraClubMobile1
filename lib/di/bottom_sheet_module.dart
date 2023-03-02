// coverage:ignore-file
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/presentation/screens/dev/widgets/bottom_sheet/dev_bottom_sheet.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BottomSheetModule {
  DevBottomSheet getDevBottomSheet(
    GetGenres getGenres,
  ) {
    return DevBottomSheet(getGenres);
  }
}
