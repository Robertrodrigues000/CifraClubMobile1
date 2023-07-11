// coverage:ignore-file
import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_songs_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BottomSheetModule {
  DevBottomSheet getDevBottomSheet(GetGenres getGenres) => DevBottomSheet(getGenres);

  GenreBottomSheet getGenreBottomSheet(GetGenres getGenres) => GenreBottomSheet(getGenres);

  ListOptionsBottomSheet getListOptionsBottomSheet(
    DeleteSongbook deleteSongbook,
    UpdateSongbookData updateSongbookData,
    ValidateSongbookName validateSongbookName,
    ClearSongsFromSongbook clearSongsFromSongbook,
    ShareLink shareLink,
    EditListScreenBuilder editListScreenBuilder,
  ) =>
      ListOptionsBottomSheet(
        clearSongsFromSongbook,
        deleteSongbook,
        shareLink,
        updateSongbookData,
        validateSongbookName,
        editListScreenBuilder,
      );
}
