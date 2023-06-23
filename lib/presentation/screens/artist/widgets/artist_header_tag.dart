import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ArtistHeaderTag extends StatelessWidget {
  const ArtistHeaderTag({
    super.key,
    required this.color,
    required this.genreName,
  });
  final Color color;
  final String genreName;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 29,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(12),
            topEnd: Radius.circular(12),
            bottomEnd: Radius.circular(12),
            bottomStart: Radius.circular(2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          genreName,
          style: context.typography.subtitle6.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
