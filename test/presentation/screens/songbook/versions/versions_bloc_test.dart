import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

void main() {
  test("When call 'getSongbook' show emit list of versions", () async {
    final bloc = VersionsBloc();

    await bloc.getSongbook(getFakeSongbook());

    expect(bloc.state.versions, isNotNull);
  });
}
