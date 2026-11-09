import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/flows.dart';
import '../../../support/test_app.dart';

void main() {
  Future<void> openLogInPhone(WidgetTester tester) => tester.tapText('Log In');

  testApp('Continue stays disabled until the number is valid', (tester, _) async {
    await openLogInPhone(tester);

    await tester.enterField(const Key('phone-field'), '0925413');
    expect(continueEnabled(tester), isFalse);

    await tester.enterField(const Key('phone-field'), '09 254-135 592');
    expect(continueEnabled(tester), isTrue);
  });

  testApp('the phone error appears only once the field loses focus', (tester, _) async {
    await openLogInPhone(tester);

    await tester.enterField(const Key('phone-field'), '0812');
    expect(find.textContaining('Enter a valid Myanmar mobile number'), findsNothing);

    await tester.unfocus();
    expect(find.textContaining('Enter a valid Myanmar mobile number'), findsOneWidget);
  });

  testApp('a number that never registered gets an inline message with a link to register', (tester, _) async {
    await openLogInPhone(tester);

    await tester.enterField(const Key('phone-field'), newUserPhone);
    await tester.tapText('CONTINUE');
    await tester.waitForFakeCall();

    expect(find.textContaining("This number isn't registered yet."), findsOneWidget);
    await tester.tapText('Register now');
    expect(find.text('Enter your phone\nnumber'), findsOneWidget);
    expect(find.text(newUserPhone), findsOneWidget, reason: 'the typed number carries over');
  });

  testApp('the back arrow returns to the previous step and keeps the number', (tester, _) async {
    await registerThroughOtp(tester);
    expect(find.text("What's your\nname?"), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Enter your phone\nnumber'), findsOneWidget);
    expect(find.text(newUserPhone), findsOneWidget);
  });
}
