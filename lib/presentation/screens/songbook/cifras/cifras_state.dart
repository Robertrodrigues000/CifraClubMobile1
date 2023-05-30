import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'cifras_state.g.dart';

@CopyWith()
class CifrasState {
  final List<Cifra> cifras;
  final bool isPublic;

  const CifrasState({
    this.cifras = const [],
    required this.isPublic,
  });
}
