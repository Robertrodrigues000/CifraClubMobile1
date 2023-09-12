import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:equatable/equatable.dart';

class SongbookSearch extends Equatable implements SearchItem {
  final int songbookId;
  final String songbookName;
  final String userName;
  final String userId;
  final int totalSongs;
  final List<String>? songbookPreview;

  const SongbookSearch({
    required this.songbookId,
    required this.songbookName,
    required this.userName,
    required this.userId,
    required this.totalSongs,
    required this.songbookPreview,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [songbookId, songbookName, songbookPreview, userId, userName, totalSongs];
// coverage:ignore-end
}
