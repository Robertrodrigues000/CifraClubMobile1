import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// coverage:ignore-file
class EditListScreenBuilder {
  Future<List<Version>?> push(BuildContext context, List<Version> versions, String name, int songbookId) async {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
            create: (context) => EditListBloc(initialState: EditListState.fromSongbook(versions, songbookId)),
            child: EditListScreen(name: name),
          );
        },
      ),
    );
  }
}
