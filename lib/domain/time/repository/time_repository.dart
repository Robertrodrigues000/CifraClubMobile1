import 'package:typed_result/typed_result.dart';

abstract class TimeRepository {
  Future<Result<DateTime, dynamic>> getCurrentTime();
}
