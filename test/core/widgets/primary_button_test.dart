import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/core/widgets/pressable_scale.dart';
import 'package:jdonuts/core/widgets/primary_button.dart';

void main() {
  testWidgets(
    'loading morphs between a full-width button and a finite circle',
    (tester) async {
      var loading = false;
      late StateSetter setState;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 320,
                child: StatefulBuilder(
                  builder: (context, update) {
                    setState = update;
                    return PrimaryButton(
                      label: 'ADD TO CART',
                      trailing: '6,400 MMK',
                      loading: loading,
                      onPressed: () {},
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(PressableScale)).width, 320);

      setState(() => loading = true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);

      // A CircularProgressIndicator animates forever, so advance beyond the
      // morph duration instead of waiting for the whole tree to settle.
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byType(PressableScale)),
        const Size.square(AppSpacing.buttonHeight),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      setState(() => loading = false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);

      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(PressableScale)).width, 320);
    },
  );
}
