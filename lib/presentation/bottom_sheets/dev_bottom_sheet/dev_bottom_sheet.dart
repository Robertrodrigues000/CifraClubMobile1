import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/dev_bottom_sheet/dev_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// coverage:ignore-file
class DevBottomSheet {
  final GetGenres _getGenres;

  DevBottomSheet(this._getGenres);

  Future<String?> open(BuildContext context) {
    return _showDevBottomSheet(context, DevBottomSheetBloc(_getGenres));
  }

  Future<String?> _showDevBottomSheet(
    BuildContext context,
    DevBottomSheetBloc bloc,
  ) {
    final scrollController = ScrollController();
    return DefaultBottomSheet.showBottomSheet(
      child: BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<DevBottomSheetBloc, DevBottomSheetState>(builder: (context, state) {
          if (state is DevBottomSheetLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DevBottomSheetLoadedState) {
            return ListView.builder(
              controller: scrollController,
              itemCount: state.genres.length,
              itemBuilder: (context, index) => ListTile(
                title: ListTile(
                  title: Text("Genre ${state.genres[index]}"),
                  onTap: () => Navigator.of(context).pop<String>(state.genres[index]),
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
      context: context,
      scrollController: scrollController,
      heightMaxFactor: .75,
    );
  }
}
