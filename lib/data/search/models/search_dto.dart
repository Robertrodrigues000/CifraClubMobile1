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
  final String? tipo;
  final String? txt;
  final String? url;
  @JsonKey(name: "id_artist")
  final int? idArtist;
  final String? art;
  final String? dns;
  final String? img;

  const SearchDto({required this.idSong, required this.tipo, required this.txt, required this.url, required this.idArtist, required this.art, required this.dns, required this.img});

  factory SearchDto.fromJson(Map<String, dynamic> json) => _$SearchDtoFromJson(json);

  Search toDomain() {
    return idSong == null
        ? ArtistSearch(
            id: idArtist!,
            name: art!,
            url: dns!,
            imageUrl: img,
          )
        : SongSearch(
            songId: idSong!,
            songName: txt!,
            songUrl: url!,
            artistId: idArtist!,
            artistName: art!,
            artistUrl: dns!,
            artistImage: img,
          );
  }

  @override
  List<Object?> get props => [idSong, tipo, txt, url, idArtist, art, dns, img];
}
