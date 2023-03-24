import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart';
import 'package:typed_result/typed_result.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherRepositoryImpl extends UrlLauncherRepository {
  @override
  Future<Result<void, Exception>> handleUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return Err(Exception('Could not launch $uri'));
    } else {
      return const Ok(null);
    }
  }
}
