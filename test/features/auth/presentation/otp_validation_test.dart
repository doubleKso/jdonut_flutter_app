import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/flows.dart';
import '../../../support/test_app.dart';

void main() {
  Future<void> openOtp(WidgetTester tester) async {
    await tester.tapText("LET'S GET STARTED");
    await tester.enterField(const Key('phone-field'), newUserPhone);
    await tester.tapText('CONTINUE');
    await tester.waitForFakeCall();
  }

  Future<void> enterWrongCode(WidgetTester tester) async {
    await tester.enterText(find.byKey(const Key('otp-field')), '111111');
    await tester.waitForFakeCall();
  }

  String otpFieldText(WidgetTester tester) =>
      tester.widget<TextField>(find.byKey(const Key('otp-field'))).controller!.text;

  testApp('shows where the code went and counts down from 5:00', (tester, _) async {
    await openOtp(tester);

    expect(find.text("We've sent 6 digit OTP to +959254135592"), findsOneWidget);
    expect(find.textContaining('5:00', findRichText: true), findsOneWidget);
    expect(find.text('Resend code'), findsNothing);
  });

  testApp('a wrong code clears the boxes and says how many tries are left', (tester, _) async {
    await openOtp(tester);

    await enterWrongCode(tester);

    expect(find.text('That code is incorrect. 2 tries left.'), findsOneWidget);
    expect(otpFieldText(tester), isEmpty);
  });

  testApp('three wrong codes lock entry until a new code is requested', (tester, _) async {
    await openOtp(tester);

    for (var attempt = 0; attempt < 3; attempt++) {
      await enterWrongCode(tester);
    }

    expect(find.textContaining('Too many wrong codes'), findsOneWidget);
    expect(tester.widget<TextField>(find.byKey(const Key('otp-field'))).enabled, isFalse);
  });

  testApp('Resend becomes active at 0:00, then restarts the timer and unlocks', (tester, _) async {
    await openOtp(tester);
    for (var attempt = 0; attempt < 3; attempt++) {
      await enterWrongCode(tester);
    }

    await tester.pump(const Duration(minutes: 5, seconds: 1));
    await tester.pumpAndSettle();
    await tester.tapText('Resend code');
    await tester.waitForFakeCall();

    expect(find.textContaining('5:00', findRichText: true), findsOneWidget);
    expect(find.textContaining('Too many wrong codes'), findsNothing);
    expect(tester.widget<TextField>(find.byKey(const Key('otp-field'))).enabled, isTrue);
  });

  testApp('the right code moves on to the name step', (tester, _) async {
    await openOtp(tester);

    await tester.enterText(find.byKey(const Key('otp-field')), '123456');
    await tester.waitForFakeCall();

    expect(find.text("What's your\nname?"), findsOneWidget);
  });
}
