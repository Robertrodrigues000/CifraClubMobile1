import 'dart:math';

import 'package:cifraclub/di/isar_module.dart';
import 'package:isar/isar.dart';

class IsarTestModule {
  static Future<void> initializeCore() => Isar.initializeIsarCore(download: true);

  static String getRandomName() {
    var random = Random().nextInt(pow(2, 32) as int).toString();
    return '${random}_tmp';
  }

  static Future<Isar> getIsar() async {
    return Isar.open(
      directory: ".",
      isarAppSchemas,
      name: getRandomName(),
      inspector: false,
    );
  }
}
