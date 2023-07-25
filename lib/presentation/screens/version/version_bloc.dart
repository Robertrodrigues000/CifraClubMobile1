import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class VersionBloc extends Cubit<VersionState> {
  final String? artistUrl;
  final String? songUrl;
  final int? songbookVersionId;
  final GetVersionData _getVersionData;

  VersionBloc(
    this._getVersionData, {
    this.artistUrl,
    this.songUrl,
    this.songbookVersionId,
  }) : super(const VersionState());

  Future<void> init() async {
    emit(const VersionState(isLoading: true));

    if (artistUrl != null && songUrl != null) {
      final result = await _getVersionData(artistDns: artistUrl!, songDns: songUrl!);

      result.when(
        success: (value) => emit(state.copyWith(isLoading: false, version: value)),
        failure: (error) {
          emit(state.copyWith(isLoading: false, error: error));
        },
      );
    }
  }
}
