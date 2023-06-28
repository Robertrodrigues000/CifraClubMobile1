import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/fake_cache_manager.dart';
import '../../test_helpers/image_data.dart';
import '../../test_helpers/test_wrapper.dart';

void main() {
  late FakeCacheManager cacheManager;

  setUp(() {
    cacheManager = FakeCacheManager();
  });

  tearDown(() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });

  testWidgets("when imageUrl is invalid should show error", (widgetTester) async {
    cacheManager.throwsNotFound("");
    await widgetTester.pumpWidget(TestWrapper(
      child: RemoteImageCacheManager(
          cacheManager: cacheManager,
          child: RemoteImage(
            imageUrl: "",
            errorWidget: (context, url, error) => const Text("error"),
          )),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text("error"), findsOneWidget);
  });

  testWidgets("when imageUrl is valid should not show error", (widgetTester) async {
    cacheManager.returns("", kTransparentImage);
    await widgetTester.pumpWidget(TestWrapper(
      child: RemoteImageCacheManager(
        cacheManager: cacheManager,
        child: RemoteImage(
          imageUrl: "",
          errorWidget: (context, url, error) => const Text("error"),
        ),
      ),
    ));
    await widgetTester.pumpAndSettle();
    expect(find.text("error"), findsNothing);
  });

  testWidgets("when imageUrl is invalid and errorWidget is null should show placeholder", (widgetTester) async {
    cacheManager.throwsNotFound("");
    await widgetTester.pumpWidget(TestWrapper(
      child: RemoteImageCacheManager(
          cacheManager: cacheManager,
          child: const RemoteImage(
            imageUrl: "",
            placeholder: CircularProgressIndicator(),
          )),
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
