import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

/// Title, fields and a bottom button. Fills the screen when there is room
/// and scrolls when there is not (small phones, keyboard up, large text).
class StepLayout extends StatelessWidget {
  const StepLayout({required this.title, required this.children, required this.button, super.key});

  final String title;
  final List<Widget> children;
  final Widget button;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              Text(title, style: context.text.displaySmall),
              const SizedBox(height: AppSpacing.xxl),
              ...children,
              const Spacer(),
              const SizedBox(height: AppSpacing.xxl),
              button,
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    ],
  );
}
