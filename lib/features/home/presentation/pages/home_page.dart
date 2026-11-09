import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../../../../l10n/l10n.dart';
import '../cubit/home_cubit.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/member_header.dart';
import '../widgets/product_sections.dart';
import '../widgets/shops_section.dart';

/// Screen 8. Everything on it is read from the local database; pull down to
/// refresh it from the server.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Room left at the bottom for the floating nav bar.
  static const double navClearance = 96;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) => previous.refreshFailures != current.refreshFailures,
      listener: (context, _) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.refreshFailed))),
      child: Scaffold(
        backgroundColor: context.palette.mist,
        body: RefreshIndicator(
          onRefresh: cubit.refresh,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) => CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _HeaderArea(state: state, cubit: cubit)),
                SliverToBoxAdapter(
                  child: ProductSections(
                    state: state.sections,
                    onRetry: () => cubit.retry(HomePart.sections),
                    firstIndex: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: StaggeredEntrance(
                    index: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xxxl),
                      child: ShopsSection(state: state.shops, onRetry: () => cubit.retry(HomePart.shops)),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: navClearance)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The peach header: member details over the top half of the carousel.
class _HeaderArea extends StatelessWidget {
  const _HeaderArea({required this.state, required this.cubit});

  final HomeState state;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    final peach = context.palette.peach;
    return Column(
      children: [
        ColoredBox(
          color: peach,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                const OfflineBanner(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
                  child: MemberHeader(state: state.member, onRetry: () => cubit.retry(HomePart.member)),
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: BannerCarousel.height / 2,
              child: ColoredBox(color: peach),
            ),
            BannerCarousel(state: state.banners, onRetry: () => cubit.retry(HomePart.banners)),
          ],
        ),
      ],
    );
  }
}
