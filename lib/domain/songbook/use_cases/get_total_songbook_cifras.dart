// coverage:ignore-file
import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTotalSongbookCifras {
  final UserCifraRepository _userCifraRepository;

  GetTotalSongbookCifras(this._userCifraRepository);

  Stream<int?> call(int songbookId) {
    return _userCifraRepository.getTotalSongbookCifras(songbookId);
  }
}
