// ignore_for_file: unused_local_variable, unnecessary_parenthesis

import 'package:injectable/injectable.dart';

@injectable
class GetAutoScrollStream {
  final _autoScrollMinSpeed = 10;
  final _autoScrollMaxSpeed = 80;
  final _autoScrollPeriod = 20;

  const GetAutoScrollStream();

  Stream<double> call({required double speedFactor, required double screenDensity}) async* {
    final dpiPerSecond = _autoScrollMinSpeed + (_autoScrollMaxSpeed - _autoScrollMinSpeed) * speedFactor;
    final autoScrollJump = dpiPerSecond * (screenDensity);

    while (true) {
      await Future.delayed(Duration(milliseconds: _autoScrollPeriod));
      yield 1.5; // Todo debugar no nativo
    }
  }
}
