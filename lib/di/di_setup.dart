// coverage:ignore-file
import 'dart:async';

import 'package:cifraclub/di/di_setup.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
FutureOr<void> configureDependencies() => $initGetIt(getIt);
