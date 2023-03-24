import 'package:typed_result/typed_result.dart';

abstract class UrlLauncherRepository {
  Future<Result<void, Exception>> handleUrl(String url);
}
