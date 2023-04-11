import 'package:copy_with_extension/copy_with_extension.dart';

part 'academy_state.g.dart';

@CopyWith()
class AcademyState {
  final List<String> instructors;
  final bool isAcademyInstalled;

  AcademyState({this.isAcademyInstalled = false, this.instructors = const []});
}
