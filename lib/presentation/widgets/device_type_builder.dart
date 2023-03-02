// coverage:ignore-file
import 'package:flutter/material.dart';

class DeviceTypeBuilder extends StatelessWidget {
  const DeviceTypeBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  @override
  Widget build(BuildContext context) => builder(
        context,
        getDeviceType(context),
      );
}

enum DeviceType { phone, tablet }

DeviceType getDeviceType(context) {
  final data = MediaQuery.of(context);
  return data.size.shortestSide > 550 ? DeviceType.tablet : DeviceType.phone;
}
