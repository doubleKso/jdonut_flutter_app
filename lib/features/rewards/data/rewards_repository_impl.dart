import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/image_ref.dart';
import '../domain/entities/challenge.dart';
import '../domain/repositories/rewards_repository.dart';

/// Challenges are local-only data, seeded with the member record.
final class RewardsRepositoryImpl implements RewardsRepository {
  const RewardsRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Challenge>> watchChallenges(RewardsTab tab) {
    final query = _db.select(_db.challenges)
      ..where((c) => c.tab.equals(tab.name))
      ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]);
    return query.watch().map((rows) => rows.map(_toChallenge).toList(growable: false));
  }

  Challenge _toChallenge(ChallengeRow row) => Challenge(
    id: row.id,
    title: row.title,
    art: ChallengeArt.fromKey(row.artKind),
    tab: RewardsTab.fromKey(row.tab),
    progress: row.progress,
    target: row.target,
    rewardPoints: row.rewardPoints,
    image: ImageRef(asset: row.imageAsset),
  );
}
