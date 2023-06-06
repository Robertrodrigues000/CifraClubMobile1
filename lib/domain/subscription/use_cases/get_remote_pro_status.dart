import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:typed_result/typed_result.dart';

class GetRemoteProStatus {
  final GetOrders _getOrders;

  GetRemoteProStatus(this._getOrders);

  Future<bool?> call(UserCredential credential) async {
    bool? remoteProStatus;

    if (credential.isUserLoggedIn) {
      var remoteProResponse = await _getRemoteProStatus();
      if (remoteProResponse.isSuccess) {
        remoteProStatus = remoteProResponse.get();
      }
    } else {
      remoteProStatus = false;
    }

    return remoteProStatus;
  }

  Future<Result<bool, RequestError>> _getRemoteProStatus() async {
    return (await _getOrders()).map((ordersResponse) => ordersResponse.any((order) => order.status.isValid));
  }
}
