import 'package:cifraclub/presentation/style/app_color_scheme/app_color_scheme.dart';
import 'package:cifraclub/presentation/style/app_typography_scheme/app_typography_scheme.dart';
import 'package:flutter/material.dart';

class GenreHeader extends StatelessWidget {
  final String text;
  const GenreHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            text,
            style: AppTypographyScheme.of(context).genreHeaderItemStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(color: AppColorScheme.of(context).genreHeaderDividerColor),
        ),
      ],
    );
  }
}
