// Imports the Flutter Driver API.
// this test contains the test suite, which drives the app and verifies that it works as expected

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';
import 'package:frontend/screens/login.dart';

void main() {
  group('Butterfly App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final lottieFinder = find.byValueKey('lottie');
    final buttonsControllerFinder = find.byValueKey('buttonsController');
    final emailLoginFinder = find.byValueKey('Email');
    final passwordLoginFinder = find.byValueKey('Password');
    final loginButtonFinder = find.byValueKey('Login');
    final createAccountFinder = find.byValueKey('Create New Account');

    late FlutterDriver driver;

    var login = Login();

    // Connect to the Flutter driver before running any tests waiting for main().
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      var connected = false;
      while (!connected) {
        try {
          await driver.waitUntilFirstFrameRasterized();
          connected = true;
        } catch (error) {}
      }
      return driver;
    });

    // Close the connection to the driver after the tests have completed.
    // tearDownAll(() async {
    //   await driver.close();
    //   print('driver closing..');
    // });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    // test('Test butterfly lottie animation', () async {
    //   await driver.runUnsynchronized(() async {
    //     // Verify lottie fades in.
    //     print("before lottie");
    //     await driver.waitFor(lottieFinder);
    //     print("lottie testing");
    //   });
    // });

    // test('start buttonsControllerFinder', () async {
    //   await driver.runUnsynchronized(() async {
    //     // Verify buttonsControllerFinder fades in.
    //     expect(await driver.getText(buttonsControllerFinder), "1");
    //   });
    // });

    // test('Logging in with email LoginFinder ', () async {
    //   // Use the `driver.getText` method to verify the counter starts at 0.
    //   expect(await driver.login());
    // });

    // test('passwordLoginFinder', () async {
    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(passwordLoginFinder), "1");
    // });

    //     test('loginButton tapped', () async {
    //   // First, tap the button.
    //   await driver.tap(loginButtonFinder);

    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(loginButtonFinder), "1");
    // });

    //     test('createAccount tapped', () async {
    //   // First, tap the button.
    //   await driver.tap(createAccountFinder);

    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(createAccountFinder), "1");
    // });
  });
}
