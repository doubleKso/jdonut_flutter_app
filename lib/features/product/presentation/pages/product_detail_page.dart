import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/formatting/mmk_format.dart';
import '../../../../core/images/app_image.dart';
import '../../../../core/presentation/section_state.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/section_message.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_detail_cubit.dart';
import '../widgets/quantity_stepper.dart';

/// Screen 9: product code, name, price, New badge, image, description,
/// quantity, and Add to cart with the live total.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.heroTag, super.key});

  final String heroTag;

  @override
  Widget build(BuildContext context) => BlocListener<ProductDetailCubit, ProductDetailState>(
    listenWhen: (previous, current) =>
        previous.addedCount != current.addedCount || (current.failure != null && previous.failure == null),
    listener: _confirm,
    child: Scaffold(
      backgroundColor: context.palette.mist,
      body: SafeArea(
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OfflineBanner(),
              IconButton(
                tooltip: context.l10n.back,
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_rounded, color: context.palette.ink),
              ),
              Expanded(child: _body(context, state)),
            ],
          ),
        ),
      ),
    ),
  );

  void _confirm(BuildContext context, ProductDetailState state) {
    final product = state.product;
    final l10n = context.l10n;
    final message = state.failure != null
        ? l10n.cartFailed
        : l10n.addedToCart(state.quantity, product is SectionLoaded<Product> ? product.data.name : '');
    if (state.failure == null) HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _body(BuildContext context, ProductDetailState state) => switch (state.product) {
    SectionLoaded(:final data) => _ProductContent(product: data, state: state, heroTag: heroTag),
    SectionLoading() => const Padding(
      padding: EdgeInsets.all(AppSpacing.gutter),
      child: SkeletonBox(height: 360, radius: AppRadii.xl),
    ),
    SectionEmpty() => Center(child: Text(context.l10n.productNotFound, style: context.text.bodyLarge)),
    SectionError() => SectionMessage.error(onRetry: context.read<ProductDetailCubit>().start),
  };
}

class _ProductContent extends StatelessWidget {
  const _ProductContent({required this.product, required this.state, required this.heroTag});

  final Product product;
  final ProductDetailState state;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailCubit>();
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
            children: [
              _ProductCard(product: product, heroTag: heroTag, stepper: _stepper(cubit)),
              const SizedBox(height: AppSpacing.xxl),
              _Description(text: product.description),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: PrimaryButton(
            label: context.l10n.addToCart,
            trailing: formatMmk(product.totalFor(state.quantity)),
            loading: state.adding,
            onPressed: cubit.addToCart,
          ),
        ),
      ],
    );
  }

  Widget _stepper(ProductDetailCubit cubit) => QuantityStepper(
    quantity: state.quantity,
    onIncrement: cubit.increment,
    onDecrement: state.canDecrement ? cubit.decrement : null,
  );
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.heroTag, required this.stepper});

  final Product product;
  final String heroTag;
  final Widget stepper;

  static const double _imageHeight = 220;
  static const double _stepperOverlap = 22;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: _stepperOverlap),
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.huge),
          decoration: BoxDecoration(color: palette.surface, borderRadius: AppRadii.card),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardHeading(product: product),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: _imageHeight,
                width: double.infinity,
                child: Hero(tag: heroTag, child: AppImage(product.image, semanticLabel: product.name)),
              ),
            ],
          ),
        ),
        stepper,
      ],
    );
  }
}

class _CardHeading extends StatelessWidget {
  const _CardHeading({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.code, style: context.text.bodySmall?.copyWith(color: palette.fog)),
              Text(product.name, style: context.text.headlineSmall),
              const SizedBox(height: AppSpacing.xxs),
              Text(formatMmk(product.priceMmk), style: context.text.labelMedium),
            ],
          ),
        ),
        if (product.isNew)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
            decoration: BoxDecoration(color: palette.tangerine, borderRadius: AppRadii.field),
            child: Text(context.l10n.newBadge, style: context.text.bodySmall?.copyWith(color: palette.onAccent)),
          ),
      ],
    );
  }
}

/// "What's this?" and the description beside it.
class _Description extends StatelessWidget {
  const _Description({required this.text});

  final String text;

  static const double _iconSize = 16;
  static const double _labelWidth = 64;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _labelWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: _iconSize / 2,
                  backgroundColor: palette.leaf,
                  child: Icon(Icons.question_mark_rounded, size: _iconSize - AppSpacing.xs, color: palette.onAccent),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(context.l10n.whatsThis, style: context.text.labelMedium),
              ],
            ),
          ),
          VerticalDivider(color: palette.fog, width: AppSpacing.lg),
          Expanded(child: Text(text, style: context.text.bodyMedium?.copyWith(color: palette.slate))),
        ],
      ),
    );
  }
}
