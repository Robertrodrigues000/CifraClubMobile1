import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ThumbRowElement {
  ThumbRowElement({
    this.imageUrl,
    this.imagePath,
    this.placeholder,
    this.color,
    this.backgroundColor,
    required this.shouldOutlineImage,
  });

  final String? imageUrl;
  final String? imagePath;
  final String? placeholder;
  final Color? color;
  final Color? backgroundColor;
  final bool shouldOutlineImage;
}

class ThumbRow extends StatelessWidget {
  const ThumbRow({super.key, required this.elements});
  final List<ThumbRowElement> elements;

  factory ThumbRow.forCommonList({
    key,
    required List<String> imageUrls,
    required String placeholder,
    required BuildContext context,
  }) {
    if (imageUrls.isEmpty) {
      return ThumbRow.forSpecialList(
        imagePath: AppSvgs.playlistIcon,
        backgroundColor: context.colors.neutralSextenary,
        context: context,
      );
    }
    return ThumbRow(
      key: key,
      elements: imageUrls
          .map(
            (e) => ThumbRowElement(
              shouldOutlineImage: false,
              imageUrl: e,
              placeholder: placeholder,
              color: CosmosColors.grey80,
              backgroundColor: Colors.white,
            ),
          )
          .toList(),
    );
  }

  ThumbRow.forSpecialList(
      {key, required String imagePath, required Color backgroundColor, required BuildContext context})
      : this(key: key, elements: [
          ThumbRowElement(shouldOutlineImage: false, color: context.colors.neutralSecondary),
          ThumbRowElement(shouldOutlineImage: true, color: context.colors.neutralTertiary),
          ThumbRowElement(
              shouldOutlineImage: true, imagePath: imagePath, color: Colors.white, backgroundColor: backgroundColor),
          ThumbRowElement(shouldOutlineImage: true, color: context.colors.neutralTertiary),
          ThumbRowElement(shouldOutlineImage: false, color: context.colors.neutralSecondary),
        ]);

  @override
  Widget build(BuildContext context) {
    const singleImageSpacing = 26;
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: (elements.length * singleImageSpacing) + 10,
      child: Stack(
        children: drawingOrder(elements.length).map((e) {
          return Row(
            children: [
              SizedBox.fromSize(
                  size: Size.fromWidth((singleImageSpacing * e.toDouble()) - (elements[e].shouldOutlineImage ? 2 : 0))),
              _ThumbRowElementWidget(
                imageUrl: elements[e].imageUrl,
                imagePath: elements[e].imagePath,
                color: elements[e].color,
                backgroundColor: elements[e].backgroundColor,
                placeholder: elements[e].placeholder,
                isOutlined: elements[e].shouldOutlineImage,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  List<int> drawingOrder(int count) {
    switch (count) {
      case 0:
        return [];
      case 1:
        return [0];
      case 2:
        return [1, 0];
      case 3:
        return [0, 2, 1];
      case 4:
        return [1, 3, 0, 2];
      case 5:
      default:
        return [0, 4, 1, 3, 2];
    }
  }
}

class _ThumbRowElementWidget extends StatelessWidget {
  const _ThumbRowElementWidget({
    this.imageUrl,
    this.imagePath,
    this.color,
    this.backgroundColor,
    this.placeholder,
    required this.isOutlined,
  });

  final String? imageUrl;
  final String? placeholder;
  final String? imagePath;
  final bool isOutlined;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null && imagePath == null) {
      return Container(
        width: isOutlined ? 40 : 36,
        height: isOutlined ? 40 : 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? context.colors.neutralSecondary,
          border: Border.all(color: context.colors.textPrimaryInverse, width: isOutlined ? 2 : 0),
        ),
      );
    }
    // coverage:ignore-start
    else if (imageUrl != null) {
      assert(placeholder != null && color != null && backgroundColor != null,
          "If imageUrl is provided, a placeholder should be provided too.");
      return RemoteImage(
        imageUrl: imageUrl!,
        imageBuilder: (image, imageProvider) => _RoundImage(
          imageProvider: imageProvider,
          isOutlined: isOutlined,
        ),
        placeholder: _RoundSvg(
          path: placeholder!,
          backgroundColor: backgroundColor!,
          color: color!,
          isOutlined: isOutlined,
        ),
      );
    }
    // coverage:ignore-end
    else {
      assert(color != null && backgroundColor != null,
          "If imagePath is provided, color and backgroundColor should be provided too.");
      return _RoundSvg(
        path: imagePath!,
        backgroundColor: backgroundColor!,
        color: color!,
        isOutlined: isOutlined,
        size: 24,
      );
    }
  }
}

class _RoundSvg extends StatelessWidget {
  const _RoundSvg({
    required this.path,
    required this.color,
    required this.backgroundColor,
    required this.isOutlined,
    this.size,
  });

  final String path;
  final Color color;
  final Color backgroundColor;
  final bool isOutlined;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isOutlined ? 40 : 36,
      height: isOutlined ? 40 : 36,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: context.colors.textPrimaryInverse, width: isOutlined ? 2 : 0),
      ),
      child: SvgImage(
        assetPath: path,
        height: size ?? 36,
        width: size ?? 36,
        color: color,
      ),
    );
  }
}

// coverage:ignore-start
class _RoundImage extends StatelessWidget {
  const _RoundImage({
    required this.isOutlined,
    required this.imageProvider,
  });

  final ImageProvider<Object> imageProvider;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isOutlined)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.textPrimaryInverse,
            ),
          ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
            ),
          ),
        ),
      ],
    );
  }
}
// coverage:ignore-end
