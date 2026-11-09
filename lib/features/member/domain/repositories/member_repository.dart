import 'package:app_core/app_core.dart';

import '../entities/member.dart';

abstract interface class MemberRepository {
  /// The member record, or null before it has been seeded.
  Stream<Member?> watchMember();

  /// Puts the signed-in person's name on the member record.
  Future<Result<void>> rename(String displayName);
}
