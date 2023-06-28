import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlight_card.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:flutter/material.dart';

class HighlightSection extends StatelessWidget {
  final double size;
  final double borderRadius;
  final double internalPadding;
  final Highlight highlight;

  const HighlightSection({
    super.key,
    required this.size,
    required this.highlight,
    required this.borderRadius,
    required this.internalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return RemoteImage(
      imageUrl: highlight.images.large,
      placeholder: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: const DecorationImage(image: AssetImage(AppWebp.largePlaceholder), fit: BoxFit.cover)),
      ),
      // coverage:ignore-start
      imageBuilder: (context, imageProvider) => HighlightCard(
        internalPadding: internalPadding,
        size: size,
        borderRadius: borderRadius,
        highlight: highlight,
        imageProvider: imageProvider,
      ),
      // coverage:ignore-end
    );
  }
}
