import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/section_state.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/product_use_cases.dart';

final class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.product = const SectionLoading(),
    this.quantity = AddToCartUseCase.minimumQuantity,
    this.adding = false,
    this.addedCount = 0,
    this.failure,
  });

  final SectionState<Product> product;
  final int quantity;
  final bool adding;

  /// Bumped after each successful add — drives the confirmation.
  final int addedCount;
  final Failure? failure;

  bool get canDecrement => quantity > AddToCartUseCase.minimumQuantity;

  ProductDetailState copyWith({
    SectionState<Product>? product,
    int? quantity,
    bool? adding,
    int? addedCount,
    Failure? failure,
    bool clearFailure = false,
  }) => ProductDetailState(
    product: product ?? this.product,
    quantity: quantity ?? this.quantity,
    adding: adding ?? this.adding,
    addedCount: addedCount ?? this.addedCount,
    failure: clearFailure ? null : failure ?? this.failure,
  );

  @override
  List<Object?> get props => [product, quantity, adding, addedCount, failure];
}

final class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({
    required this._watchProduct,
    required this._addToCart,
    required this.productId,
  }) : super(const ProductDetailState());

  final WatchProductUseCase _watchProduct;
  final AddToCartUseCase _addToCart;
  final String productId;
  StreamSubscription<Product?>? _subscription;

  void start() {
    _subscription ??= _watchProduct(productId).listen(
      (product) => emit(state.copyWith(product: sectionFrom(product))),
      onError: (Object error) => emit(state.copyWith(product: SectionError(CacheFailure('$error')))),
    );
  }

  void increment() => emit(state.copyWith(quantity: state.quantity + 1));

  void decrement() {
    if (state.canDecrement) emit(state.copyWith(quantity: state.quantity - 1));
  }

  Future<void> addToCart() async {
    if (state.adding) return;
    emit(state.copyWith(adding: true, clearFailure: true));
    final result = await _addToCart(AddToCartParams(productId: productId, quantity: state.quantity));
    if (isClosed) return;
    emit(
      result.fold(
        (failure) => state.copyWith(adding: false, failure: failure),
        (_) => state.copyWith(adding: false, addedCount: state.addedCount + 1),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
