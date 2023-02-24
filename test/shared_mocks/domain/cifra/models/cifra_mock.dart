import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:faker/faker.dart';

Cifra getFakeCifra() {
  return Cifra(faker.animal.name());
}
