// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;
  final String url;

  const Genre({
    required this.id,
    required this.name,
    required this.url,
  });

  @override
  List<Object> get props => [id, name, url];
}
