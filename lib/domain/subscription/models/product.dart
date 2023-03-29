class Product {
  final String id;
  final String title;
  final String price;
  final double rawPrice;
  final String description;
  final String currencyCode;
  final String currencySymbol;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rawPrice,
    required this.description,
    required this.currencyCode,
    required this.currencySymbol,
  });
}
