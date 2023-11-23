import 'package:cifraclub/domain/shared/use_cases/validate_email.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("When call use case", () {
    test("and is valid email should return true", () {
      final useCase = ValidateEmail()("teste@gmail.com");

      expect(useCase, isTrue);
    });

    test("and contains spaces should return false", () {
      final useCase = ValidateEmail()("test e@gmail.com");

      expect(useCase, isFalse);
    });

    test("and missing '@' symbol should return false", () {
      final useCase = ValidateEmail()("testegmail.com");

      expect(useCase, isFalse);
    });

    test("and ends with a dot should return false", () {
      final useCase = ValidateEmail()("test@gmail.");

      expect(useCase, isFalse);
    });
  });
}
