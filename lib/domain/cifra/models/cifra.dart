class Cifra {
  final String name;
  final int id;
  final String? songUrl;
  final String? tone;
  final int? type;
  Cifra({
    required this.name,
    required this.id,
    this.songUrl,
    this.tone,
    this.type,
  });
}
