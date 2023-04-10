class Product<T> {
  final String id;
  final String title;
  final String price;
  final double rawPrice;
  final String description;
  final String currencyCode;
  final String currencySymbol;
  final String? introductoryPrice;
  final double? rawIntroductoryPrice;
  final T productDto;
  // O objeto de domínio contém o dto dentro dele pois, em alguns momentos,
  // é necessário devolvê-lo para a lib de IAP.
  // Nesses casos, devolvemos o objeto original em vez de implementar um fromDomain()
  // para evitar problemas caso a lib altere a estrutura deste objeto algum dia.

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rawPrice,
    required this.description,
    required this.currencyCode,
    required this.currencySymbol,
    required this.productDto,
    this.introductoryPrice,
    this.rawIntroductoryPrice,
  });
}
