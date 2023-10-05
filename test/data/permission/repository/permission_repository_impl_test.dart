import 'package:cifraclub/data/permission/models/app_permission_status.dart';
import 'package:cifraclub/data/permission/repository/permission_repository_impl.dart';
import 'package:cifraclub/domain/device/operating_system/models/os_version.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;

class _OsVersionMock extends Mock implements OsVersion {}

void main() {
  testWidgets("When request audio on ios should return permission status", (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final repository = PermissionRepositoryImpl(_OsVersionMock());
    _setupPermissions(
        {permission_handler.Permission.mediaLibrary.value: permission_handler.PermissionStatus.granted.index}, tester);

    final result = await repository.requestPermission(PermissionType.audio);

    expect(result, AppPermissionStatus.granted);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("When request audio android with sdk < 33 should return permission status", (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    final repository = PermissionRepositoryImpl(const AndroidOsSdkVersion.sdk28());
    _setupPermissions(
        {permission_handler.Permission.storage.value: permission_handler.PermissionStatus.granted.index}, tester);

    final result = await repository.requestPermission(PermissionType.audio);

    expect(result, AppPermissionStatus.granted);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("When request audio android with sdk >= 33 should return permission status", (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    final repository = PermissionRepositoryImpl(const AndroidOsSdkVersion.sdk33());
    _setupPermissions(
        {permission_handler.Permission.audio.value: permission_handler.PermissionStatus.granted.index}, tester);

    final result = await repository.requestPermission(PermissionType.audio);

    expect(result, AppPermissionStatus.granted);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("When request microphone should return permission status", (tester) async {
    final repository = PermissionRepositoryImpl(const AndroidOsSdkVersion.sdk33());
    _setupPermissions(
        {permission_handler.Permission.microphone.value: permission_handler.PermissionStatus.granted.index}, tester);

    final result = await repository.requestPermission(PermissionType.microphone);

    expect(result, AppPermissionStatus.granted);
  });

  testWidgets("When openAppSettings is called, invoke plugin's method", (tester) async {
    final repository = PermissionRepositoryImpl(_OsVersionMock());
    final invokedMethods = _setupPermissions({}, tester);

    await repository.openAppSettings();

    expect(invokedMethods.length, 1);
    expect(invokedMethods.first, 'openAppSettings');
  });
}

List<String> _setupPermissions(Map<int, int> permissions, WidgetTester tester) {
  final List<String> invokedMethods = [];
  tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
    const MethodChannel('flutter.baseflow.com/permissions/methods'),
    (message) {
      invokedMethods.add(message.method);
      switch (message.method) {
        case 'requestPermissions':
          return SynchronousFuture(permissions);
        case 'checkPermissionStatus':
          for (final MapEntry<int, int> permissionKey in permissions.entries) {
            if (permissionKey.key == message.arguments) {
              return SynchronousFuture(permissionKey.value);
            }
          }
          return SynchronousFuture(null);
        case 'openAppSettings':
          return SynchronousFuture(null);
        default:
          throw UnimplementedError("Method `${message.method}` not implemented");
      }
    },
  );
  return invokedMethods;
}
