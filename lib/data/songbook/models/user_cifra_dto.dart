import 'package:isar/isar.dart';
part 'user_cifra_dto.g.dart';

@collection
class UserCifraDto {
  Id id = Isar.autoIncrement;
  final String name;
  final int apiId;
  final String songUrl;
  final String? tone;
  final int type;
  UserCifraDto({
    required this.apiId,
    required this.songUrl,
    this.tone,
    required this.type,
    required this.name,
  });
}
