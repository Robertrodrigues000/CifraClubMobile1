// coverage:ignore-file
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListsBloc extends Cubit<ListsState> {
  ListsBloc() : super(ListsState());

  void getLists() {
    final userlists = List.generate(10, (index) => "UserList $index");
    final specialLists = List.generate(4, (index) => "SpecialList $index");

    emit(
      state.copyWith(
        userLists: userlists,
        specialLists: specialLists,
      ),
    );
  }
}
