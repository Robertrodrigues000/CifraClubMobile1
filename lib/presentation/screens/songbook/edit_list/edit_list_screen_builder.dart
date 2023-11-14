import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_event.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// coverage:ignore-file
class EditListScreenBuilder {
  Future<EditListEvent?> push(BuildContext context, String name, int songbookId) async {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider<EditListBloc>(
            create: (context) => EditListBloc(songbookId, getIt(), getIt(), getIt(), getIt())..init(),
            child: EditListScreen(name: name),
          );
        },
      ),
    );
  }
}
