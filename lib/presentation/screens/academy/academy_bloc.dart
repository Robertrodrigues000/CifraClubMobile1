import 'package:cifraclub/domain/app/model/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app_or_store.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/academy/academy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademyBloc extends Cubit<AcademyState> {
  AcademyBloc(this._isAppInstalled, this._openAppOrStore) : super(AcademyState());

  final IsAppInstalled _isAppInstalled;
  final OpenAppOrStore _openAppOrStore;

  final instructors = [
    AppWebp.cardViolaoIntermediario,
    AppWebp.cardFingerstyle,
    AppWebp.cardCanto,
    AppWebp.cardViolao,
    AppWebp.cardGuitarra,
    AppWebp.cardTeoriaMusical,
    AppWebp.cardUkulele,
    AppWebp.cardViolaoSertanejo,
    AppWebp.cardTeclado,
    AppWebp.cardBateria,
    AppWebp.cardHarmoniaEPartitura,
    AppWebp.cardGuitarraBlues,
    AppWebp.cardContrabaixo,
  ];

  Future<void> initInstructors() async {
    emit(state.copyWith(instructors: instructors, isAcademyInstalled: await _isAppInstalled(App.academy)));
  }

  Future<void> openAppOrStore() => _openAppOrStore(App.academy);
}
