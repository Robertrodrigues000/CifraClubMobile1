import 'package:cifraclub/presentation/screens/songbook/lists/widgets/default_list_image.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_image_group.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/small_list_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image_cache_manager.dart';
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

  testWidgets("When images length is 2 should show two small images", (widgetTester) async {
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

  testWidgets("When images length is 3 should show three small images", (widgetTester) async {
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

  testWidgets("When images length is 4 or more should show four small images", (widgetTester) async {
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
