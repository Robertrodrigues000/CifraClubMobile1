import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:faker/faker.dart';

Order getFakeOrder() => Order(
      status: OrderStatus.values[faker.randomGenerator.integer(OrderStatus.values.length)],
      sku: faker.internet.domainName(),
      expirationDate: faker.date.year(),
    );
