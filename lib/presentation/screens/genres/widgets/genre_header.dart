import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class GenreHeader extends StatelessWidget {
  final String text;
  final bool isDividerVisible;
  const GenreHeader({super.key, required this.text, required this.isDividerVisible});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.appDimensionScheme.screenMargin, vertical: context.appDimensionScheme.internalMargin),
      child: Text(
        text,
        style: context.typography.title5,
      ),
    );
  }
}
