import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/flows.dart';
import '../../../support/test_app.dart';

void main() {
  group('name step', () {
    testApp('a first name is required before Continue works', (tester, _) async {
      await registerThroughOtp(tester);

      expect(continueEnabled(tester), isFalse);
      await tester.enterField(const Key('first-name-field'), 'Ye Min');
      expect(continueEnabled(tester), isTrue);
    });

    testApp('digits in a name show an inline message and disable Continue', (tester, _) async {
      await registerThroughOtp(tester);

      await tester.enterField(const Key('first-name-field'), 'Ye Min 2');

      expect(find.text("Names can't include numbers"), findsOneWidget);
      expect(continueEnabled(tester), isFalse);
    });

    testApp('a Myanmar-script name with no last name is accepted', (tester, _) async {
      await registerThroughOtp(tester);

      await tester.enterField(const Key('first-name-field'), 'ရဲမင်း');

      expect(continueEnabled(tester), isTrue);
    });
  });

  group('date-of-birth step', () {
    Future<void> openDateOfBirth(WidgetTester tester) async {
      await registerThroughOtp(tester);
      await tester.enterField(const Key('first-name-field'), 'Ye Min');
      await tester.tapText('CONTINUE');
      await tester.waitForFakeCall();
    }

    Future<void> enterDate(WidgetTester tester, String month, String day, String year) async {
      await tester.tap(find.byKey(const Key('month-field')));
      await tester.pumpAndSettle();
      await tester.tapText(month);
      await tester.enterField(const Key('day-field'), day);
      await tester.enterField(const Key('year-field'), year);
    }

    testApp('31 April is rejected as a date that does not exist', (tester, _) async {
      await openDateOfBirth(tester);

      await enterDate(tester, 'April', '31', '1990');

      expect(find.text("That date doesn't exist"), findsOneWidget);
      expect(continueEnabled(tester), isFalse);
    });

    testApp('someone under 13 is told the minimum age', (tester, _) async {
      await openDateOfBirth(tester);

      await enterDate(tester, 'January', '1', '${DateTime.now().year - 5}');

      expect(find.text('You need to be at least 13 to join'), findsOneWidget);
      expect(continueEnabled(tester), isFalse);
    });

    testApp('a real adult birthday enables Continue and the ring becomes a check', (tester, _) async {
      await openDateOfBirth(tester);

      await enterDate(tester, 'May', '1', '1980');

      expect(continueEnabled(tester), isTrue);
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });
  });
}
