import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:faker/faker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

Product getFakeProduct() {
  final id = faker.animal.name();
  final title = faker.company.name();
  final description = faker.lorem.sentence();
  final price = faker.randomGenerator.string(50);
  final rawPrice = faker.randomGenerator.decimal();
  final currencyCode = faker.currency.code();
  final currencySymbol = faker.currency.toString();

  return Product(
    id: id,
    title: title,
    description: description,
    price: price,
    rawPrice: rawPrice,
    currencyCode: currencyCode,
    currencySymbol: currencySymbol,
    productDto: ProductDetails(
        id: id,
        title: title,
        description: description,
        price: price,
        rawPrice: rawPrice,
        currencyCode: currencyCode,
        currencySymbol: currencySymbol),
  );
}
