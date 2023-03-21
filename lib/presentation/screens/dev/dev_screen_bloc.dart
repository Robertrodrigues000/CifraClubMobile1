// coverage:ignore-file
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class DevScreenBloc extends Cubit<DevScreenState> {
  DevScreenBloc(this._getProducts) : super(const DevScreenState());
  final GetProducts _getProducts;

  Future<void> getProducts() async {
    final productsIds = {"cifraclub_pro_mensal_2021", "cifraclub_pro_anual_2021"};

    final products = await _getProducts(productsIds);
    // ignore: avoid_print
    products.onSuccess(print);
    // ignore: avoid_print
    products.onFailure(print);
  }
}
