import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

// coverage:ignore-file
class DevBottomSheetBloc extends Cubit<DevBottomSheetState> {
  final GetGenres _getGenres;

  DevBottomSheetBloc(this._getGenres) : super(DevBottomSheetLoadingState()) {
    init();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    final listGenre = await _getGenres();

    listGenre.when(
      success: (value) {
        emit(DevBottomSheetLoadedState(genres: value.all.map((e) => e.name).toList()));
      },
      failure: (RequestError error) {},
    );
  }
}
