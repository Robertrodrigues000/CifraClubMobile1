import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:faker/faker.dart';

Product getFakeProduct() {
  return Product(
      id: faker.animal.name(),
      title: faker.company.name(),
      description: faker.lorem.sentence(),
      price: faker.randomGenerator.string(50),
      rawPrice: faker.randomGenerator.decimal(),
      currencyCode: faker.currency.code(),
      currencySymbol: faker.currency.toString());
}
