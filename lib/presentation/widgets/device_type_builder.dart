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

enum DeviceType { smallPhone, phone, tablet }

DeviceType getDeviceType(context) {
  final data = MediaQuery.of(context);

  if (data.size.shortestSide < 360) {
    return DeviceType.smallPhone;
  } else if (data.size.shortestSide < 576) {
    return DeviceType.phone;
  }
  return DeviceType.tablet;
}
