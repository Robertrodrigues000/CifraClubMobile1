// https://github.com/StudioSol/CifraClub/blob/development/pkg/server/rest/v3/order.go#L355

// @Success 204 {object} http.ResponseWriter "Sucesso - Assinatura criada"
// @Failure 400 {object} http.ResponseWriter "Parâmetro inválido"
// @Failure 401 {object} http.ResponseWriter "Usuário não logado"
// @Failure 409 {object} viewmodel.AlreadyLinkedResponse "Token informado já está vinculado a outra assinatura"
// @Failure 424 {object} http.ResponseWriter "Assinatura não foi validada pelo cliente de pagamento"
// @Failure 503 {object} http.ResponseWriter "Erro ao inserir usuário no banco de dados"
// @Router /v3/orders/ [post]

enum PurchaseResult {
  success,
  invalidParams,
  userNotLogged,
  tokenAlreadyValidated,
  paymentError,
  serverError,
  requestError,
  unknown,
}
