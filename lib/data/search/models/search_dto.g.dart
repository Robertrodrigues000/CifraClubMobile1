// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDto _$SearchDtoFromJson(Map<String, dynamic> json) => SearchDto(
      songId: json['id_song'] as int?,
      type: json['tipo'] as String,
      txt: json['txt'] as String?,
      url: json['url'] as String?,
      artistId: json['id_artist'] as int?,
      artist: json['art'] as String?,
      artistUrl: json['dns'] as String?,
      imgm: json['imgm'] as String?,
      albumUrl: json['url_album'] as String?,
      songbookId: json['id_sb'] as int?,
      userId: json['id_user'] as String?,
      songbookName: json['sb_name'] as String?,
      userName: json['user_name'] as String?,
      totalSongs: json['qnt_songs'] as int?,
      imgsm: (json['imgsm'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isVerified: json['v'] as bool?,
    );
