enum OperatingSystem {
  android("Android"),
  ios("iOS"),
  windows("Windows"),
  linux("Linux"),
  macos("MacOS"),
  web("Web"),
  fuchsia("Fuchsia"),
  unknown("Unknown");

  final String name;

  const OperatingSystem(this.name);

  // coverage:ignore-start
  @override
  String toString() {
    return name;
  }
  // coverage:ignore-end
}
