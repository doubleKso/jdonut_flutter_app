import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/core/widgets/primary_button.dart';
import 'package:jdonuts/features/auth/data/fake_auth_repository.dart';

import 'test_app.dart';

const String newUserPhone = '09254135592';

/// Whether the CONTINUE button currently accepts taps.
bool continueEnabled(WidgetTester tester) =>
    tester.widget<PrimaryButton>(find.widgetWithText(PrimaryButton, 'CONTINUE')).onPressed != null;

/// Onboarding → Let's get started → phone → OTP (verified).
Future<void> registerThroughOtp(WidgetTester tester, {String phone = newUserPhone}) async {
  await tester.tapText("LET'S GET STARTED");
  await tester.enterField(const Key('phone-field'), phone);
  await tester.tapText('CONTINUE');
  await tester.waitForFakeCall();
  await tester.enterText(find.byKey(const Key('otp-field')), FakeAuthRepository.acceptedOtp);
  await tester.waitForFakeCall();
}

/// … → name → date of birth → Welcome.
Future<void> finishRegistration(WidgetTester tester) async {
  expect(find.text("What's your\nname?"), findsOneWidget);
  await tester.enterField(const Key('first-name-field'), 'Ye Min');
  await tester.enterField(const Key('last-name-field'), 'Phyoe Win');
  expect(continueEnabled(tester), isTrue, reason: 'a valid name enables Continue');
  await tester.tapText('CONTINUE');
  await tester.waitForFakeCall();

  expect(find.text("What's your\ndate of birth?"), findsOneWidget);
  await tester.tap(find.byKey(const Key('month-field')));
  await tester.pumpAndSettle();
  // On a small phone with large text the sheet shows only the first months.
  await tester.scrollUntilVisible(
    find.text('May'),
    AppSpacing.huge,
    scrollable: find.descendant(of: find.byType(BottomSheet), matching: find.byType(Scrollable)),
  );
  await tester.tapText('May');
  await tester.enterField(const Key('day-field'), '1');
  await tester.enterField(const Key('year-field'), '1980');
  expect(continueEnabled(tester), isTrue, reason: 'a valid date enables Continue');
  await tester.tapText('CONTINUE');
  await tester.waitForFakeCall();
}

/// The integration flow: Register → Welcome → Home → Product detail.
Future<void> registerAndOpenProduct(WidgetTester tester) async {
  await registerThroughOtp(tester);
  await finishRegistration(tester);
  expect(find.text("Welcome to the\nworld of J'donuts"), findsOneWidget);

  await tester.tapText("LET'S EXPLORE");
  expect(find.text('Ye Min Phyoe Win'), findsOneWidget, reason: 'Home reads the renamed member record');

  await tester.tapText('Coconut Donut');
  expect(find.text('JD022123'), findsOneWidget);
  expect(find.text('3,200 MMK'), findsWidgets);
  expect(find.text('New'), findsOneWidget);

  await tester.tap(find.bySemanticsLabel('Add one'));
  await tester.pumpAndSettle();
  expect(find.text('6,400 MMK'), findsOneWidget, reason: 'Add to cart shows quantity × price');
}
