import 'package:isar/isar.dart';
part 'user_cifra_dto.g.dart';

@collection
class UserCifraDto {
  Id id = Isar.autoIncrement;
  final String name;

  UserCifraDto({required this.name});
}
