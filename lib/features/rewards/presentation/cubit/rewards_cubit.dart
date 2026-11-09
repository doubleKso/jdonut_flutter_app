import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/section_state.dart';
import '../../../member/domain/entities/member.dart';
import '../../../member/domain/usecases/watch_member_use_case.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/usecases/watch_challenges_use_case.dart';

final class RewardsState extends Equatable {
  const RewardsState({
    this.member = const SectionLoading(),
    this.tab = RewardsTab.earn,
    this.challenges = const SectionLoading(),
  });

  final SectionState<Member> member;
  final RewardsTab tab;
  final SectionState<List<Challenge>> challenges;

  RewardsState copyWith({
    SectionState<Member>? member,
    RewardsTab? tab,
    SectionState<List<Challenge>>? challenges,
  }) => RewardsState(
    member: member ?? this.member,
    tab: tab ?? this.tab,
    challenges: challenges ?? this.challenges,
  );

  @override
  List<Object?> get props => [member, tab, challenges];
}

/// Reads the same member record as Home, plus the selected tab's challenges.
final class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit({required this._watchMember, required this._watchChallenges}) : super(const RewardsState());

  final WatchMemberUseCase _watchMember;
  final WatchChallengesUseCase _watchChallenges;
  StreamSubscription<Member?>? _member;
  StreamSubscription<List<Challenge>>? _challenges;

  void start() {
    _member ??= _watchMember(const NoParams()).listen(
      (member) => emit(state.copyWith(member: sectionFrom(member))),
      onError: (Object e) => emit(state.copyWith(member: SectionError(CacheFailure('$e')))),
    );
    _listenChallenges();
  }

  void selectTab(RewardsTab tab) {
    if (tab == state.tab) return;
    emit(state.copyWith(tab: tab, challenges: const SectionLoading()));
    _listenChallenges();
  }

  void _listenChallenges() {
    unawaited(_challenges?.cancel());
    _challenges = _watchChallenges(state.tab).listen(
      (list) => emit(state.copyWith(challenges: sectionFrom(list))),
      onError: (Object e) => emit(state.copyWith(challenges: SectionError(CacheFailure('$e')))),
    );
  }

  @override
  Future<void> close() async {
    // Cancel both before awaiting either, so no stream stays live while the
    // first cancel completes.
    await Future.wait([?_member?.cancel(), ?_challenges?.cancel()]);
    return super.close();
  }
}
