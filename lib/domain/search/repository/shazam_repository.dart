import 'package:cifraclub/domain/search/models/shazam_item.dart';
import 'package:typed_result/typed_result.dart';

abstract class ShazamRepository {
  Future<Result<ShazamItem, String>> searchAudio(String token);
}
