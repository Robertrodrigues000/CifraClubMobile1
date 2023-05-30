import 'dart:math';

import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CifrasBloc extends Cubit<CifrasState> {
  CifrasBloc() : super(const CifrasState(isPublic: true));

  Future<void> getSongbook(Songbook? songbook) async {
    emit(
      state.copyWith(
        cifras: List.generate(
          Random().nextInt(30),
          (index) => Cifra(name: "Cifra", id: index),
        ),
        isPublic: songbook?.isPublic,
      ),
    );
  }
}
