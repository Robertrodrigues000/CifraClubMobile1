import 'dart:async';
import 'dart:convert';
import 'package:cifraclub/data/user/models/user_data_dto.dart';
import 'package:cifraclub/domain/user/repository/authentication_repository.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mutex/mutex.dart';
import 'package:rxdart/rxdart.dart';

class Ccid implements AuthenticationRepository {
  final MethodChannel channel;
  final Mutex mutex = Mutex();
  @visibleForTesting
  final isInitialized = Completer<bool>();

  static const MethodChannel ccidChannel = MethodChannel('com.studiosol.flutter/login_ccid');

  Ccid(this.channel);

  @override
  Future<bool> init() async {
    assert(!isInitialized.isCompleted, "init must be called only once");
    channel.setMethodCallHandler(_handleMethod);
    isInitialized.complete(await channel.invokeMethod('initializeCcid'));
    await updateCredentials();
    return isInitialized.future;
  }

  // ignore_for_file: close_sinks
  // ignoring rule because Ccid is a singleton
  @override
  BehaviorSubject<UserCredential> credential = BehaviorSubject<UserCredential>();

  Future<void> updateCredentials() async {
    final isUserLoggedIn = await this.isUserLoggedIn();
    final jwt = await getJwt();
    final User? user;
    if (isUserLoggedIn) {
      user = await _getUser();
    } else {
      user = null;
    }

    final currentCredential = UserCredential(
      isUserLoggedIn: isUserLoggedIn,
      user: user,
      jwt: jwt,
    );

    if (currentCredential == credential.valueOrNull) {
      return;
    }
    credential.add(currentCredential);
  }

  Future<T?> invokeMethodSerialized<T>(String method, [dynamic args]) async {
    final initialized = await isInitialized.future;
    assert(initialized);
    if (initialized) {
      T? result;
      await mutex.acquire();
      try {
        result = await channel.invokeMethod(method, args);
      } finally {
        mutex.release();
      }
      return result;
    }
    return null;
  }

  @override
  Future<void> logout() {
    return invokeMethodSerialized('logout');
  }

  Future<bool> isUserLoggedIn() async {
    return await invokeMethodSerialized('isUserLoggedIn') == true;
  }

  @override
  Future<void> openUserProfilePage() async {
    if (await isUserLoggedIn()) {
      return invokeMethodSerialized('openLoginView'); // because this is how CCID works 🤡
    }
  }

  @override
  Future<void> openLoginView() async {
    if (!(await isUserLoggedIn())) {
      return invokeMethodSerialized('openLoginView');
    }
  }

  Future<User?> _getUser() async {
    String? data;
    data = await invokeMethodSerialized('getUserData');

    if (data != null) {
      final userData = UserDataDto.fromJson(json.decode(data));
      return User(
        name: userData.name,
        email: userData.email,
        avatarUrl: userData.avatarURL,
        city: userData.cityName,
        country: userData.countryName,
        id: userData.userID,
        stateInitials: userData.stateInitials,
        state: _getStateFromInitials(userData.stateInitials),
      );
    } else {
      return null;
    }
  }

  Future<String?> getJwt() {
    return invokeMethodSerialized('getToken');
  }

  Future<void> resendEmail() {
    return invokeMethodSerialized('resendEmail');
  }

  @override
  Future<void> addRegId(String token) {
    return invokeMethodSerialized('addRegId', {"token": token});
  }

  Future<dynamic> _handleMethod(MethodCall call) {
    switch (call.method) {
      case "onLoginComplete":
      case "onSilentLogoutComplete":
      case "onLogoutComplete":
      case "onUserDataChanged":
        return updateCredentials();
    }
    return SynchronousFuture(null);
  }
}

String? _getStateFromInitials(String? initials) {
  switch (initials) {
    case "AC":
      return "Acre";
    case "AL":
      return "Alagoas";
    case "AP":
      return "Amapá";
    case "AM":
      return "Amazonas";
    case "BA":
      return "Bahia";
    case "CE":
      return "Ceará";
    case "DF":
      return "Distrito Federal";
    case "ES":
      return "Espírito Santo";
    case "GO":
      return "Goiás";
    case "MA":
      return "Maranhão";
    case "MT":
      return "Mato Grosso";
    case "MS":
      return "Mato Grosso do Sul";
    case "MG":
      return "Minas Gerais";
    case "PA":
      return "Pará";
    case "PB":
      return "Paraíba";
    case "PR":
      return "Paraná";
    case "PE":
      return "Pernambuco";
    case "PI":
      return "Piauí";
    case "RR":
      return "Roraima";
    case "RO":
      return "Rondônia";
    case "RJ":
      return "Rio de Janeiro";
    case "RN":
      return "Rio Grande do Norte";
    case "RS":
      return "Rio Grande do Sul";
    case "SC":
      return "Santa Catarina";
    case "SP":
      return "São Paulo";
    case "SE":
      return "Sergipe";
    case "TO":
      return "Tocantins";
  }
  return null;
}
