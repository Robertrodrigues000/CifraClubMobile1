// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class RemoteImageCacheManager extends InheritedWidget {
  const RemoteImageCacheManager({
    super.key,
    required this.cacheManager,
    required super.child,
  });

  final CacheManager cacheManager;

  static RemoteImageCacheManager? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RemoteImageCacheManager>();
  }

  static RemoteImageCacheManager of(BuildContext context) {
    final RemoteImageCacheManager? result = maybeOf(context);
    assert(result != null, 'No CacheManager found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(RemoteImageCacheManager oldWidget) => false;
}
