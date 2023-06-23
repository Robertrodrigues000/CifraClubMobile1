import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ArtistHeaderPlaceholder extends StatelessWidget {
  final String placeholder;

  const ArtistHeaderPlaceholder({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
      height: context.appDimensionScheme.artistHeaderHeight,
      decoration: BoxDecoration(
        color: CosmosColors.grey90,
        image: DecorationImage(image: AssetImage(placeholder), fit: BoxFit.cover),
      ),
    );
  }
}
