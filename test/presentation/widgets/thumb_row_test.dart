import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/thumb_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When using ThumbRow forCommonList with 5 urls, should show 5 images plus the outer container",
      (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: Builder(builder: (context) {
            return ThumbRow.forCommonList(
              imageUrls: const [
                "https://akamai.sscdn.co/letras/36x36/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                "https://akamai.sscdn.co/letras/36x36/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
                "https://akamai.sscdn.co/letras/36x36/fotos/6/c/4/3/6c43c6533e5ece5e2d539c4804f28f9e-tb.jpg",
                "", //"https://akamai.sscdn.co/letras/36x36/fotos/e/0/5/3/e053e2dbf6fd2bd607ee173aec4c6361-tb.jpg", // para exibir o placeholder
                "https://akamai.sscdn.co/letras/36x36/fotos/8/d/b/0/8db0d1ac3efdb1b50400b5b1dba9ab73-tb.jpg",
              ],
              placeholder: AppSvgs.artistsAvatarPlaceHolder,
              context: context,
            );
          }),
        ),
      );
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(Container), findsNWidgets(6));
  });
  testWidgets("When using ThumbRow forCommonList with 4 urls, should show 4 images plus the outer container",
      (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: Builder(builder: (context) {
            return ThumbRow.forCommonList(
              imageUrls: const [
                "https://akamai.sscdn.co/letras/36x36/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                "https://akamai.sscdn.co/letras/36x36/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
                "https://akamai.sscdn.co/letras/36x36/fotos/6/c/4/3/6c43c6533e5ece5e2d539c4804f28f9e-tb.jpg",
                "", //"https://akamai.sscdn.co/letras/36x36/fotos/e/0/5/3/e053e2dbf6fd2bd607ee173aec4c6361-tb.jpg", // para exibir o placeholder
              ],
              placeholder: AppSvgs.artistsAvatarPlaceHolder,
              context: context,
            );
          }),
        ),
      );
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(Container), findsNWidgets(5));
  });
  testWidgets("When using ThumbRow forCommonList with 3 urls, should show 3 images plus the outer container",
      (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: Builder(builder: (context) {
            return ThumbRow.forCommonList(
              imageUrls: const [
                "https://akamai.sscdn.co/letras/36x36/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                "https://akamai.sscdn.co/letras/36x36/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
                "https://akamai.sscdn.co/letras/36x36/fotos/6/c/4/3/6c43c6533e5ece5e2d539c4804f28f9e-tb.jpg",
              ],
              placeholder: AppSvgs.artistsAvatarPlaceHolder,
              context: context,
            );
          }),
        ),
      );
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(Container), findsNWidgets(4));
  });
  testWidgets("When using ThumbRow forCommonList with 2 urls, should show 2 images plus the outer container",
      (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: Builder(builder: (context) {
            return ThumbRow.forCommonList(
              imageUrls: const [
                "https://akamai.sscdn.co/letras/36x36/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                "https://akamai.sscdn.co/letras/36x36/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
              ],
              placeholder: AppSvgs.artistsAvatarPlaceHolder,
              context: context,
            );
          }),
        ),
      );
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(Container), findsNWidgets(3));
  });
  testWidgets("When using ThumbRow forCommonList with 1 urls, should show 1 image plus the outer container",
      (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: Builder(builder: (context) {
            return ThumbRow.forCommonList(
              imageUrls: const [
                "https://akamai.sscdn.co/letras/36x36/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
              ],
              placeholder: AppSvgs.artistsAvatarPlaceHolder,
              context: context,
            );
          }),
        ),
      );
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(Container), findsNWidgets(2));
  });
  testWidgets("When using ThumbRow forCommonList with 0 urls, should show 5 images plus the outer container",
      (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: Builder(builder: (context) {
            return ThumbRow.forCommonList(
              imageUrls: const [],
              placeholder: AppSvgs.artistsAvatarPlaceHolder,
              context: context,
            );
          }),
        ),
      );
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(Container), findsNWidgets(6));
  });

  testWidgets("When using ThumbRow forSpecialList, should show 5 images", (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        TestWrapper(
          child: Builder(builder: (context) {
            return ThumbRow.forSpecialList(
              imagePath: AppSvgs.songbookWillPlayIcon,
              context: context,
              backgroundColor: Colors.pink,
            );
          }),
        ),
      );
    });
    await widgetTester.pumpAndSettle();

    expect(find.byType(Container), findsNWidgets(6));
  });
}
