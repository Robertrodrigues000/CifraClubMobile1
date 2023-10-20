import 'package:injectable/injectable.dart';

@injectable
class GetAutoScrollStream {
  final _autoScrollMinSpeed = 0.6;
  final _autoScrollMaxSpeed = 6;
  final _autoScrollPeriod = 100;

  const GetAutoScrollStream();

  Stream<double> call({required double speedFactor, required double screenDensity}) async* {
    final dpiPerSecond = _autoScrollMinSpeed + (_autoScrollMaxSpeed - _autoScrollMinSpeed) * speedFactor;
    final autoScrollJump = dpiPerSecond * screenDensity;

    while (true) {
      yield autoScrollJump; // Todo debugar no nativo
      await Future.delayed(Duration(milliseconds: _autoScrollPeriod));
      //yield 1.5; // Todo debugar no nativo
    }
  }
}
