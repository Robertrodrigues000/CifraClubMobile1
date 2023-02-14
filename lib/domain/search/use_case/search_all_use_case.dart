// coverage:ignore-file
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/search/models/search.dart';
import 'package:cifraclub/domain/search/repository/search_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class SearchAll {
  final SearchRepository searchRepository;

  SearchAll({
    required this.searchRepository,
  });

  Future<Result<List<Search>, RequestError>> call({required String query}) {
    return searchRepository.getAll(query: query);
  }
}
