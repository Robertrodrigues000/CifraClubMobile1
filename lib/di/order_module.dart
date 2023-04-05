import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart';
// coverage:ignore-file
import 'package:cifraclub/data/subscription/repository/order_repository_impl.dart';
import 'package:cifraclub/domain/subscription/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class OrderModule {
  OrderRepository getOrderRepository(OrderDataSource dataSource) => OrderRepositoryImpl(dataSource: dataSource);

  OrderDataSource getOrderDataSource(CifraClubAPINetworkService networkService) =>
      OrderDataSource(networkService: networkService);
}
