import 'package:drift/drift.dart';

/// Catalogue products. Public data: seeded from JSON, refreshed from /v1.
@DataClassName('ProductRow')
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get priceMmk => integer()();
  BoolColumn get isNew => boolean().withDefault(const Constant(false))();
  IntColumn get discountPercent => integer().nullable()();
  TextColumn get imageUrl => text().withDefault(const Constant(''))();
  TextColumn get imageAsset => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Home carousel banners.
@DataClassName('BannerRow')
class Banners extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get badge => text().nullable()();

  /// A palette key ('grape', 'sky', 'tangerine') — never a raw colour.
  TextColumn get themeKey => text().withDefault(const Constant('grape'))();
  TextColumn get imageUrl => text().withDefault(const Constant(''))();
  TextColumn get imageAsset => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Horizontal product lists on Home (Seasonal specials, Popular, Order again).
@DataClassName('HomeSectionRow')
class HomeSections extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();

  /// 'wide', 'tall' or 'compact' tiles.
  TextColumn get layout => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('HomeSectionItemRow')
class HomeSectionItems extends Table {
  TextColumn get sectionId => text()();
  TextColumn get productId => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {sectionId, productId};
}

@DataClassName('ShopRow')
class Shops extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get imageUrl => text().withDefault(const Constant(''))();
  TextColumn get imageAsset => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// The one member record every screen reads.
@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get photoAsset => text().withDefault(const Constant(''))();
  TextColumn get photoUrl => text().withDefault(const Constant(''))();
  TextColumn get tier => text()();
  TextColumn get nextTier => text().nullable()();
  IntColumn get pointsToNextTier => integer().withDefault(const Constant(0))();
  IntColumn get totalPoints => integer().withDefault(const Constant(0))();

  /// 0..1 progress from the current tier to the next.
  RealColumn get tierProgress => real().withDefault(const Constant(0))();
  IntColumn get notificationCount => integer().withDefault(const Constant(0))();
  IntColumn get rewardsCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Rewards challenge cards.
@DataClassName('ChallengeRow')
class Challenges extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();

  /// Which artwork shows the progress: 'donut', 'coffee' or 'gift'.
  TextColumn get artKind => text()();

  /// Which tab lists it: 'earn' or 'gift'.
  TextColumn get tab => text()();
  IntColumn get progress => integer()();
  IntColumn get target => integer()();
  IntColumn get rewardPoints => integer()();
  TextColumn get imageAsset => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Accounts created by the fake auth repository.
@DataClassName('UserRow')
class Users extends Table {
  TextColumn get phone => text()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();

  /// False until the last registration step (date of birth) is saved.
  BoolColumn get isComplete => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {phone};
}

/// Small key-value facts: seed version, last refresh.
@DataClassName('AppMetaRow')
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

/// Added in schema v2: the persistent cart.
@DataClassName('CartItemRow')
class CartItems extends Table {
  TextColumn get productId => text()();
  IntColumn get quantity => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {productId};
}
