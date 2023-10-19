import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveVersionsInListDialog extends StatelessWidget {
  final int totalSongs;
  final int count;

  const SaveVersionsInListDialog({super.key, required this.totalSongs, required this.count});

  // coverage:ignore-start
  static Future<T?> show<T>({
    required BuildContext context,
    required int totalSongs,
    required AddVersionsToListBloc bloc,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<AddVersionsToListBloc, AddVersionsToListState>(
            builder: (context, state) {
              return SaveVersionsInListDialog(
                count: state.savedSongsCount,
                totalSongs: totalSongs,
              );
            },
          ),
        );
      },
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();

    //Prevent keyboard open after close this dialog
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: context.colors.neutralSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              context.text.savingToList,
              style: context.typography.title6,
            ),
          ),
          Divider(height: 1, color: context.colors.neutralTertiary),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
            child: Text(context.text.loadingSongs, style: context.typography.body10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                minHeight: 4,
                value: count / totalSongs,
                color: context.colors.primary,
                backgroundColor: context.colors.neutralTertiary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${((count / totalSongs) * 100).round()}%", style: context.typography.body6),
                Text("$count/$totalSongs", style: context.typography.body6),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
