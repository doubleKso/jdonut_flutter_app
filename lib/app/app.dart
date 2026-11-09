import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import '../core/config/app_config.dart';
import '../core/connectivity/connectivity_cubit.dart';
import '../core/images/app_image.dart';
import '../features/auth/presentation/cubit/session_cubit.dart';
import '../l10n/l10n.dart';
import 'router/app_router.dart';

/// The root widget.
class JDonutsApp extends StatelessWidget {
  const JDonutsApp({required this.getIt, super.key});

  final GetIt getIt;

  /// Text grows with the system setting up to this factor; the layouts are
  /// verified to that size on 4.7" to 6.9" phones.
  static const double maxTextScale = 1.3;

  @override
  Widget build(BuildContext context) {
    final config = getIt<AppConfig>();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ConnectivityCubit>()),
        BlocProvider.value(value: getIt<SessionCubit>()),
      ],
      child: AppImageSettings(
        enableNetwork: config.enableNetworkImages,
        cacheManager: config.enableNetworkImages ? getIt<BaseCacheManager>() : null,
        child: MaterialApp.router(
          onGenerateTitle: (context) => context.l10n.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: getIt<AppRouter>().router,
          builder: (context, child) {
            final media = MediaQuery.of(context);
            return MediaQuery(
              data: media.copyWith(textScaler: media.textScaler.clamp(maxScaleFactor: maxTextScale)),
              child: child ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
