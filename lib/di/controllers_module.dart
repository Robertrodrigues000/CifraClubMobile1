import 'package:cifraclub/presentation/widgets/color_approximator.dart';
import 'package:injectable/injectable.dart';

// coverage:ignore-file
@module
abstract class ControllersModule {
  @singleton
  ColorApproximator getColorApproximator() => ColorApproximator.getDefaultImplementation();
}
