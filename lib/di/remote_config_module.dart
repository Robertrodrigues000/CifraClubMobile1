// coverage:ignore-file
import 'package:cifraclub/data/remote_config/remote_config_registered_parameters.dart';
import 'package:cifraclub/data/remote_config/remote_config_repository_impl.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RemoteConfigModule {
  @singleton
  RemoteConfigRepository getRemoteConfigRepository(FirebaseApp firebaseApp) {
    return RemoteConfigRepositoryImpl(
      remoteConfig: FirebaseRemoteConfig.instance,
      remoteConfigParameters: RemoteConfigRegisteredParameters(),
    )..fetch();
  }
}
