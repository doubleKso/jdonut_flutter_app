import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/auth/data/fake_auth_repository.dart';

import '../support/flows.dart';
import '../support/test_app.dart';

void main() {
  testApp('Register → Welcome → Home → Product detail', (tester, _) async {
    await registerAndOpenProduct(tester);
  });

  testApp('log out returns to onboarding; logging back in skips registration', (tester, _) async {
    await registerThroughOtp(tester);
    await finishRegistration(tester);
    await tester.tapText("LET'S EXPLORE");

    await tester.tap(find.bySemanticsLabel('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logout-row')));
    await tester.pumpAndSettle();
    expect(find.text("LET'S GET STARTED"), findsOneWidget);

    await tester.tapText('Log In');
    await tester.enterField(const Key('phone-field'), newUserPhone);
    await tester.tapText('CONTINUE');
    await tester.waitForFakeCall();
    await tester.enterText(find.byKey(const Key('otp-field')), FakeAuthRepository.acceptedOtp);
    await tester.waitForFakeCall();

    expect(find.text('Ye Min Phyoe Win'), findsOneWidget, reason: 'straight from OTP to Home');
  });

  testApp('Rewards reads the same member record as Home', (tester, _) async {
    await registerThroughOtp(tester);
    await finishRegistration(tester);
    await tester.tapText("LET'S EXPLORE");
    expect(find.text('500 points left to become Gold Member'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Reward'));
    await tester.pumpAndSettle();

    expect(find.text('500 pts Remaining\nto become Gold'), findsOneWidget);
    expect(find.text('680,000'), findsOneWidget);
    expect(find.text('Eat 4 Coco donuts'), findsNWidgets(2));
  });
}
