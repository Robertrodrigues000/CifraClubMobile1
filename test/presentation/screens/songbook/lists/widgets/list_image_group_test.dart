import 'package:cifraclub/presentation/screens/songbook/lists/widgets/default_list_image.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_image_group.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/small_list_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/fake_cache_manager.dart';
import '../../../../../test_helpers/image_data.dart';
import '../../../../../test_helpers/test_wrapper.dart';

void main() {
  late FakeCacheManager cacheManager;

  setUp(() {
    cacheManager = FakeCacheManager();
    cacheManager.returns("", kTransparentImage);
  });
  testWidgets("When images length is 1 should show default image", (widgetTester) async {
    await widgetTester.pumpWidget(
      RemoteImageCacheManager(
        cacheManager: cacheManager,
        child: const TestWrapper(
          child: ListImageGroup(
            images: [""],
          ),
        ),
      ),
    );

    expect(find.byType(DefaultListImage), findsOneWidget);
  });

  testWidgets("When images lenght is 2 should shouw two small images", (widgetTester) async {
    await widgetTester.pumpWidget(
      RemoteImageCacheManager(
        cacheManager: cacheManager,
        child: const TestWrapper(
          child: ListImageGroup(
            images: ["", ""],
          ),
        ),
      ),
    );

    expect(find.byType(SmallListImage), findsNWidgets(2));
  });

  testWidgets("When images lenght is 3 should shouw three small images", (widgetTester) async {
    await widgetTester.pumpWidget(
      RemoteImageCacheManager(
        cacheManager: cacheManager,
        child: const TestWrapper(
          child: ListImageGroup(
            images: ["", "", ""],
          ),
        ),
      ),
    );

    expect(find.byType(SmallListImage), findsNWidgets(3));
  });

  testWidgets("When images lenght is 4 or more should shouw four small images", (widgetTester) async {
    await widgetTester.pumpWidget(
      RemoteImageCacheManager(
        cacheManager: cacheManager,
        child: const TestWrapper(
          child: ListImageGroup(
            images: ["", "", "", ""],
          ),
        ),
      ),
    );

    expect(find.byType(SmallListImage, skipOffstage: false), findsNWidgets(4));
  });
}
