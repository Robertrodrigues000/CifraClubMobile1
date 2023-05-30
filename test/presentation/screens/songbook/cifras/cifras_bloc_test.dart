import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

void main() {
  test("When call 'getCifras' show emit list of cifras", () async {
    final bloc = CifrasBloc();

    await bloc.getSongbook(getFakeSongbook());

    expect(bloc.state.cifras, isNotNull);
  });
}
