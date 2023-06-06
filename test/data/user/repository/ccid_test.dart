import 'dart:convert';

import 'package:cifraclub/data/user/repository/ccid.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/flutter/fake_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("When `init()` is invoked", () {
    test("invoke `initializeCcid`", () async {
      final channel = FakeMethodChannel(answers: {"initializeCcid": true});
      final ccid = Ccid(channel);

      await ccid.init();

      expect(channel.calls.first.method, "initializeCcid");
    });

    test("When there is no logged user, emit a credential with isUserLoggedIn false`", () async {
      final channel = FakeMethodChannel(answers: {"initializeCcid": true});
      final ccid = Ccid(channel);
      await ccid.init();

      expect(
          ccid.credential,
          emitsInOrder([
            equals(const UserCredential(isUserLoggedIn: false)),
          ]));
    });

    test("When there is a logged user, emit a credential with isUserLoggedIn true`", () async {
      final channel = FakeMethodChannel(answers: {
        "initializeCcid": true,
        "isUserLoggedIn": true,
      });
      final ccid = Ccid(channel);
      await ccid.init();

      expect(
          ccid.credential,
          emitsInOrder([
            equals(const UserCredential(isUserLoggedIn: true)),
          ]));
    });
  });

  group("When `updateCredentials()` is invoked", () {
    test("and user is not logged in, return Credentials with isLoggedIn = false", () async {
      final channel = FakeMethodChannel(answers: {"isUserLoggedIn": false});
      final ccid = Ccid(channel)..isInitialized.complete(true);

      await ccid.updateCredentials();

      expect(ccid.credential.value.isUserLoggedIn, false);
    });

    group("and user is  logged in", () {
      test("return Credentials with isLoggedIn = true", () async {
        final channel = FakeMethodChannel(answers: {"isUserLoggedIn": true});
        final ccid = Ccid(channel)..isInitialized.complete(true);

        await ccid.updateCredentials();

        expect(ccid.credential.value.isUserLoggedIn, true);
      });

      test("return User with correct data", () async {
        final data = {
          'userID': 12,
          'name': "Meu nominho",
          'birthdate': "27/08/1542",
          'avatarUrl': "http://avatar.com/fotinha.jpg",
          'coverURL': "http://avatar.com/capinha.jpg",
          'coverPosition': 69,
          'cityID': 13,
          'cityName': "America",
          'countryID': 12,
          'countryName': "Capivara",
          'id': "id:47",
          'stateID': 96,
          'stateInitials': "TO",
          'email': "ny@yhul.com",
          'gender': "nope",
          'passwordDefined': true,
          'verified': true,
          'pendingEmail': "false",
        };

        final channel = FakeMethodChannel(answers: {
          "isUserLoggedIn": true,
          "getToken": "meuJwt",
          "getUserData": jsonEncode(data),
        });
        final ccid = Ccid(channel)..isInitialized.complete(true);

        await ccid.updateCredentials();
        final user = ccid.credential.value.user as User;

        expect(user.name, data["name"]);
        expect(user.email, data["email"]);
        expect(user.avatarUrl, data["avatarUrl"]);
        expect(user.city, data["cityName"]);
        expect(user.country, data["countryName"]);
        expect(user.id, data["userID"]);
      });

      test("return a null user if there is no data available", () async {
        final channel = FakeMethodChannel(answers: {
          "isUserLoggedIn": true,
          "getToken": "meuJwt",
        });
        final ccid = Ccid(channel)..isInitialized.complete(true);

        await ccid.updateCredentials();
        expect(ccid.credential.value.user, null);
      });
    });
  });

  test("when `logout` is invoked, invokeMethod `logout`", () async {
    final channel = FakeMethodChannel();
    final ccid = Ccid(channel)..isInitialized.complete(true);

    await ccid.logout();

    expect(channel.calls.first.method, "logout");
  });

  test("when `resendEmail` is invoked, invokeMethod `resendEmail`", () async {
    final channel = FakeMethodChannel();
    final ccid = Ccid(channel)..isInitialized.complete(true);

    await ccid.resendEmail();

    expect(channel.calls.first.method, "resendEmail");
  });

  test("when `addRegId` is invoked, send token using `addRegId` method", () async {
    final channel = FakeMethodChannel();
    final ccid = Ccid(channel)..isInitialized.complete(true);

    await ccid.addRegId("maitouquem");

    expect(channel.calls.first.method, "addRegId");
    expect(channel.calls.first.arguments, {"token": "maitouquem"});
  });

  test("when `isUserLoggedIn` is invoked, return `isUserLoggedIn` result", () async {
    final channel = FakeMethodChannel(answers: {"isUserLoggedIn": true});
    final ccid = Ccid(channel)..isInitialized.complete(true);

    final result = await ccid.isUserLoggedIn();

    expect(channel.calls.first.method, "isUserLoggedIn");
    expect(result, isTrue);
  });

  group("when `openUserProfilePage` is invoked", () {
    test("invoke method `openLoginView` if user is  logged in", () async {
      final channel = FakeMethodChannel(answers: {"isUserLoggedIn": true});
      final ccid = Ccid(channel)..isInitialized.complete(true);

      await ccid.openUserProfilePage();

      expect(channel.calls.last.method, "openLoginView");
    });

    test("do not invoke method `openLoginView` if user is  logged in", () async {
      final channel = FakeMethodChannel(answers: {"isUserLoggedIn": false});
      final ccid = Ccid(channel)..isInitialized.complete(true);

      await ccid.openUserProfilePage();

      expect(channel.calls.last.method, isNot("openLoginView"));
    });
  });

  group("when `openLoginView` is invoked", () {
    test("invoke method `openLoginView` if user is not logged in", () async {
      final channel = FakeMethodChannel(answers: {"isUserLoggedIn": false});
      final ccid = Ccid(channel)..isInitialized.complete(true);

      await ccid.openLoginView();

      expect(channel.calls.last.method, "openLoginView");
    });

    test("do not invoke method `openLoginView` if user is logged in", () async {
      final channel = FakeMethodChannel(answers: {"isUserLoggedIn": true});
      final ccid = Ccid(channel)..isInitialized.complete(true);

      await ccid.openLoginView();

      expect(channel.calls.last.method, isNot("openLoginView"));
    });
  });

  group("update credentials when CCID plugin calls", () {
    Future<bool> wasCredentialsUpdatedWhenInvokedMethod(String method) async {
      final channel = FakeMethodChannel(answers: {"isUserLoggedIn": true, 'initializeCcid': true});
      final ccid = Ccid(channel);
      await ccid.init();
      await channel.handler!.call(MethodCall(method));
      return ccid.credential.value.isUserLoggedIn;
    }

    test(
        "onLoginComplete", () async => expect(await wasCredentialsUpdatedWhenInvokedMethod("onLoginComplete"), isTrue));
    test("onSilentLogoutComplete",
        () async => expect(await wasCredentialsUpdatedWhenInvokedMethod("onSilentLogoutComplete"), isTrue));
    test("onLogoutComplete",
        () async => expect(await wasCredentialsUpdatedWhenInvokedMethod("onLogoutComplete"), isTrue));
    test("onUserDataChanged",
        () async => expect(await wasCredentialsUpdatedWhenInvokedMethod("onUserDataChanged"), isTrue));
  });
}
