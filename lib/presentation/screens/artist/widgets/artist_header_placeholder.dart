import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class HeaderPlaceholder extends StatelessWidget {
  final String placeholder;
  final double height;
  const HeaderPlaceholder({super.key, required this.placeholder, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
      height: height,
      decoration: BoxDecoration(
        color: CosmosColors.grey90,
        image: DecorationImage(image: AssetImage(placeholder), fit: BoxFit.cover),
      ),
    );
  }
}
