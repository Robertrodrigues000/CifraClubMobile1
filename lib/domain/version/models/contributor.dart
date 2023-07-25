class Contributor {
  final String name;
  final int id;
  final int type;
  final String? avatar;
  final String url;

  Contributor({
    required this.name,
    required this.id,
    required this.type,
    this.avatar,
    required this.url,
  });
}
