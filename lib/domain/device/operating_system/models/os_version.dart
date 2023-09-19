import 'package:cifraclub/di/inherited_widget_dependencies.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OsVersion {
  final String version;

  const OsVersion({
    required this.version,
  });

  bool operator >(OsVersion other);

  bool operator <(OsVersion other);

  bool operator >=(OsVersion other);

  bool operator <=(OsVersion other);

  @override
  bool operator ==(Object other) {
    if (other is OsVersion) {
      return version == other.version;
    }
    return false;
  }

  @override
  int get hashCode => version.hashCode;

  // coverage:ignore-start
  static OsVersion of(BuildContext context) => InheritedDependenciesWidget.of(context).osVersion;

  @override
  String toString() {
    return version;
  }
  // coverage:ignore-end
}

class AndroidOsSdkVersion extends OsVersion {
  const AndroidOsSdkVersion(String version) : super(version: version);

  // coverage:ignore-start
  const AndroidOsSdkVersion.sdk21() : this('21');
  const AndroidOsSdkVersion.sdk22() : this('22');
  const AndroidOsSdkVersion.sdk23() : this('23');
  const AndroidOsSdkVersion.sdk24() : this('24');
  const AndroidOsSdkVersion.sdk25() : this('25');
  const AndroidOsSdkVersion.sdk26() : this('26');
  const AndroidOsSdkVersion.sdk27() : this('27');
  const AndroidOsSdkVersion.sdk28() : this('28');
  const AndroidOsSdkVersion.sdk29() : this('29');
  const AndroidOsSdkVersion.sdk30() : this('30');
  const AndroidOsSdkVersion.sdk31() : this('31');
  const AndroidOsSdkVersion.sdk32() : this('32');
  const AndroidOsSdkVersion.sdk33() : this('33');
  // coverage:ignore-end

  @override
  bool operator <(OsVersion other) {
    return int.parse(version) < int.parse(other.version);
  }

  @override
  bool operator <=(OsVersion other) {
    return int.parse(version) <= int.parse(other.version);
  }

  @override
  bool operator >(OsVersion other) {
    return int.parse(version) > int.parse(other.version);
  }

  @override
  bool operator >=(OsVersion other) {
    return int.parse(version) >= int.parse(other.version);
  }
}

class IosOsVersion extends OsVersion {
  const IosOsVersion(String version) : super(version: version);

  @override
  bool operator <(OsVersion other) {
    if (this == other) {
      return false;
    }
    if (version.length > other.version.length && version.startsWith(other.version)) {
      return false;
    }
    if (version.length < other.version.length && other.version.startsWith(version)) {
      return true;
    }

    final thisSplit = version.split('.');
    final otherSplit = other.version.split('.');

    for (var i = 0; i < thisSplit.length; i++) {
      final thisInt = int.parse(thisSplit[i]);
      final otherInt = int.parse(otherSplit[i]);

      if (thisInt < otherInt) {
        return true;
      } else if (thisInt > otherInt) {
        return false;
      }
      // If it is the same, then continue
    }
    // All comparisons were equals, so we return false
    return false;
  }

  @override
  bool operator <=(OsVersion other) {
    if (this == other || this < other) {
      return true;
    }
    return false;
  }

  @override
  bool operator >(OsVersion other) {
    if (this == other || this < other) {
      return false;
    }
    return true;
  }

  @override
  bool operator >=(OsVersion other) {
    if (this == other || this > other) {
      return true;
    }
    return false;
  }
}
