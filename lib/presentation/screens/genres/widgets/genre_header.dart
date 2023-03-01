import 'package:cosmos/cosmos.dart';
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
            style: CosmosTypography.of(context).title3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(color: CosmosColorScheme.of(context).neutralTertiary),
        ),
      ],
    );
  }
}
