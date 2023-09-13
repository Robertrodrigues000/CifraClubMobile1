import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_recents.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/songbook_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _InsertVersionDataToRecents extends Mock implements InsertVersionDataToRecents {}

void main() {
  var insertVersionDataToRecents = _InsertVersionDataToRecents();

  setUp(() {
    registerFallbackValue(getFakeVersionData());
    when(() => insertVersionDataToRecents(versionData: any(named: "versionData")))
        .thenAnswer((_) => SynchronousFuture(const Ok(42)));
  });

  test('When OnVersionLoaded is received, the middleware should call the usecase to insert the version in recents list',
      () async {
    when(() => insertVersionDataToRecents(versionData: any(named: "versionData")))
        .thenAnswer((_) => SynchronousFuture(const Ok(42)));
    var middleware = SongbookMiddleware(insertVersionDataToRecents);
    var versionData = getFakeVersionData();
    middleware.onAction(OnVersionLoaded(versionData), const VersionState(), (_) => null);
    verify(() => insertVersionDataToRecents(versionData: versionData)).called(1);
  });
}
