import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/entities/auth_entities.dart';
import '../../features/auth/presentation/cubit/auth_flow_cubit.dart';
import '../../features/auth/presentation/cubit/otp_cubit.dart';
import '../../features/auth/presentation/cubit/session_cubit.dart';
import '../../features/auth/presentation/cubit/step_submit_cubit.dart';
import '../../features/auth/presentation/pages/date_of_birth_page.dart';
import '../../features/auth/presentation/pages/name_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/phone_page.dart';
import '../../features/auth/presentation/widgets/auth_flow_shell.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/welcome_page.dart';
import '../../features/product/presentation/cubit/product_detail_cubit.dart';
import '../../features/product/presentation/pages/product_detail_page.dart';
import '../../features/product/presentation/product_hero.dart';
import '../../features/rewards/presentation/cubit/rewards_cubit.dart';
import '../../features/rewards/presentation/pages/rewards_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../shell/main_shell.dart';
import 'auth_guard.dart';
import 'page_transitions.dart';
import 'route_paths.dart';
import 'stream_listenable.dart';

/// All routes, with the auth redirect guard and `/product/:id`.
final class AppRouter {
  AppRouter({required this._session, required this._getIt});

  final SessionCubit _session;
  final GetIt _getIt;

  late final GoRouter router = GoRouter(
    initialLocation: RoutePaths.home,
    refreshListenable: StreamListenable(_session.stream),
    redirect: (context, state) => authRedirect(signedIn: _session.isSignedIn, location: state.uri.path),
    routes: [
      GoRoute(path: RoutePaths.onboarding, pageBuilder: (_, s) => fadeThroughPage(s, const OnboardingPage())),
      _flowShell(AuthFlow.register, [
        _phoneRoute(RoutePaths.registerPhone),
        _otpRoute(RoutePaths.registerOtp, RoutePaths.registerPhone),
        GoRoute(path: RoutePaths.registerName, pageBuilder: (_, s) => sharedAxisPage(s, _provide<NameStepCubit>(const NamePage()))),
        GoRoute(
          path: RoutePaths.registerDateOfBirth,
          pageBuilder: (_, s) => sharedAxisPage(s, _provide<DateOfBirthStepCubit>(const DateOfBirthPage())),
        ),
      ]),
      _flowShell(AuthFlow.login, [
        _phoneRoute(RoutePaths.loginPhone),
        _otpRoute(RoutePaths.loginOtp, RoutePaths.loginPhone),
      ]),
      GoRoute(path: RoutePaths.welcome, pageBuilder: (_, s) => fadeThroughPage(s, const WelcomePage())),
      GoRoute(path: RoutePaths.productPattern, pageBuilder: _productPage),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => MainShell(navigationShell: shell),
        branches: _tabBranches(),
      ),
    ],
  );

  /// One pass through register or log in: the shell (back button, ring,
  /// terms) stays while the steps inside it slide.
  ShellRoute _flowShell(AuthFlow flow, List<RouteBase> routes) => ShellRoute(
    builder: (context, state, child) => BlocProvider(
      create: (_) => AuthFlowCubit(flow),
      child: AuthFlowShell(step: _stepOf(state.uri.path), totalSteps: flow.totalSteps, child: child),
    ),
    routes: routes,
  );

  static int _stepOf(String location) => switch (location) {
    RoutePaths.registerOtp || RoutePaths.loginOtp => 2,
    RoutePaths.registerName => 3,
    RoutePaths.registerDateOfBirth => 4,
    _ => 1,
  };

  GoRoute _phoneRoute(String path) => GoRoute(
    path: path,
    pageBuilder: (_, s) => sharedAxisPage(
      s,
      _provide<PhoneStepCubit>(PhonePage(initialPhone: s.uri.queryParameters[RoutePaths.phoneQuery] ?? '')),
    ),
  );

  GoRoute _otpRoute(String path, String phonePath) => GoRoute(
    path: path,
    pageBuilder: (_, s) => sharedAxisPage(s, _OtpEntry(getIt: _getIt, phonePath: phonePath)),
  );

  Page<void> _productPage(BuildContext context, GoRouterState state) {
    final id = state.pathParameters['id'] ?? '';
    final heroTag = state.extra is String ? state.extra! as String : productHeroTag(id);
    return riseInPage(
      state,
      BlocProvider(
        create: (_) => _getIt<ProductDetailCubit>(param1: id)..start(),
        child: ProductDetailPage(heroTag: heroTag),
      ),
    );
  }

  List<StatefulShellBranch> _tabBranches() => [
    _branch(RoutePaths.home, BlocProvider(create: (_) => _getIt<HomeCubit>()..start(), child: const HomePage())),
    _branch(RoutePaths.rewards, BlocProvider(create: (_) => _getIt<RewardsCubit>()..start(), child: const RewardsPage())),
    _branch(RoutePaths.menu, PlaceholderPage(title: (l) => l.navMenu, icon: Icons.donut_large_outlined)),
    _branch(RoutePaths.wallet, PlaceholderPage(title: (l) => l.navWallet, icon: Icons.account_balance_wallet_outlined)),
    _branch(RoutePaths.settings, const SettingsPage()),
  ];

  StatefulShellBranch _branch(String path, Widget page) => StatefulShellBranch(
    routes: [GoRoute(path: path, pageBuilder: (_, s) => NoTransitionPage(key: s.pageKey, child: page))],
  );

  Widget _provide<T extends StateStreamableSource<Object?>>(Widget child) =>
      BlocProvider<T>(create: (_) => _getIt<T>(), child: child);
}

/// Opens the OTP step for the number the phone step verified. Reached
/// without one (a deep link), it goes back to the phone step.
class _OtpEntry extends StatelessWidget {
  const _OtpEntry({required this.getIt, required this.phonePath});

  final GetIt getIt;
  final String phonePath;

  @override
  Widget build(BuildContext context) {
    final flow = context.read<AuthFlowCubit>().state;
    final phone = flow.phone;
    if (phone == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.mounted ? context.go(phonePath) : null);
      return const SizedBox.shrink();
    }
    return BlocProvider(
      create: (_) => getIt<OtpCubit>(param1: phone, param2: flow.flow),
      child: const OtpPage(),
    );
  }
}
