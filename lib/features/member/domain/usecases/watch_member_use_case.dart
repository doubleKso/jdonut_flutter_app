import 'package:app_core/app_core.dart';

import '../entities/member.dart';
import '../repositories/member_repository.dart';

final class WatchMemberUseCase implements StreamUseCase<Member?, NoParams> {
  const WatchMemberUseCase(this._repository);

  final MemberRepository _repository;

  @override
  Stream<Member?> call(NoParams params) => _repository.watchMember();
}
