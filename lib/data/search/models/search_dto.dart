import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/artist_search.dart';
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/models/search_models/songbook_search.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_dto.g.dart';

@JsonSerializable(createToJson: false)
class SearchDto extends Equatable {
  @JsonKey(name: "id_song")
  final int? songId;
  @JsonKey(name: "tipo")
  final String type;
  final String? txt;
  final String? url;
  @JsonKey(name: "id_artist")
  final int? artistId;
  @JsonKey(name: "art")
  final String? artist;
  @JsonKey(name: "dns")
  final String? artistUrl;
  final String? imgm;
  @JsonKey(name: "url_album")
  final String? albumUrl;
  @JsonKey(name: "id_sb")
  final int? songbookId;
  @JsonKey(name: "id_user")
  final String? userId;
  @JsonKey(name: "sb_name")
  final String? songbookName;
  @JsonKey(name: "user_name")
  final String? userName;
  @JsonKey(name: "qnt_songs")
  final int? totalSongs;
  final List<String>? imgsm;

  const SearchDto({
    required this.songId,
    required this.type,
    required this.txt,
    required this.url,
    required this.artistId,
    required this.artist,
    required this.artistUrl,
    required this.imgm,
    required this.albumUrl,
    required this.songbookId,
    required this.userId,
    required this.songbookName,
    required this.userName,
    required this.totalSongs,
    required this.imgsm,
  });

  factory SearchDto.fromJson(Map<String, dynamic> json) => _$SearchDtoFromJson(json);

  SearchItem? toDomain() {
    switch (type) {
      case "1":
        return ArtistSearch(id: artistId!, name: artist!, url: artistUrl!, imageUrl: imgm);
      case "2":
        return SongSearch(
            songId: songId!,
            songName: txt!,
            songUrl: url!,
            artistId: artistId!,
            artistName: artist!,
            artistUrl: artistUrl!,
            artistImage: imgm);
      case "5":
        return SongbookSearch(
            songbookId: songbookId!,
            songbookName: songbookName!,
            userName: userName!,
            userId: userId!,
            totalSongs: totalSongs!,
            songbookPreview: imgsm);
      case "6":
        return AlbumSearch(
            albumName: txt!,
            albumUrl: albumUrl!,
            artistId: artistId!,
            artistName: artist!,
            artistUrl: artistUrl!,
            albumCover: imgm);
      default:
        return null;
    }
  }

  @override
  List<Object?> get props => [songId, type, txt, url, artistId, artist, artistUrl, imgm];
}
