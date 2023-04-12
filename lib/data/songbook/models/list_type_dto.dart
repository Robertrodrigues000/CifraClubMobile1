// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/list_type.dart';

enum ListTypeDto {
  user("default"),
  favorites("favorites"),
  canPlay("canplay"),
  cantPlay("cantplay"),
  recents("recents");

  final String apiName;

  const ListTypeDto(this.apiName);

  ListType toDomain() {
    switch (this) {
      case ListTypeDto.user:
        return ListType.user;
      case ListTypeDto.favorites:
        return ListType.favorites;
      case ListTypeDto.canPlay:
        return ListType.canPlay;
      case ListTypeDto.cantPlay:
        return ListType.cantPlay;
      case ListTypeDto.recents:
        return ListType.recents;
    }
  }

  static ListTypeDto fromDomain(ListType type) {
    switch (type) {
      case ListType.user:
        return ListTypeDto.user;
      case ListType.favorites:
        return ListTypeDto.favorites;
      case ListType.canPlay:
        return ListTypeDto.canPlay;
      case ListType.cantPlay:
        return ListTypeDto.cantPlay;
      case ListType.recents:
        return ListTypeDto.recents;
    }
  }
}
