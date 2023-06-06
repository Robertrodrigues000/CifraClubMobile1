// https://github.com/StudioSol/CifraClub/blob/development/pkg/server/rest/v3/order.go#L355

// @Success 204 {object} http.ResponseWriter "Sucesso - Assinatura criada"
// @Failure 400 {object} http.ResponseWriter "Parâmetro inválido"
// @Failure 401 {object} http.ResponseWriter "Usuário não logado"
// @Failure 409 {object} viewmodel.AlreadyLinkedResponse "Token informado já está vinculado a outra assinatura"
// @Failure 424 {object} http.ResponseWriter "Assinatura não foi validada pelo cliente de pagamento"
// @Failure 503 {object} http.ResponseWriter "Erro ao inserir usuário no banco de dados"
// @Router /v3/orders/ [post]

import 'package:cifraclub/domain/subscription/models/purchase_result.dart';

enum PurchaseResultDto {
  success,
  invalidParams,
  userNotLogged,
  tokenAlreadyValidated,
  paymentError,
  serverError,
  requestError,
  unknown;

  PurchaseResult toDomain() {
    switch (this) {
      case PurchaseResultDto.success:
        return PurchaseResult.valid;

      case PurchaseResultDto.invalidParams:
      case PurchaseResultDto.userNotLogged:
      case PurchaseResultDto.paymentError:
        return PurchaseResult.invalid;

      case PurchaseResultDto.tokenAlreadyValidated:
        return PurchaseResult.tokenAlreadyValidated;

      case PurchaseResultDto.serverError:
      case PurchaseResultDto.requestError:
      case PurchaseResultDto.unknown:
        return PurchaseResult.unknown;
    }
  }
}
