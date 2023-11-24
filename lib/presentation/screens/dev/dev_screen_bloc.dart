// coverage:ignore-file
import 'package:cifraclub/domain/chord/models/instrument_chord.dart';
import 'package:cifraclub/domain/chord/use_cases/get_chords_representation.dart';
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart';
import 'package:cifraclub/domain/search/use_cases/search_shazam.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart';
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart';
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shazam/pigeon.g.dart';
import 'package:typed_result/typed_result.dart';

class DevScreenBloc extends Cubit<DevScreenState> {
  final GetProducts _getProducts;
  final GetRemoteProductsIds _getRemoteProductsIds;
  final PurchaseProduct _purchaseProduct;
  final InAppPurchaseRepository _inAppPurchaseRepository;
  final GetOrders _getOrders;
  final PostPurchaseOrder _postPurchaseOrder;
  final GetIsProPreference _getIsProPreference;
  final GetVersionData _getVersionData;
  final GetChordsRepresentation _getChordsRepresentation;
  final SearchShazam _searchShazam;

  DevScreenBloc(
    this._getProducts,
    this._getRemoteProductsIds,
    this._purchaseProduct,
    this._inAppPurchaseRepository,
    this._getOrders,
    this._postPurchaseOrder,
    this._getIsProPreference,
    this._getChordsRepresentation,
    this._getVersionData,
    this._searchShazam,
  ) : super(const DevScreenState(isLoading: false));

  CancelableOperation<Result<List<dynamic>, RequestError>>? currentRequest;

  Future<void> restorePurchases() async {
    return _inAppPurchaseRepository.restorePurchases();
  }

  Future<void> purchase() async {
    final productIds = _getRemoteProductsIds();
    final products = await _getProducts(productIds.toSet());

    products.onSuccess(
      (products) {
        // ignore: avoid_print
        logger?.log(tag: runtimeType.toString(), message: "Purchasing ${products[1]}");
        _purchaseProduct(products[1]);
      },
    );
    // ignore: avoid_print
    products.onFailure(print);
  }

  Future<void> getOrders() async {
    final result = await _getOrders();

    // ignore: avoid_print
    result.onSuccess(print);
    // ignore: avoid_print
    result.onFailure(print);
  }

  Future<void> postOrder(Purchase purchase) async {
    final result = await _postPurchaseOrder(purchase);

    // ignore: avoid_print
    print(result);
  }

  void toggleIsLoading() async {
    final isPro = _getIsProPreference();
    // ignore: avoid_print
    print(isPro);

    emit(DevScreenState(isLoading: !state.isLoading));
  }

  Future<void> getChordsRepresentation() async {
    final versionDataResult = await _getVersionData(
      artistUrl: "joao-bosco",
      songUrl: "o-bebado-a-equilibrista",
      instrumentUrl: Instrument.guitar.instrumentUrl,
      versionUrl: "principal",
    );
    if (versionDataResult.isSuccess) {
      final versionData = versionDataResult.get();
      final chordRepresentation = _getChordsRepresentation(
        chords: versionData?.chords
                ?.map((e) => InstrumentChord(name: e.name, fretDiagram: e.guitar?.first ?? "", shapeName: e.shapeName))
                .toList() ??
            [],
        instrument: Instrument.guitar,
        capo: Capo.capo6,
      );
      // ignore: avoid_print
      print(chordRepresentation.first);

      emit(DevScreenState(isLoading: false, chordRepresentation: chordRepresentation));
    }
  }

  void shazamRequest() async {
    emit(const DevScreenState(isLoading: true));
    (await _searchShazam()).when(
      success: (value) {
        emit(DevScreenState(isLoading: false, shazamResult: "${value.artistName} -- ${value.songName}"));
      },
      failure: (error) {
        emit(DevScreenState(isLoading: false, shazamResult: error.runtimeType.toString()));
      },
    );
  }

  void cancelShazam() async {
    await ShazamHostApi().cancelSearch();
    emit(const DevScreenState(isLoading: false));
  }
}
