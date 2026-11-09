import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/features/rewards/presentation/pages/rewards_page.dart';

import '../support/flows.dart';
import '../support/test_app.dart';

/// The brief asks for layouts that hold from 4.7" to 6.9" phones with the
/// text scaled to 1.3. Any overflow fails the test on its own, so walking
/// every screen at both extremes is the check.
void main() {
  const screens = {
    '4.7-inch (360 × 640)': Size(360, 640),
    '6.9-inch (440 × 956)': Size(440, 956),
  };
  const largeText = 1.3;

  for (final MapEntry(key: name, value: size) in screens.entries) {
    testApp('every screen lays out on a $name phone at text scale $largeText', (tester, _) async {
      await registerAndOpenProduct(tester);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await tester.tap(find.bySemanticsLabel('Reward'));
      await tester.pumpAndSettle();
      expect(find.text('680,000'), findsOneWidget);

      // On the small phone the tabs start below the fold.
      await tester.scrollUntilVisible(
        find.text('Gift'),
        AppSpacing.huge,
        scrollable: find.descendant(of: find.byType(RewardsPage), matching: find.byType(Scrollable)).first,
      );
      await tester.tapText('Gift');
      expect(find.text('Gift'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Settings'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('logout-row')), findsOneWidget);
    }, size: size, textScale: largeText);
  }
}
