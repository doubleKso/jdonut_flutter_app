import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../core/database/app_database.dart';

/// The member record and the challenges are private, local-only data,
/// seeded once from the bundled member.json.
final class MemberSeed {
  const MemberSeed({required this.member, required this.challenges});

  final MembersCompanion member;
  final List<ChallengesCompanion> challenges;
}

final class MemberLocalDataSource {
  const MemberLocalDataSource(this._db);

  static const String seedAssetPath = 'assets/seed/member.json';
  static const String memberId = 'me';

  final AppDatabase _db;

  Stream<MemberRow?> watchMember() =>
      (_db.select(_db.members)..where((m) => m.id.equals(memberId))).watchSingleOrNull();

  Future<void> rename(String displayName) =>
      (_db.update(_db.members)..where((m) => m.id.equals(memberId)))
          .write(MembersCompanion(name: Value(displayName)));

  Future<void> writeSeed(MemberSeed seed) => _db.batch((batch) {
    batch
      ..insertAllOnConflictUpdate(_db.members, [seed.member])
      ..insertAllOnConflictUpdate(_db.challenges, seed.challenges);
  });

  static Future<MemberSeed> loadSeed(AssetBundle bundle) async {
    final json = jsonDecode(await bundle.loadString(seedAssetPath, cache: false)) as Map<String, dynamic>;
    final challenges = (json['challenges'] as List<dynamic>).cast<Map<String, dynamic>>();
    return MemberSeed(
      member: _member(json['member'] as Map<String, dynamic>),
      challenges: challenges.map(_challenge).toList(growable: false),
    );
  }

  static MembersCompanion _member(Map<String, dynamic> m) => MembersCompanion.insert(
    id: m['id'] as String,
    name: m['name'] as String,
    tier: m['tier'] as String,
    nextTier: Value(m['nextTier'] as String?),
    photoAsset: Value(m['photoAsset'] as String? ?? ''),
    photoUrl: Value(m['photoUrl'] as String? ?? ''),
    pointsToNextTier: Value((m['pointsToNextTier'] as num).toInt()),
    totalPoints: Value((m['totalPoints'] as num).toInt()),
    tierProgress: Value((m['tierProgress'] as num).toDouble()),
    notificationCount: Value((m['notificationCount'] as num).toInt()),
    rewardsCount: Value((m['rewardsCount'] as num).toInt()),
  );

  static ChallengesCompanion _challenge(Map<String, dynamic> c) => ChallengesCompanion.insert(
    id: c['id'] as String,
    title: c['title'] as String,
    artKind: c['artKind'] as String,
    tab: c['tab'] as String,
    progress: (c['progress'] as num).toInt(),
    target: (c['target'] as num).toInt(),
    rewardPoints: (c['rewardPoints'] as num).toInt(),
    imageAsset: Value(c['imageAsset'] as String? ?? ''),
    sortOrder: Value((c['sortOrder'] as num?)?.toInt() ?? 0),
  );
}
