import 'package:cifraclub/domain/home/models/home_image.dart';
import 'package:equatable/equatable.dart';

class Highlight extends Equatable {
  final String url;
  final String title;
  final String subtitle;
  final String icon;
  final String description;
  final String contentDescription;
  final HomeImage images;

  const Highlight({
    required this.url,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.description,
    required this.contentDescription,
    required this.images,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [url, title, description];
  // coverage:ignore-end
}
