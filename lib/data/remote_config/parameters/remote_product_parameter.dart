// coverage:ignore-file
import 'dart:convert';

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';
import 'package:cifraclub/domain/remote_config/models/remote_product.dart';

class RemoteProductParameter extends RemoteConfigParameter<RemoteProduct> {
  @override
  String get defaultValue => r'''
    {
	"products": [{
			"dias": "7",
			"id": "cifraclub_pro_mensal_2021",
			"preco": "R$ 9,99",
			"preco_us": "USD 1.99",
			"tipo": "mensal"
		},
		{
			"dias": "7",
			"id": "cifraclub_pro_anual_2021",
			"preco": "R$ 35,99",
			"preco_us": "USD 6.99",
			"tipo": "anual"
		}
	]
}
  ''';

  @override
  RemoteProduct parseParam(String value) {
    final Map<String, dynamic> map = jsonDecode(value);

    return RemoteProduct(
      days: map["dias"],
      id: map["id"],
      price: map["preco"],
      priceUS: map["preco_us"],
      type: map["tipo"],
    );
  }

  @override
  String get remoteConfigKey => "cifraclub_products";
}
