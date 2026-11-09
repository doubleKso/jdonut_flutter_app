import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/section_state.dart';
import '../../../member/domain/entities/member.dart';
import '../../../member/domain/usecases/watch_member_use_case.dart';
import '../../domain/entities/home_entities.dart';
import '../../domain/usecases/home_use_cases.dart';

enum HomePart { member, banners, sections, shops }

final class HomeState extends Equatable {
  const HomeState({
    this.member = const SectionLoading(),
    this.banners = const SectionLoading(),
    this.sections = const SectionLoading(),
    this.shops = const SectionLoading(),
    this.refreshing = false,
    this.refreshFailures = 0,
  });

  final SectionState<Member> member;
  final SectionState<List<HomeBanner>> banners;
  final SectionState<List<HomeSection>> sections;
  final SectionState<List<Shop>> shops;
  final bool refreshing;

  /// Bumped when a pull-to-refresh fails, so the page can say so once.
  final int refreshFailures;

  HomeState copyWith({
    SectionState<Member>? member,
    SectionState<List<HomeBanner>>? banners,
    SectionState<List<HomeSection>>? sections,
    SectionState<List<Shop>>? shops,
    bool? refreshing,
    int? refreshFailures,
  }) => HomeState(
    member: member ?? this.member,
    banners: banners ?? this.banners,
    sections: sections ?? this.sections,
    shops: shops ?? this.shops,
    refreshing: refreshing ?? this.refreshing,
    refreshFailures: refreshFailures ?? this.refreshFailures,
  );

  @override
  List<Object?> get props => [member, banners, sections, shops, refreshing, refreshFailures];
}

/// Watches each Home part separately, so each has its own loading, empty
/// and error state, and a broken part never blanks the others.
final class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this._watchMember,
    required this._watchBanners,
    required this._watchSections,
    required this._watchShops,
    required this._refreshCatalog,
  }) : super(const HomeState());

  final WatchMemberUseCase _watchMember;
  final WatchBannersUseCase _watchBanners;
  final WatchSectionsUseCase _watchSections;
  final WatchShopsUseCase _watchShops;
  final RefreshCatalogUseCase _refreshCatalog;
  final Map<HomePart, StreamSubscription<Object?>> _subscriptions = {};

  void start() => HomePart.values.forEach(retry);

  /// (Re)subscribes one part — the "Try again" of its error state.
  void retry(HomePart part) {
    unawaited(_subscriptions.remove(part)?.cancel());
    _subscriptions[part] = switch (part) {
      HomePart.member => _listen<Member>(_watchMember(const NoParams()), (s) => state.copyWith(member: s)),
      HomePart.banners => _listen<List<HomeBanner>>(
        _watchBanners(const NoParams()),
        (s) => state.copyWith(banners: s),
      ),
      HomePart.sections => _listen<List<HomeSection>>(
        _watchSections(const NoParams()),
        (s) => state.copyWith(sections: s),
      ),
      HomePart.shops => _listen<List<Shop>>(_watchShops(const NoParams()), (s) => state.copyWith(shops: s)),
    };
  }

  StreamSubscription<T?> _listen<T>(Stream<T?> stream, HomeState Function(SectionState<T>) update) =>
      stream.listen(
        (value) => emit(update(sectionFrom<T>(value))),
        onError: (Object error) => emit(update(SectionError<T>(CacheFailure('$error')))),
      );

  /// Pull-to-refresh. The new data arrives through the watches.
  Future<void> refresh() async {
    emit(state.copyWith(refreshing: true));
    final result = await _refreshCatalog(const NoParams());
    if (isClosed) return;
    emit(
      state.copyWith(
        refreshing: false,
        refreshFailures: result.isFailure ? state.refreshFailures + 1 : state.refreshFailures,
      ),
    );
  }

  @override
  Future<void> close() async {
    await Future.wait(_subscriptions.values.map((s) => s.cancel()));
    return super.close();
  }
}
