import 'package:cifraclub/domain/search/models/artist_search.dart';
import 'package:cifraclub/domain/search/models/search.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_dto.g.dart';

@JsonSerializable(createToJson: false)
class SearchDto extends Equatable {
  @JsonKey(name: "id_song")
  final int? idSong;
  @JsonKey(name: "tipo")
  final String? type;
  final String? txt;
  final String? url;
  @JsonKey(name: "id_artist")
  final int? idArtist;
  final String? art;
  final String? dns;
  final String? imgm;

  const SearchDto(
      {required this.idSong,
      required this.type,
      required this.txt,
      required this.url,
      required this.idArtist,
      required this.art,
      required this.dns,
      required this.imgm});

  factory SearchDto.fromJson(Map<String, dynamic> json) => _$SearchDtoFromJson(json);

  Search toDomain() {
    return idSong == null
        ? ArtistSearch(
            id: idArtist!,
            name: art!,
            url: dns!,
            imageUrl: imgm,
          )
        : SongSearch(
            songId: idSong!,
            songName: txt!,
            songUrl: url!,
            artistId: idArtist!,
            artistName: art!,
            artistUrl: dns!,
            artistImage: imgm,
          );
  }

  @override
  List<Object?> get props => [idSong, type, txt, url, idArtist, art, dns, imgm];
}
