import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/search/models/shazam_item.dart';
import 'package:cifraclub/domain/search/repository/shazam_repository.dart';
import 'package:flutter/services.dart';
import 'package:shazam/pigeon.g.dart';
import 'package:typed_result/typed_result.dart';

class ShazamRepositoryImpl extends ShazamRepository {
  final ShazamHostApi _shazamHostApi;

  ShazamRepositoryImpl(this._shazamHostApi);

  @override
  Future<Result<ShazamItem, String>> searchAudio(String token) async {
    try {
      final shazamResult = await _shazamHostApi.search(token);

      if (shazamResult.error != null || shazamResult.result == null) {
        logger?.sendNonFatalCrash(exception: shazamResult.error ?? "Result not found");
        return Err(shazamResult.error!);
      }

      final result = shazamResult.result!;
      return Ok(ShazamItem(result.artistName, result.songName, result.image));
    } on PlatformException catch (e) {
      logger?.sendNonFatalCrash(exception: e.message); // coverage:ignore-line
      return Err(e.message ?? "");
    } catch (e, s) {
      logger?.sendNonFatalCrash(exception: e, stack: s); // coverage:ignore-line
      return Err(e.toString());
    }
  }

  Future<void> cancelSearch() async {
    await _shazamHostApi.cancelSearch();
  }
}
