import 'package:cifraclub/presentation/screens/songbook/lists/widgets/default_list_image.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/small_list_image.dart';
import 'package:flutter/widgets.dart';

class ListImageGroup extends StatelessWidget {
  const ListImageGroup({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Builder(builder: (context) {
        if (images.length > 1) {
          return _ImageGroup(
            images: images,
          );
        } else {
          return DefaultListImage(image: images.isNotEmpty ? images[0] : "");
        }
      }),
    );
  }
}

class _ImageGroup extends StatelessWidget {
  const _ImageGroup({
    required this.images,
  });
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: images.length == 3 ? Alignment.topCenter : Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(top: images.length < 4 ? 2.5 : 0, left: images.length == 2 ? 4 : 0),
                    child: SmallListImage(image: images[0])),
              ),
            ),
            if (images.length == 4)
              Align(
                alignment: Alignment.topRight,
                child: SmallListImage(image: images[3]),
              ),
          ],
        ),
        Row(
          children: [
            if (images.length == 2)
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SmallListImage(image: images[1]),
                ),
              )
            else ...[
              Align(
                alignment: Alignment.bottomLeft,
                child: SmallListImage(image: images[1]),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SmallListImage(image: images[2]),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
