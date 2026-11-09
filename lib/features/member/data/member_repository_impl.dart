import 'package:app_core/app_core.dart';

import '../../../core/data/image_url_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/domain/image_ref.dart';
import '../domain/entities/member.dart';
import '../domain/repositories/member_repository.dart';
import 'member_local_data_source.dart';

final class MemberRepositoryImpl implements MemberRepository {
  const MemberRepositoryImpl(this._local, this._urls);

  final MemberLocalDataSource _local;
  final ImageUrlResolver _urls;

  @override
  Stream<Member?> watchMember() =>
      _local.watchMember().map((row) => row == null ? null : _toMember(row));

  @override
  Future<Result<void>> rename(String displayName) async {
    try {
      await _local.rename(displayName);
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(CacheFailure('Could not rename the member: $e'));
    }
  }

  Member _toMember(MemberRow row) => Member(
    id: row.id,
    name: row.name,
    photo: ImageRef(url: _urls.resolve(row.photoUrl), asset: row.photoAsset),
    tier: MemberTier.fromKey(row.tier),
    nextTier: row.nextTier == null ? null : MemberTier.fromKey(row.nextTier!),
    pointsToNextTier: row.pointsToNextTier,
    totalPoints: row.totalPoints,
    tierProgress: row.tierProgress.clamp(0, 1).toDouble(),
    notificationCount: row.notificationCount,
    rewardsCount: row.rewardsCount,
  );
}
