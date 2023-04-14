// coverage:ignore-file
import 'dart:convert';
import 'dart:io';

import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';
import 'package:cifraclub/domain/remote_config/models/remote_product.dart';

class RemoteProductParameter extends RemoteConfigParameter<List<RemoteProduct>> {
  @override
  String get defaultValue {
    if (Platform.isIOS) {
      return r'''
    {
    "products": [{
        "dias": "0",
        "id": "cifra_club_pro_mensal",
        "preco": "R$ 9,90",
        "preco_us": "USD 2.99",
        "tipo": "mensal"
      },
      {
        "dias": "0",
        "id": "cifra_club_pro_anual",
        "preco": "R$ 35,90",
        "preco_us": "USD 9.99",
        "tipo": "anual"
      }
    ]
  }
  ''';
    } else {
      return r'''
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
    }
  }

  @override
  List<RemoteProduct> parseParam(String value) {
    final Map<String, dynamic> map = jsonDecode(value);
    final List<dynamic> products = map["products"];
    return products.map((data) => _remoteProductFromJson(data as Map<String, dynamic>)).toList();
  }

  @override
  String get remoteConfigKey => "cifraclub_products";

  RemoteProduct _remoteProductFromJson(Map<String, dynamic> json) {
    return RemoteProduct(
      days: json["dias"],
      id: json["id"],
      price: json["preco"],
      priceUS: json["preco_us"],
      type: json["tipo"],
    );
  }
}
