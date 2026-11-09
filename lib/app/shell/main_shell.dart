import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/l10n.dart';
import 'app_bottom_nav.dart';

/// The five tabs. Home, Reward and Settings work; Menu and Wallet are
/// placeholders.
final List<NavDestination> mainDestinations = [
  NavDestination(label: (l) => l.navHome, icon: (c) => Icon(Icons.home_outlined, color: c)),
  NavDestination(label: (l) => l.navReward, icon: (c) => CrownIcon(color: c)),
  NavDestination(label: (l) => l.navMenu, icon: (c) => Icon(Icons.donut_large_outlined, color: c)),
  NavDestination(label: (l) => l.navWallet, icon: (c) => Icon(Icons.account_balance_wallet_outlined, color: c)),
  NavDestination(label: (l) => l.navSettings, icon: (c) => Icon(Icons.settings_outlined, color: c)),
];

/// Hosts the tab branches (each keeps its own state) under the bottom nav.
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    body: navigationShell,
    bottomNavigationBar: AppBottomNav(
      destinations: mainDestinations,
      currentIndex: navigationShell.currentIndex,
      onSelected: (index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
    ),
  );
}

/// What Menu and Wallet show for now.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({required this.title, required this.icon, super.key});

  final String Function(AppLocalizations) title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final name = title(context.l10n);
    return Scaffold(
      backgroundColor: context.palette.mist,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: AppSpacing.huge, color: context.palette.sky),
              const SizedBox(height: AppSpacing.md),
              Text(name, style: context.text.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(context.l10n.placeholderBody(name), style: context.text.bodyLarge, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
