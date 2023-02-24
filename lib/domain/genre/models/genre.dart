import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String name;
  final String url;

  const Genre({
    required this.name,
    required this.url,
  });

  @override
  List<Object> get props => [name, url];
}
