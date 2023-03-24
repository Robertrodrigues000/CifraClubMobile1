// coverage:ignore-file
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class OpenUrl {
  final UrlLauncherRepository urlLauncherRepository;

  OpenUrl({
    required this.urlLauncherRepository,
  });

  Future<Result<void, Exception>> call(String uri) {
    return urlLauncherRepository.handleUrl(uri);
  }
}
