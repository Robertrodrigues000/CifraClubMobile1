import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("When creating an AndroidOsVersion", () {
    test("test equality operator", () {
      const osVersion1 = AndroidOsSdkVersion("30");
      const osVersion2 = AndroidOsSdkVersion("30");

      expect(osVersion1 == osVersion2, true);
    });

    test("test inequality operator", () {
      const osVersion1 = AndroidOsSdkVersion("30");
      const osVersion2 = AndroidOsSdkVersion("31");

      expect(osVersion1 != osVersion2, true);
    });

    test("test hashcode", () {
      const osVersion1 = AndroidOsSdkVersion("30");
      const osVersion2 = AndroidOsSdkVersion("30");

      expect(osVersion1.hashCode == osVersion2.hashCode, true);
    });

    test("test greater than operator '>' ", () {
      const osVersion1 = AndroidOsSdkVersion("31");
      const osVersion2 = AndroidOsSdkVersion("30");

      expect(osVersion1 > osVersion2, true);
    });

    test("test greater than or equal operator '>=' ", () {
      const osVersion1 = AndroidOsSdkVersion("30");
      const osVersion2 = AndroidOsSdkVersion("30");
      const osVersion3 = AndroidOsSdkVersion("31");

      expect(osVersion1 >= osVersion2, true);
      expect(osVersion1 >= osVersion3, false);
      expect(osVersion3 >= osVersion1, true);
    });

    test("test less than operator '<' ", () {
      const osVersion1 = AndroidOsSdkVersion("30");
      const osVersion2 = AndroidOsSdkVersion("31");

      expect(osVersion1 < osVersion2, true);
    });

    test("test less than or equal operator '<=' ", () {
      const osVersion1 = AndroidOsSdkVersion("30");
      const osVersion2 = AndroidOsSdkVersion("30");
      const osVersion3 = AndroidOsSdkVersion("31");

      expect(osVersion1 <= osVersion2, true);
      expect(osVersion1 <= osVersion3, true);
      expect(osVersion3 <= osVersion1, false);
    });
  });

  group("When creating an IosOsVersion", () {
    test("test equality operator", () {
      const osVersion1 = IosOsVersion("10.0");
      const osVersion2 = IosOsVersion("10.0");

      expect(osVersion1 == osVersion2, true);
    });

    test("test inequality operator", () {
      const osVersion1 = IosOsVersion("10.0");
      const osVersion2 = IosOsVersion("10.1");

      expect(osVersion1 != osVersion2, true);
    });

    test("test hashcode", () {
      const osVersion1 = IosOsVersion("10.0");
      const osVersion2 = IosOsVersion("10.0");

      expect(osVersion1.hashCode == osVersion2.hashCode, true);
    });

    group("test greater than operator ", () {
      test("when both have 3 digits", () {
        const osVersion1 = IosOsVersion("9.3.6");
        const osVersion2 = IosOsVersion("9.3.5");

        expect(osVersion1 > osVersion2, true);
      });

      test("when first has 3 digits and second has 2 digits", () {
        const osVersion1 = IosOsVersion("9.3.6");
        const osVersion2 = IosOsVersion("9.3");

        expect(osVersion1 > osVersion2, true);
      });

      test("when both have 1 digit", () {
        const osVersion1 = IosOsVersion("10.0");
        const osVersion2 = IosOsVersion("9.0");

        expect(osVersion1 > osVersion2, true);
      });

      test("when second has more digits", () {
        const osVersion1 = IosOsVersion("9.4");
        const osVersion2 = IosOsVersion("9.4.3");

        expect(osVersion1 > osVersion2, false);
      });
    });

    group("test greater than or equal operator ", () {
      test("when they are equals", () {
        const osVersion1 = IosOsVersion("9.3.6");
        const osVersion2 = IosOsVersion("9.3.6");

        expect(osVersion1 >= osVersion2, true);
      });

      test("when first is greater", () {
        const osVersion1 = IosOsVersion("9.3.6");
        const osVersion2 = IosOsVersion("9.3.5");

        expect(osVersion1 >= osVersion2, true);
      });
    });

    group("test less than operator '<' ", () {
      test("when both have 3 digits", () {
        const osVersion1 = IosOsVersion("9.3.5");
        const osVersion2 = IosOsVersion("9.3.6");

        expect(osVersion1 < osVersion2, true);
      });

      test("when first has 2 digits and second has 3 digits", () {
        const osVersion1 = IosOsVersion("9.3");
        const osVersion2 = IosOsVersion("9.3.6");

        expect(osVersion1 < osVersion2, true);
      });

      test("when both have 1 digit", () {
        const osVersion1 = IosOsVersion("9.0");
        const osVersion2 = IosOsVersion("10.0");

        expect(osVersion1 < osVersion2, true);
      });

      test("when second has more digits", () {
        const osVersion1 = IosOsVersion("9.4");
        const osVersion2 = IosOsVersion("9.4.3");

        expect(osVersion1 < osVersion2, true);
      });
    });

    group("test less than or equal operator '<=' ", () {
      test("when they are equals", () {
        const osVersion1 = IosOsVersion("9.3.5");
        const osVersion2 = IosOsVersion("9.3.5");

        expect(osVersion1 <= osVersion2, true);
      });

      test("when first is less", () {
        const osVersion1 = IosOsVersion("9.3.5");
        const osVersion2 = IosOsVersion("9.3.6");

        expect(osVersion1 <= osVersion2, true);
      });
    });
  });
}
