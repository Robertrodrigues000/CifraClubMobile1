// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetProducts {
  final InAppPurchaseRepository _inAppPurchaseRepository;

  const GetProducts(this._inAppPurchaseRepository);

  Future<Result<List<Product>, PurchaseError>> call(Set<String> ids) => _inAppPurchaseRepository.getProducts(ids);
}
