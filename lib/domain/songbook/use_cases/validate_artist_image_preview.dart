// coverage:ignore-file
import 'package:cifraclub/domain/remote_config/use_cases/get_artist_image_path.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_image_prefix_url.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidateArtistImagePreview {
  final GetImagePrefixUrl _getImagePrefixUrl;
  final GetArtistImagePathUrl _getArtistImagePathUrl;
  ValidateArtistImagePreview(this._getImagePrefixUrl, this._getArtistImagePathUrl);

  List<String> call(List<String?> preview) {
    final imagePrefixUrl = _getImagePrefixUrl();
    final artistImagePath = _getArtistImagePathUrl();
    final path = "$imagePrefixUrl$artistImagePath";
    return preview.map((e) => "${(e?.contains(path) ?? true) ? "" : path}${e ?? ""}").toList();
  }
}
