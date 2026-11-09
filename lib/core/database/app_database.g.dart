// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMmkMeta = const VerificationMeta(
    'priceMmk',
  );
  @override
  late final GeneratedColumn<int> priceMmk = GeneratedColumn<int>(
    'price_mmk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<int> discountPercent = GeneratedColumn<int>(
    'discount_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    imageAsset,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_mmk')) {
      context.handle(
        _priceMmkMeta,
        priceMmk.isAcceptableOrUnknown(data['price_mmk']!, _priceMmkMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMmkMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceMmk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_mmk'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_percent'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String imageUrl;
  final String imageAsset;
  final String description;
  const ProductRow({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    required this.imageUrl,
    required this.imageAsset,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['price_mmk'] = Variable<int>(priceMmk);
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountPercent != null) {
      map['discount_percent'] = Variable<int>(discountPercent);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['image_asset'] = Variable<String>(imageAsset);
    map['description'] = Variable<String>(description);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      priceMmk: Value(priceMmk),
      isNew: Value(isNew),
      discountPercent: discountPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercent),
      imageUrl: Value(imageUrl),
      imageAsset: Value(imageAsset),
      description: Value(description),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priceMmk: serializer.fromJson<int>(json['priceMmk']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      discountPercent: serializer.fromJson<int?>(json['discountPercent']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      imageAsset: serializer.fromJson<String>(json['imageAsset']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'priceMmk': serializer.toJson<int>(priceMmk),
      'isNew': serializer.toJson<bool>(isNew),
      'discountPercent': serializer.toJson<int?>(discountPercent),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'imageAsset': serializer.toJson<String>(imageAsset),
      'description': serializer.toJson<String>(description),
    };
  }

  ProductRow copyWith({
    String? id,
    String? code,
    String? name,
    int? priceMmk,
    bool? isNew,
    Value<int?> discountPercent = const Value.absent(),
    String? imageUrl,
    String? imageAsset,
    String? description,
  }) => ProductRow(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    priceMmk: priceMmk ?? this.priceMmk,
    isNew: isNew ?? this.isNew,
    discountPercent: discountPercent.present
        ? discountPercent.value
        : this.discountPercent,
    imageUrl: imageUrl ?? this.imageUrl,
    imageAsset: imageAsset ?? this.imageAsset,
    description: description ?? this.description,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priceMmk: data.priceMmk.present ? data.priceMmk.value : this.priceMmk,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    imageAsset,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.priceMmk == this.priceMmk &&
          other.isNew == this.isNew &&
          other.discountPercent == this.discountPercent &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.description == this.description);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> priceMmk;
  final Value<bool> isNew;
  final Value<int?> discountPercent;
  final Value<String> imageUrl;
  final Value<String> imageAsset;
  final Value<String> description;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMmk = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       priceMmk = Value(priceMmk);
  static Insertable<ProductRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priceMmk,
    Expression<bool>? isNew,
    Expression<int>? discountPercent,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priceMmk != null) 'price_mmk': priceMmk,
      if (isNew != null) 'is_new': isNew,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? priceMmk,
    Value<bool>? isNew,
    Value<int?>? discountPercent,
    Value<String>? imageUrl,
    Value<String>? imageAsset,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      priceMmk: priceMmk ?? this.priceMmk,
      isNew: isNew ?? this.isNew,
      discountPercent: discountPercent ?? this.discountPercent,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMmk.present) {
      map['price_mmk'] = Variable<int>(priceMmk.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<int>(discountPercent.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BannersTable extends Banners with TableInfo<$BannersTable, BannerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BannersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _badgeMeta = const VerificationMeta('badge');
  @override
  late final GeneratedColumn<String> badge = GeneratedColumn<String>(
    'badge',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeKeyMeta = const VerificationMeta(
    'themeKey',
  );
  @override
  late final GeneratedColumn<String> themeKey = GeneratedColumn<String>(
    'theme_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('grape'),
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    badge,
    themeKey,
    imageUrl,
    imageAsset,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banners';
  @override
  VerificationContext validateIntegrity(
    Insertable<BannerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('badge')) {
      context.handle(
        _badgeMeta,
        badge.isAcceptableOrUnknown(data['badge']!, _badgeMeta),
      );
    }
    if (data.containsKey('theme_key')) {
      context.handle(
        _themeKeyMeta,
        themeKey.isAcceptableOrUnknown(data['theme_key']!, _themeKeyMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BannerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BannerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      badge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge'],
      ),
      themeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_key'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $BannersTable createAlias(String alias) {
    return $BannersTable(attachedDatabase, alias);
  }
}

class BannerRow extends DataClass implements Insertable<BannerRow> {
  final String id;
  final String title;
  final String? badge;

  /// A palette key ('grape', 'sky', 'tangerine') — never a raw colour.
  final String themeKey;
  final String imageUrl;
  final String imageAsset;
  final int sortOrder;
  const BannerRow({
    required this.id,
    required this.title,
    this.badge,
    required this.themeKey,
    required this.imageUrl,
    required this.imageAsset,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || badge != null) {
      map['badge'] = Variable<String>(badge);
    }
    map['theme_key'] = Variable<String>(themeKey);
    map['image_url'] = Variable<String>(imageUrl);
    map['image_asset'] = Variable<String>(imageAsset);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  BannersCompanion toCompanion(bool nullToAbsent) {
    return BannersCompanion(
      id: Value(id),
      title: Value(title),
      badge: badge == null && nullToAbsent
          ? const Value.absent()
          : Value(badge),
      themeKey: Value(themeKey),
      imageUrl: Value(imageUrl),
      imageAsset: Value(imageAsset),
      sortOrder: Value(sortOrder),
    );
  }

  factory BannerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BannerRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      badge: serializer.fromJson<String?>(json['badge']),
      themeKey: serializer.fromJson<String>(json['themeKey']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      imageAsset: serializer.fromJson<String>(json['imageAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'badge': serializer.toJson<String?>(badge),
      'themeKey': serializer.toJson<String>(themeKey),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'imageAsset': serializer.toJson<String>(imageAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  BannerRow copyWith({
    String? id,
    String? title,
    Value<String?> badge = const Value.absent(),
    String? themeKey,
    String? imageUrl,
    String? imageAsset,
    int? sortOrder,
  }) => BannerRow(
    id: id ?? this.id,
    title: title ?? this.title,
    badge: badge.present ? badge.value : this.badge,
    themeKey: themeKey ?? this.themeKey,
    imageUrl: imageUrl ?? this.imageUrl,
    imageAsset: imageAsset ?? this.imageAsset,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  BannerRow copyWithCompanion(BannersCompanion data) {
    return BannerRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      badge: data.badge.present ? data.badge.value : this.badge,
      themeKey: data.themeKey.present ? data.themeKey.value : this.themeKey,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BannerRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('badge: $badge, ')
          ..write('themeKey: $themeKey, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, badge, themeKey, imageUrl, imageAsset, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BannerRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.badge == this.badge &&
          other.themeKey == this.themeKey &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.sortOrder == this.sortOrder);
}

class BannersCompanion extends UpdateCompanion<BannerRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> badge;
  final Value<String> themeKey;
  final Value<String> imageUrl;
  final Value<String> imageAsset;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const BannersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.badge = const Value.absent(),
    this.themeKey = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BannersCompanion.insert({
    required String id,
    required String title,
    this.badge = const Value.absent(),
    this.themeKey = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<BannerRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? badge,
    Expression<String>? themeKey,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (badge != null) 'badge': badge,
      if (themeKey != null) 'theme_key': themeKey,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BannersCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? badge,
    Value<String>? themeKey,
    Value<String>? imageUrl,
    Value<String>? imageAsset,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return BannersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      badge: badge ?? this.badge,
      themeKey: themeKey ?? this.themeKey,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (badge.present) {
      map['badge'] = Variable<String>(badge.value);
    }
    if (themeKey.present) {
      map['theme_key'] = Variable<String>(themeKey.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BannersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('badge: $badge, ')
          ..write('themeKey: $themeKey, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HomeSectionsTable extends HomeSections
    with TableInfo<$HomeSectionsTable, HomeSectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HomeSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _layoutMeta = const VerificationMeta('layout');
  @override
  late final GeneratedColumn<String> layout = GeneratedColumn<String>(
    'layout',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, layout, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'home_sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<HomeSectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('layout')) {
      context.handle(
        _layoutMeta,
        layout.isAcceptableOrUnknown(data['layout']!, _layoutMeta),
      );
    } else if (isInserting) {
      context.missing(_layoutMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HomeSectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HomeSectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      layout: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}layout'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $HomeSectionsTable createAlias(String alias) {
    return $HomeSectionsTable(attachedDatabase, alias);
  }
}

class HomeSectionRow extends DataClass implements Insertable<HomeSectionRow> {
  final String id;
  final String title;

  /// 'wide', 'tall' or 'compact' tiles.
  final String layout;
  final int sortOrder;
  const HomeSectionRow({
    required this.id,
    required this.title,
    required this.layout,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['layout'] = Variable<String>(layout);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  HomeSectionsCompanion toCompanion(bool nullToAbsent) {
    return HomeSectionsCompanion(
      id: Value(id),
      title: Value(title),
      layout: Value(layout),
      sortOrder: Value(sortOrder),
    );
  }

  factory HomeSectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HomeSectionRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      layout: serializer.fromJson<String>(json['layout']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'layout': serializer.toJson<String>(layout),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  HomeSectionRow copyWith({
    String? id,
    String? title,
    String? layout,
    int? sortOrder,
  }) => HomeSectionRow(
    id: id ?? this.id,
    title: title ?? this.title,
    layout: layout ?? this.layout,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  HomeSectionRow copyWithCompanion(HomeSectionsCompanion data) {
    return HomeSectionRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      layout: data.layout.present ? data.layout.value : this.layout,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HomeSectionRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('layout: $layout, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, layout, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeSectionRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.layout == this.layout &&
          other.sortOrder == this.sortOrder);
}

class HomeSectionsCompanion extends UpdateCompanion<HomeSectionRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> layout;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const HomeSectionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.layout = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HomeSectionsCompanion.insert({
    required String id,
    required String title,
    required String layout,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       layout = Value(layout);
  static Insertable<HomeSectionRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? layout,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (layout != null) 'layout': layout,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HomeSectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? layout,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return HomeSectionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      layout: layout ?? this.layout,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (layout.present) {
      map['layout'] = Variable<String>(layout.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HomeSectionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('layout: $layout, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HomeSectionItemsTable extends HomeSectionItems
    with TableInfo<$HomeSectionItemsTable, HomeSectionItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HomeSectionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
    'section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [sectionId, productId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'home_section_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<HomeSectionItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sectionId, productId};
  @override
  HomeSectionItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HomeSectionItemRow(
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $HomeSectionItemsTable createAlias(String alias) {
    return $HomeSectionItemsTable(attachedDatabase, alias);
  }
}

class HomeSectionItemRow extends DataClass
    implements Insertable<HomeSectionItemRow> {
  final String sectionId;
  final String productId;
  final int sortOrder;
  const HomeSectionItemRow({
    required this.sectionId,
    required this.productId,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['section_id'] = Variable<String>(sectionId);
    map['product_id'] = Variable<String>(productId);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  HomeSectionItemsCompanion toCompanion(bool nullToAbsent) {
    return HomeSectionItemsCompanion(
      sectionId: Value(sectionId),
      productId: Value(productId),
      sortOrder: Value(sortOrder),
    );
  }

  factory HomeSectionItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HomeSectionItemRow(
      sectionId: serializer.fromJson<String>(json['sectionId']),
      productId: serializer.fromJson<String>(json['productId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sectionId': serializer.toJson<String>(sectionId),
      'productId': serializer.toJson<String>(productId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  HomeSectionItemRow copyWith({
    String? sectionId,
    String? productId,
    int? sortOrder,
  }) => HomeSectionItemRow(
    sectionId: sectionId ?? this.sectionId,
    productId: productId ?? this.productId,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  HomeSectionItemRow copyWithCompanion(HomeSectionItemsCompanion data) {
    return HomeSectionItemRow(
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      productId: data.productId.present ? data.productId.value : this.productId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HomeSectionItemRow(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sectionId, productId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeSectionItemRow &&
          other.sectionId == this.sectionId &&
          other.productId == this.productId &&
          other.sortOrder == this.sortOrder);
}

class HomeSectionItemsCompanion extends UpdateCompanion<HomeSectionItemRow> {
  final Value<String> sectionId;
  final Value<String> productId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const HomeSectionItemsCompanion({
    this.sectionId = const Value.absent(),
    this.productId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HomeSectionItemsCompanion.insert({
    required String sectionId,
    required String productId,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sectionId = Value(sectionId),
       productId = Value(productId);
  static Insertable<HomeSectionItemRow> custom({
    Expression<String>? sectionId,
    Expression<String>? productId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sectionId != null) 'section_id': sectionId,
      if (productId != null) 'product_id': productId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HomeSectionItemsCompanion copyWith({
    Value<String>? sectionId,
    Value<String>? productId,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return HomeSectionItemsCompanion(
      sectionId: sectionId ?? this.sectionId,
      productId: productId ?? this.productId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HomeSectionItemsCompanion(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShopsTable extends Shops with TableInfo<$ShopsTable, ShopRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    imageUrl,
    imageAsset,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ShopsTable createAlias(String alias) {
    return $ShopsTable(attachedDatabase, alias);
  }
}

class ShopRow extends DataClass implements Insertable<ShopRow> {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final String imageAsset;
  final int sortOrder;
  const ShopRow({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.imageAsset,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['image_url'] = Variable<String>(imageUrl);
    map['image_asset'] = Variable<String>(imageAsset);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      imageUrl: Value(imageUrl),
      imageAsset: Value(imageAsset),
      sortOrder: Value(sortOrder),
    );
  }

  factory ShopRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      imageAsset: serializer.fromJson<String>(json['imageAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'imageAsset': serializer.toJson<String>(imageAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ShopRow copyWith({
    String? id,
    String? name,
    String? address,
    String? imageUrl,
    String? imageAsset,
    int? sortOrder,
  }) => ShopRow(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    imageUrl: imageUrl ?? this.imageUrl,
    imageAsset: imageAsset ?? this.imageAsset,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ShopRow copyWithCompanion(ShopsCompanion data) {
    return ShopRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, address, imageUrl, imageAsset, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.sortOrder == this.sortOrder);
}

class ShopsCompanion extends UpdateCompanion<ShopRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String> imageUrl;
  final Value<String> imageAsset;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsCompanion.insert({
    required String id,
    required String name,
    required String address,
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       address = Value(address);
  static Insertable<ShopRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? address,
    Value<String>? imageUrl,
    Value<String>? imageAsset,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ShopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, MemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoAssetMeta = const VerificationMeta(
    'photoAsset',
  );
  @override
  late final GeneratedColumn<String> photoAsset = GeneratedColumn<String>(
    'photo_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextTierMeta = const VerificationMeta(
    'nextTier',
  );
  @override
  late final GeneratedColumn<String> nextTier = GeneratedColumn<String>(
    'next_tier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pointsToNextTierMeta = const VerificationMeta(
    'pointsToNextTier',
  );
  @override
  late final GeneratedColumn<int> pointsToNextTier = GeneratedColumn<int>(
    'points_to_next_tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tierProgressMeta = const VerificationMeta(
    'tierProgress',
  );
  @override
  late final GeneratedColumn<double> tierProgress = GeneratedColumn<double>(
    'tier_progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notificationCountMeta = const VerificationMeta(
    'notificationCount',
  );
  @override
  late final GeneratedColumn<int> notificationCount = GeneratedColumn<int>(
    'notification_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rewardsCountMeta = const VerificationMeta(
    'rewardsCount',
  );
  @override
  late final GeneratedColumn<int> rewardsCount = GeneratedColumn<int>(
    'rewards_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    photoAsset,
    photoUrl,
    tier,
    nextTier,
    pointsToNextTier,
    totalPoints,
    tierProgress,
    notificationCount,
    rewardsCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo_asset')) {
      context.handle(
        _photoAssetMeta,
        photoAsset.isAcceptableOrUnknown(data['photo_asset']!, _photoAssetMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('next_tier')) {
      context.handle(
        _nextTierMeta,
        nextTier.isAcceptableOrUnknown(data['next_tier']!, _nextTierMeta),
      );
    }
    if (data.containsKey('points_to_next_tier')) {
      context.handle(
        _pointsToNextTierMeta,
        pointsToNextTier.isAcceptableOrUnknown(
          data['points_to_next_tier']!,
          _pointsToNextTierMeta,
        ),
      );
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    }
    if (data.containsKey('tier_progress')) {
      context.handle(
        _tierProgressMeta,
        tierProgress.isAcceptableOrUnknown(
          data['tier_progress']!,
          _tierProgressMeta,
        ),
      );
    }
    if (data.containsKey('notification_count')) {
      context.handle(
        _notificationCountMeta,
        notificationCount.isAcceptableOrUnknown(
          data['notification_count']!,
          _notificationCountMeta,
        ),
      );
    }
    if (data.containsKey('rewards_count')) {
      context.handle(
        _rewardsCountMeta,
        rewardsCount.isAcceptableOrUnknown(
          data['rewards_count']!,
          _rewardsCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      photoAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_asset'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      nextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_tier'],
      ),
      pointsToNextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_to_next_tier'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      tierProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tier_progress'],
      )!,
      notificationCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_count'],
      )!,
      rewardsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rewards_count'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class MemberRow extends DataClass implements Insertable<MemberRow> {
  final String id;
  final String name;
  final String photoAsset;
  final String photoUrl;
  final String tier;
  final String? nextTier;
  final int pointsToNextTier;
  final int totalPoints;

  /// 0..1 progress from the current tier to the next.
  final double tierProgress;
  final int notificationCount;
  final int rewardsCount;
  const MemberRow({
    required this.id,
    required this.name,
    required this.photoAsset,
    required this.photoUrl,
    required this.tier,
    this.nextTier,
    required this.pointsToNextTier,
    required this.totalPoints,
    required this.tierProgress,
    required this.notificationCount,
    required this.rewardsCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['photo_asset'] = Variable<String>(photoAsset);
    map['photo_url'] = Variable<String>(photoUrl);
    map['tier'] = Variable<String>(tier);
    if (!nullToAbsent || nextTier != null) {
      map['next_tier'] = Variable<String>(nextTier);
    }
    map['points_to_next_tier'] = Variable<int>(pointsToNextTier);
    map['total_points'] = Variable<int>(totalPoints);
    map['tier_progress'] = Variable<double>(tierProgress);
    map['notification_count'] = Variable<int>(notificationCount);
    map['rewards_count'] = Variable<int>(rewardsCount);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      photoAsset: Value(photoAsset),
      photoUrl: Value(photoUrl),
      tier: Value(tier),
      nextTier: nextTier == null && nullToAbsent
          ? const Value.absent()
          : Value(nextTier),
      pointsToNextTier: Value(pointsToNextTier),
      totalPoints: Value(totalPoints),
      tierProgress: Value(tierProgress),
      notificationCount: Value(notificationCount),
      rewardsCount: Value(rewardsCount),
    );
  }

  factory MemberRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      photoAsset: serializer.fromJson<String>(json['photoAsset']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
      tier: serializer.fromJson<String>(json['tier']),
      nextTier: serializer.fromJson<String?>(json['nextTier']),
      pointsToNextTier: serializer.fromJson<int>(json['pointsToNextTier']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      tierProgress: serializer.fromJson<double>(json['tierProgress']),
      notificationCount: serializer.fromJson<int>(json['notificationCount']),
      rewardsCount: serializer.fromJson<int>(json['rewardsCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'photoAsset': serializer.toJson<String>(photoAsset),
      'photoUrl': serializer.toJson<String>(photoUrl),
      'tier': serializer.toJson<String>(tier),
      'nextTier': serializer.toJson<String?>(nextTier),
      'pointsToNextTier': serializer.toJson<int>(pointsToNextTier),
      'totalPoints': serializer.toJson<int>(totalPoints),
      'tierProgress': serializer.toJson<double>(tierProgress),
      'notificationCount': serializer.toJson<int>(notificationCount),
      'rewardsCount': serializer.toJson<int>(rewardsCount),
    };
  }

  MemberRow copyWith({
    String? id,
    String? name,
    String? photoAsset,
    String? photoUrl,
    String? tier,
    Value<String?> nextTier = const Value.absent(),
    int? pointsToNextTier,
    int? totalPoints,
    double? tierProgress,
    int? notificationCount,
    int? rewardsCount,
  }) => MemberRow(
    id: id ?? this.id,
    name: name ?? this.name,
    photoAsset: photoAsset ?? this.photoAsset,
    photoUrl: photoUrl ?? this.photoUrl,
    tier: tier ?? this.tier,
    nextTier: nextTier.present ? nextTier.value : this.nextTier,
    pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
    totalPoints: totalPoints ?? this.totalPoints,
    tierProgress: tierProgress ?? this.tierProgress,
    notificationCount: notificationCount ?? this.notificationCount,
    rewardsCount: rewardsCount ?? this.rewardsCount,
  );
  MemberRow copyWithCompanion(MembersCompanion data) {
    return MemberRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      photoAsset: data.photoAsset.present
          ? data.photoAsset.value
          : this.photoAsset,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      tier: data.tier.present ? data.tier.value : this.tier,
      nextTier: data.nextTier.present ? data.nextTier.value : this.nextTier,
      pointsToNextTier: data.pointsToNextTier.present
          ? data.pointsToNextTier.value
          : this.pointsToNextTier,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      tierProgress: data.tierProgress.present
          ? data.tierProgress.value
          : this.tierProgress,
      notificationCount: data.notificationCount.present
          ? data.notificationCount.value
          : this.notificationCount,
      rewardsCount: data.rewardsCount.present
          ? data.rewardsCount.value
          : this.rewardsCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoAsset: $photoAsset, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('tier: $tier, ')
          ..write('nextTier: $nextTier, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('tierProgress: $tierProgress, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardsCount: $rewardsCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    photoAsset,
    photoUrl,
    tier,
    nextTier,
    pointsToNextTier,
    totalPoints,
    tierProgress,
    notificationCount,
    rewardsCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.photoAsset == this.photoAsset &&
          other.photoUrl == this.photoUrl &&
          other.tier == this.tier &&
          other.nextTier == this.nextTier &&
          other.pointsToNextTier == this.pointsToNextTier &&
          other.totalPoints == this.totalPoints &&
          other.tierProgress == this.tierProgress &&
          other.notificationCount == this.notificationCount &&
          other.rewardsCount == this.rewardsCount);
}

class MembersCompanion extends UpdateCompanion<MemberRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> photoAsset;
  final Value<String> photoUrl;
  final Value<String> tier;
  final Value<String?> nextTier;
  final Value<int> pointsToNextTier;
  final Value<int> totalPoints;
  final Value<double> tierProgress;
  final Value<int> notificationCount;
  final Value<int> rewardsCount;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.photoAsset = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.tier = const Value.absent(),
    this.nextTier = const Value.absent(),
    this.pointsToNextTier = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.tierProgress = const Value.absent(),
    this.notificationCount = const Value.absent(),
    this.rewardsCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String name,
    this.photoAsset = const Value.absent(),
    this.photoUrl = const Value.absent(),
    required String tier,
    this.nextTier = const Value.absent(),
    this.pointsToNextTier = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.tierProgress = const Value.absent(),
    this.notificationCount = const Value.absent(),
    this.rewardsCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       tier = Value(tier);
  static Insertable<MemberRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? photoAsset,
    Expression<String>? photoUrl,
    Expression<String>? tier,
    Expression<String>? nextTier,
    Expression<int>? pointsToNextTier,
    Expression<int>? totalPoints,
    Expression<double>? tierProgress,
    Expression<int>? notificationCount,
    Expression<int>? rewardsCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (photoAsset != null) 'photo_asset': photoAsset,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (tier != null) 'tier': tier,
      if (nextTier != null) 'next_tier': nextTier,
      if (pointsToNextTier != null) 'points_to_next_tier': pointsToNextTier,
      if (totalPoints != null) 'total_points': totalPoints,
      if (tierProgress != null) 'tier_progress': tierProgress,
      if (notificationCount != null) 'notification_count': notificationCount,
      if (rewardsCount != null) 'rewards_count': rewardsCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? photoAsset,
    Value<String>? photoUrl,
    Value<String>? tier,
    Value<String?>? nextTier,
    Value<int>? pointsToNextTier,
    Value<int>? totalPoints,
    Value<double>? tierProgress,
    Value<int>? notificationCount,
    Value<int>? rewardsCount,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      photoAsset: photoAsset ?? this.photoAsset,
      photoUrl: photoUrl ?? this.photoUrl,
      tier: tier ?? this.tier,
      nextTier: nextTier ?? this.nextTier,
      pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
      totalPoints: totalPoints ?? this.totalPoints,
      tierProgress: tierProgress ?? this.tierProgress,
      notificationCount: notificationCount ?? this.notificationCount,
      rewardsCount: rewardsCount ?? this.rewardsCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photoAsset.present) {
      map['photo_asset'] = Variable<String>(photoAsset.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (nextTier.present) {
      map['next_tier'] = Variable<String>(nextTier.value);
    }
    if (pointsToNextTier.present) {
      map['points_to_next_tier'] = Variable<int>(pointsToNextTier.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (tierProgress.present) {
      map['tier_progress'] = Variable<double>(tierProgress.value);
    }
    if (notificationCount.present) {
      map['notification_count'] = Variable<int>(notificationCount.value);
    }
    if (rewardsCount.present) {
      map['rewards_count'] = Variable<int>(rewardsCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoAsset: $photoAsset, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('tier: $tier, ')
          ..write('nextTier: $nextTier, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('tierProgress: $tierProgress, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardsCount: $rewardsCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChallengesTable extends Challenges
    with TableInfo<$ChallengesTable, ChallengeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artKindMeta = const VerificationMeta(
    'artKind',
  );
  @override
  late final GeneratedColumn<String> artKind = GeneratedColumn<String>(
    'art_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tabMeta = const VerificationMeta('tab');
  @override
  late final GeneratedColumn<String> tab = GeneratedColumn<String>(
    'tab',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardPointsMeta = const VerificationMeta(
    'rewardPoints',
  );
  @override
  late final GeneratedColumn<int> rewardPoints = GeneratedColumn<int>(
    'reward_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    artKind,
    tab,
    progress,
    target,
    rewardPoints,
    imageAsset,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChallengeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('art_kind')) {
      context.handle(
        _artKindMeta,
        artKind.isAcceptableOrUnknown(data['art_kind']!, _artKindMeta),
      );
    } else if (isInserting) {
      context.missing(_artKindMeta);
    }
    if (data.containsKey('tab')) {
      context.handle(
        _tabMeta,
        tab.isAcceptableOrUnknown(data['tab']!, _tabMeta),
      );
    } else if (isInserting) {
      context.missing(_tabMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('reward_points')) {
      context.handle(
        _rewardPointsMeta,
        rewardPoints.isAcceptableOrUnknown(
          data['reward_points']!,
          _rewardPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardPointsMeta);
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChallengeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      artKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}art_kind'],
      )!,
      tab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tab'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      rewardPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_points'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ChallengesTable createAlias(String alias) {
    return $ChallengesTable(attachedDatabase, alias);
  }
}

class ChallengeRow extends DataClass implements Insertable<ChallengeRow> {
  final String id;
  final String title;

  /// Which artwork shows the progress: 'donut', 'coffee' or 'gift'.
  final String artKind;

  /// Which tab lists it: 'earn' or 'gift'.
  final String tab;
  final int progress;
  final int target;
  final int rewardPoints;
  final String imageAsset;
  final int sortOrder;
  const ChallengeRow({
    required this.id,
    required this.title,
    required this.artKind,
    required this.tab,
    required this.progress,
    required this.target,
    required this.rewardPoints,
    required this.imageAsset,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['art_kind'] = Variable<String>(artKind);
    map['tab'] = Variable<String>(tab);
    map['progress'] = Variable<int>(progress);
    map['target'] = Variable<int>(target);
    map['reward_points'] = Variable<int>(rewardPoints);
    map['image_asset'] = Variable<String>(imageAsset);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ChallengesCompanion toCompanion(bool nullToAbsent) {
    return ChallengesCompanion(
      id: Value(id),
      title: Value(title),
      artKind: Value(artKind),
      tab: Value(tab),
      progress: Value(progress),
      target: Value(target),
      rewardPoints: Value(rewardPoints),
      imageAsset: Value(imageAsset),
      sortOrder: Value(sortOrder),
    );
  }

  factory ChallengeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artKind: serializer.fromJson<String>(json['artKind']),
      tab: serializer.fromJson<String>(json['tab']),
      progress: serializer.fromJson<int>(json['progress']),
      target: serializer.fromJson<int>(json['target']),
      rewardPoints: serializer.fromJson<int>(json['rewardPoints']),
      imageAsset: serializer.fromJson<String>(json['imageAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'artKind': serializer.toJson<String>(artKind),
      'tab': serializer.toJson<String>(tab),
      'progress': serializer.toJson<int>(progress),
      'target': serializer.toJson<int>(target),
      'rewardPoints': serializer.toJson<int>(rewardPoints),
      'imageAsset': serializer.toJson<String>(imageAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ChallengeRow copyWith({
    String? id,
    String? title,
    String? artKind,
    String? tab,
    int? progress,
    int? target,
    int? rewardPoints,
    String? imageAsset,
    int? sortOrder,
  }) => ChallengeRow(
    id: id ?? this.id,
    title: title ?? this.title,
    artKind: artKind ?? this.artKind,
    tab: tab ?? this.tab,
    progress: progress ?? this.progress,
    target: target ?? this.target,
    rewardPoints: rewardPoints ?? this.rewardPoints,
    imageAsset: imageAsset ?? this.imageAsset,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ChallengeRow copyWithCompanion(ChallengesCompanion data) {
    return ChallengeRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      artKind: data.artKind.present ? data.artKind.value : this.artKind,
      tab: data.tab.present ? data.tab.value : this.tab,
      progress: data.progress.present ? data.progress.value : this.progress,
      target: data.target.present ? data.target.value : this.target,
      rewardPoints: data.rewardPoints.present
          ? data.rewardPoints.value
          : this.rewardPoints,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artKind: $artKind, ')
          ..write('tab: $tab, ')
          ..write('progress: $progress, ')
          ..write('target: $target, ')
          ..write('rewardPoints: $rewardPoints, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    artKind,
    tab,
    progress,
    target,
    rewardPoints,
    imageAsset,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.artKind == this.artKind &&
          other.tab == this.tab &&
          other.progress == this.progress &&
          other.target == this.target &&
          other.rewardPoints == this.rewardPoints &&
          other.imageAsset == this.imageAsset &&
          other.sortOrder == this.sortOrder);
}

class ChallengesCompanion extends UpdateCompanion<ChallengeRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> artKind;
  final Value<String> tab;
  final Value<int> progress;
  final Value<int> target;
  final Value<int> rewardPoints;
  final Value<String> imageAsset;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ChallengesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artKind = const Value.absent(),
    this.tab = const Value.absent(),
    this.progress = const Value.absent(),
    this.target = const Value.absent(),
    this.rewardPoints = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesCompanion.insert({
    required String id,
    required String title,
    required String artKind,
    required String tab,
    required int progress,
    required int target,
    required int rewardPoints,
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       artKind = Value(artKind),
       tab = Value(tab),
       progress = Value(progress),
       target = Value(target),
       rewardPoints = Value(rewardPoints);
  static Insertable<ChallengeRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? artKind,
    Expression<String>? tab,
    Expression<int>? progress,
    Expression<int>? target,
    Expression<int>? rewardPoints,
    Expression<String>? imageAsset,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artKind != null) 'art_kind': artKind,
      if (tab != null) 'tab': tab,
      if (progress != null) 'progress': progress,
      if (target != null) 'target': target,
      if (rewardPoints != null) 'reward_points': rewardPoints,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? artKind,
    Value<String>? tab,
    Value<int>? progress,
    Value<int>? target,
    Value<int>? rewardPoints,
    Value<String>? imageAsset,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ChallengesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artKind: artKind ?? this.artKind,
      tab: tab ?? this.tab,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      imageAsset: imageAsset ?? this.imageAsset,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artKind.present) {
      map['art_kind'] = Variable<String>(artKind.value);
    }
    if (tab.present) {
      map['tab'] = Variable<String>(tab.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (rewardPoints.present) {
      map['reward_points'] = Variable<int>(rewardPoints.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artKind: $artKind, ')
          ..write('tab: $tab, ')
          ..write('progress: $progress, ')
          ..write('target: $target, ')
          ..write('rewardPoints: $rewardPoints, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompleteMeta = const VerificationMeta(
    'isComplete',
  );
  @override
  late final GeneratedColumn<bool> isComplete = GeneratedColumn<bool>(
    'is_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    phone,
    firstName,
    lastName,
    dateOfBirth,
    isComplete,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('is_complete')) {
      context.handle(
        _isCompleteMeta,
        isComplete.isAcceptableOrUnknown(data['is_complete']!, _isCompleteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phone};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      isComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_complete'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final String phone;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;

  /// False until the last registration step (date of birth) is saved.
  final bool isComplete;
  final DateTime createdAt;
  const UserRow({
    required this.phone,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    required this.isComplete,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    map['is_complete'] = Variable<bool>(isComplete);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      phone: Value(phone),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      isComplete: Value(isComplete),
      createdAt: Value(createdAt),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      phone: serializer.fromJson<String>(json['phone']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      isComplete: serializer.fromJson<bool>(json['isComplete']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phone': serializer.toJson<String>(phone),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'isComplete': serializer.toJson<bool>(isComplete),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserRow copyWith({
    String? phone,
    Value<String?> firstName = const Value.absent(),
    Value<String?> lastName = const Value.absent(),
    Value<DateTime?> dateOfBirth = const Value.absent(),
    bool? isComplete,
    DateTime? createdAt,
  }) => UserRow(
    phone: phone ?? this.phone,
    firstName: firstName.present ? firstName.value : this.firstName,
    lastName: lastName.present ? lastName.value : this.lastName,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    isComplete: isComplete ?? this.isComplete,
    createdAt: createdAt ?? this.createdAt,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      phone: data.phone.present ? data.phone.value : this.phone,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      isComplete: data.isComplete.present
          ? data.isComplete.value
          : this.isComplete,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('isComplete: $isComplete, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    phone,
    firstName,
    lastName,
    dateOfBirth,
    isComplete,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.phone == this.phone &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.isComplete == this.isComplete &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<String> phone;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<DateTime?> dateOfBirth;
  final Value<bool> isComplete;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.phone = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.isComplete = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String phone,
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.isComplete = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : phone = Value(phone),
       createdAt = Value(createdAt);
  static Insertable<UserRow> custom({
    Expression<String>? phone,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<DateTime>? dateOfBirth,
    Expression<bool>? isComplete,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phone != null) 'phone': phone,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (isComplete != null) 'is_complete': isComplete,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? phone,
    Value<String?>? firstName,
    Value<String?>? lastName,
    Value<DateTime?>? dateOfBirth,
    Value<bool>? isComplete,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isComplete: isComplete ?? this.isComplete,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (isComplete.present) {
      map['is_complete'] = Variable<bool>(isComplete.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('isComplete: $isComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaRow extends DataClass implements Insertable<AppMetaRow> {
  final String key;
  final String value;
  const AppMetaRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetaRow copyWith({String? key, String? value}) =>
      AppMetaRow(key: key ?? this.key, value: value ?? this.value);
  AppMetaRow copyWithCompanion(AppMetaCompanion data) {
    return AppMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaRow &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [productId, quantity, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  CartItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItemRow(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(attachedDatabase, alias);
  }
}

class CartItemRow extends DataClass implements Insertable<CartItemRow> {
  final String productId;
  final int quantity;
  final DateTime updatedAt;
  const CartItemRow({
    required this.productId,
    required this.quantity,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(
      productId: Value(productId),
      quantity: Value(quantity),
      updatedAt: Value(updatedAt),
    );
  }

  factory CartItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItemRow(
      productId: serializer.fromJson<String>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CartItemRow copyWith({
    String? productId,
    int? quantity,
    DateTime? updatedAt,
  }) => CartItemRow(
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CartItemRow copyWithCompanion(CartItemsCompanion data) {
    return CartItemRow(
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItemRow(')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, quantity, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItemRow &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.updatedAt == this.updatedAt);
}

class CartItemsCompanion extends UpdateCompanion<CartItemRow> {
  final Value<String> productId;
  final Value<int> quantity;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CartItemsCompanion({
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartItemsCompanion.insert({
    required String productId,
    required int quantity,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       quantity = Value(quantity),
       updatedAt = Value(updatedAt);
  static Insertable<CartItemRow> custom({
    Expression<String>? productId,
    Expression<int>? quantity,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartItemsCompanion copyWith({
    Value<String>? productId,
    Value<int>? quantity,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CartItemsCompanion(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $BannersTable banners = $BannersTable(this);
  late final $HomeSectionsTable homeSections = $HomeSectionsTable(this);
  late final $HomeSectionItemsTable homeSectionItems = $HomeSectionItemsTable(
    this,
  );
  late final $ShopsTable shops = $ShopsTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $ChallengesTable challenges = $ChallengesTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  late final $CartItemsTable cartItems = $CartItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    banners,
    homeSections,
    homeSectionItems,
    shops,
    members,
    challenges,
    users,
    appMeta,
    cartItems,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      required String code,
      required String name,
      required int priceMmk,
      Value<bool> isNew,
      Value<int?> discountPercent,
      Value<String> imageUrl,
      Value<String> imageAsset,
      Value<String> description,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> name,
      Value<int> priceMmk,
      Value<bool> isNew,
      Value<int?> discountPercent,
      Value<String> imageUrl,
      Value<String> imageAsset,
      Value<String> description,
      Value<int> rowid,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMmk =>
      $composableBuilder(column: $table.priceMmk, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (
            ProductRow,
            BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>,
          ),
          ProductRow,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceMmk = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String name,
                required int priceMmk,
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>),
      ProductRow,
      PrefetchHooks Function()
    >;
typedef $$BannersTableCreateCompanionBuilder =
    BannersCompanion Function({
      required String id,
      required String title,
      Value<String?> badge,
      Value<String> themeKey,
      Value<String> imageUrl,
      Value<String> imageAsset,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$BannersTableUpdateCompanionBuilder =
    BannersCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> badge,
      Value<String> themeKey,
      Value<String> imageUrl,
      Value<String> imageAsset,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$BannersTableFilterComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeKey => $composableBuilder(
    column: $table.themeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BannersTableOrderingComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeKey => $composableBuilder(
    column: $table.themeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BannersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get badge =>
      $composableBuilder(column: $table.badge, builder: (column) => column);

  GeneratedColumn<String> get themeKey =>
      $composableBuilder(column: $table.themeKey, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$BannersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BannersTable,
          BannerRow,
          $$BannersTableFilterComposer,
          $$BannersTableOrderingComposer,
          $$BannersTableAnnotationComposer,
          $$BannersTableCreateCompanionBuilder,
          $$BannersTableUpdateCompanionBuilder,
          (BannerRow, BaseReferences<_$AppDatabase, $BannersTable, BannerRow>),
          BannerRow,
          PrefetchHooks Function()
        > {
  $$BannersTableTableManager(_$AppDatabase db, $BannersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BannersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BannersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BannersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> badge = const Value.absent(),
                Value<String> themeKey = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion(
                id: id,
                title: title,
                badge: badge,
                themeKey: themeKey,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> badge = const Value.absent(),
                Value<String> themeKey = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion.insert(
                id: id,
                title: title,
                badge: badge,
                themeKey: themeKey,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BannersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BannersTable,
      BannerRow,
      $$BannersTableFilterComposer,
      $$BannersTableOrderingComposer,
      $$BannersTableAnnotationComposer,
      $$BannersTableCreateCompanionBuilder,
      $$BannersTableUpdateCompanionBuilder,
      (BannerRow, BaseReferences<_$AppDatabase, $BannersTable, BannerRow>),
      BannerRow,
      PrefetchHooks Function()
    >;
typedef $$HomeSectionsTableCreateCompanionBuilder =
    HomeSectionsCompanion Function({
      required String id,
      required String title,
      required String layout,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$HomeSectionsTableUpdateCompanionBuilder =
    HomeSectionsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> layout,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$HomeSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $HomeSectionsTable> {
  $$HomeSectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get layout => $composableBuilder(
    column: $table.layout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HomeSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HomeSectionsTable> {
  $$HomeSectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layout => $composableBuilder(
    column: $table.layout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HomeSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HomeSectionsTable> {
  $$HomeSectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get layout =>
      $composableBuilder(column: $table.layout, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$HomeSectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HomeSectionsTable,
          HomeSectionRow,
          $$HomeSectionsTableFilterComposer,
          $$HomeSectionsTableOrderingComposer,
          $$HomeSectionsTableAnnotationComposer,
          $$HomeSectionsTableCreateCompanionBuilder,
          $$HomeSectionsTableUpdateCompanionBuilder,
          (
            HomeSectionRow,
            BaseReferences<_$AppDatabase, $HomeSectionsTable, HomeSectionRow>,
          ),
          HomeSectionRow,
          PrefetchHooks Function()
        > {
  $$HomeSectionsTableTableManager(_$AppDatabase db, $HomeSectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HomeSectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HomeSectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HomeSectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> layout = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HomeSectionsCompanion(
                id: id,
                title: title,
                layout: layout,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String layout,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HomeSectionsCompanion.insert(
                id: id,
                title: title,
                layout: layout,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HomeSectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HomeSectionsTable,
      HomeSectionRow,
      $$HomeSectionsTableFilterComposer,
      $$HomeSectionsTableOrderingComposer,
      $$HomeSectionsTableAnnotationComposer,
      $$HomeSectionsTableCreateCompanionBuilder,
      $$HomeSectionsTableUpdateCompanionBuilder,
      (
        HomeSectionRow,
        BaseReferences<_$AppDatabase, $HomeSectionsTable, HomeSectionRow>,
      ),
      HomeSectionRow,
      PrefetchHooks Function()
    >;
typedef $$HomeSectionItemsTableCreateCompanionBuilder =
    HomeSectionItemsCompanion Function({
      required String sectionId,
      required String productId,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$HomeSectionItemsTableUpdateCompanionBuilder =
    HomeSectionItemsCompanion Function({
      Value<String> sectionId,
      Value<String> productId,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$HomeSectionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $HomeSectionItemsTable> {
  $$HomeSectionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sectionId => $composableBuilder(
    column: $table.sectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HomeSectionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $HomeSectionItemsTable> {
  $$HomeSectionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sectionId => $composableBuilder(
    column: $table.sectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HomeSectionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HomeSectionItemsTable> {
  $$HomeSectionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sectionId =>
      $composableBuilder(column: $table.sectionId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$HomeSectionItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HomeSectionItemsTable,
          HomeSectionItemRow,
          $$HomeSectionItemsTableFilterComposer,
          $$HomeSectionItemsTableOrderingComposer,
          $$HomeSectionItemsTableAnnotationComposer,
          $$HomeSectionItemsTableCreateCompanionBuilder,
          $$HomeSectionItemsTableUpdateCompanionBuilder,
          (
            HomeSectionItemRow,
            BaseReferences<
              _$AppDatabase,
              $HomeSectionItemsTable,
              HomeSectionItemRow
            >,
          ),
          HomeSectionItemRow,
          PrefetchHooks Function()
        > {
  $$HomeSectionItemsTableTableManager(
    _$AppDatabase db,
    $HomeSectionItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HomeSectionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HomeSectionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HomeSectionItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sectionId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HomeSectionItemsCompanion(
                sectionId: sectionId,
                productId: productId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sectionId,
                required String productId,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HomeSectionItemsCompanion.insert(
                sectionId: sectionId,
                productId: productId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HomeSectionItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HomeSectionItemsTable,
      HomeSectionItemRow,
      $$HomeSectionItemsTableFilterComposer,
      $$HomeSectionItemsTableOrderingComposer,
      $$HomeSectionItemsTableAnnotationComposer,
      $$HomeSectionItemsTableCreateCompanionBuilder,
      $$HomeSectionItemsTableUpdateCompanionBuilder,
      (
        HomeSectionItemRow,
        BaseReferences<
          _$AppDatabase,
          $HomeSectionItemsTable,
          HomeSectionItemRow
        >,
      ),
      HomeSectionItemRow,
      PrefetchHooks Function()
    >;
typedef $$ShopsTableCreateCompanionBuilder =
    ShopsCompanion Function({
      required String id,
      required String name,
      required String address,
      Value<String> imageUrl,
      Value<String> imageAsset,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$ShopsTableUpdateCompanionBuilder =
    ShopsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> address,
      Value<String> imageUrl,
      Value<String> imageAsset,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$ShopsTableFilterComposer extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ShopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTable,
          ShopRow,
          $$ShopsTableFilterComposer,
          $$ShopsTableOrderingComposer,
          $$ShopsTableAnnotationComposer,
          $$ShopsTableCreateCompanionBuilder,
          $$ShopsTableUpdateCompanionBuilder,
          (ShopRow, BaseReferences<_$AppDatabase, $ShopsTable, ShopRow>),
          ShopRow,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableManager(_$AppDatabase db, $ShopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String address,
                Value<String> imageUrl = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion.insert(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTable,
      ShopRow,
      $$ShopsTableFilterComposer,
      $$ShopsTableOrderingComposer,
      $$ShopsTableAnnotationComposer,
      $$ShopsTableCreateCompanionBuilder,
      $$ShopsTableUpdateCompanionBuilder,
      (ShopRow, BaseReferences<_$AppDatabase, $ShopsTable, ShopRow>),
      ShopRow,
      PrefetchHooks Function()
    >;
typedef $$MembersTableCreateCompanionBuilder =
    MembersCompanion Function({
      required String id,
      required String name,
      Value<String> photoAsset,
      Value<String> photoUrl,
      required String tier,
      Value<String?> nextTier,
      Value<int> pointsToNextTier,
      Value<int> totalPoints,
      Value<double> tierProgress,
      Value<int> notificationCount,
      Value<int> rewardsCount,
      Value<int> rowid,
    });
typedef $$MembersTableUpdateCompanionBuilder =
    MembersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> photoAsset,
      Value<String> photoUrl,
      Value<String> tier,
      Value<String?> nextTier,
      Value<int> pointsToNextTier,
      Value<int> totalPoints,
      Value<double> tierProgress,
      Value<int> notificationCount,
      Value<int> rewardsCount,
      Value<int> rowid,
    });

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoAsset => $composableBuilder(
    column: $table.photoAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextTier => $composableBuilder(
    column: $table.nextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tierProgress => $composableBuilder(
    column: $table.tierProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardsCount => $composableBuilder(
    column: $table.rewardsCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoAsset => $composableBuilder(
    column: $table.photoAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextTier => $composableBuilder(
    column: $table.nextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tierProgress => $composableBuilder(
    column: $table.tierProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardsCount => $composableBuilder(
    column: $table.rewardsCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get photoAsset => $composableBuilder(
    column: $table.photoAsset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get nextTier =>
      $composableBuilder(column: $table.nextTier, builder: (column) => column);

  GeneratedColumn<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tierProgress => $composableBuilder(
    column: $table.tierProgress,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rewardsCount => $composableBuilder(
    column: $table.rewardsCount,
    builder: (column) => column,
  );
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          MemberRow,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
          MemberRow,
          PrefetchHooks Function()
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> photoAsset = const Value.absent(),
                Value<String> photoUrl = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String?> nextTier = const Value.absent(),
                Value<int> pointsToNextTier = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<double> tierProgress = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
                Value<int> rewardsCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                photoAsset: photoAsset,
                photoUrl: photoUrl,
                tier: tier,
                nextTier: nextTier,
                pointsToNextTier: pointsToNextTier,
                totalPoints: totalPoints,
                tierProgress: tierProgress,
                notificationCount: notificationCount,
                rewardsCount: rewardsCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> photoAsset = const Value.absent(),
                Value<String> photoUrl = const Value.absent(),
                required String tier,
                Value<String?> nextTier = const Value.absent(),
                Value<int> pointsToNextTier = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<double> tierProgress = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
                Value<int> rewardsCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                photoAsset: photoAsset,
                photoUrl: photoUrl,
                tier: tier,
                nextTier: nextTier,
                pointsToNextTier: pointsToNextTier,
                totalPoints: totalPoints,
                tierProgress: tierProgress,
                notificationCount: notificationCount,
                rewardsCount: rewardsCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      MemberRow,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
      MemberRow,
      PrefetchHooks Function()
    >;
typedef $$ChallengesTableCreateCompanionBuilder =
    ChallengesCompanion Function({
      required String id,
      required String title,
      required String artKind,
      required String tab,
      required int progress,
      required int target,
      required int rewardPoints,
      Value<String> imageAsset,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$ChallengesTableUpdateCompanionBuilder =
    ChallengesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> artKind,
      Value<String> tab,
      Value<int> progress,
      Value<int> target,
      Value<int> rewardPoints,
      Value<String> imageAsset,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$ChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artKind => $composableBuilder(
    column: $table.artKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artKind => $composableBuilder(
    column: $table.artKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artKind =>
      $composableBuilder(column: $table.artKind, builder: (column) => column);

  GeneratedColumn<String> get tab =>
      $composableBuilder(column: $table.tab, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ChallengesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengesTable,
          ChallengeRow,
          $$ChallengesTableFilterComposer,
          $$ChallengesTableOrderingComposer,
          $$ChallengesTableAnnotationComposer,
          $$ChallengesTableCreateCompanionBuilder,
          $$ChallengesTableUpdateCompanionBuilder,
          (
            ChallengeRow,
            BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>,
          ),
          ChallengeRow,
          PrefetchHooks Function()
        > {
  $$ChallengesTableTableManager(_$AppDatabase db, $ChallengesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> artKind = const Value.absent(),
                Value<String> tab = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<int> rewardPoints = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion(
                id: id,
                title: title,
                artKind: artKind,
                tab: tab,
                progress: progress,
                target: target,
                rewardPoints: rewardPoints,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String artKind,
                required String tab,
                required int progress,
                required int target,
                required int rewardPoints,
                Value<String> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion.insert(
                id: id,
                title: title,
                artKind: artKind,
                tab: tab,
                progress: progress,
                target: target,
                rewardPoints: rewardPoints,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChallengesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengesTable,
      ChallengeRow,
      $$ChallengesTableFilterComposer,
      $$ChallengesTableOrderingComposer,
      $$ChallengesTableAnnotationComposer,
      $$ChallengesTableCreateCompanionBuilder,
      $$ChallengesTableUpdateCompanionBuilder,
      (
        ChallengeRow,
        BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>,
      ),
      ChallengeRow,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String phone,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<DateTime?> dateOfBirth,
      Value<bool> isComplete,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> phone,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<DateTime?> dateOfBirth,
      Value<bool> isComplete,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isComplete => $composableBuilder(
    column: $table.isComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isComplete => $composableBuilder(
    column: $table.isComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isComplete => $composableBuilder(
    column: $table.isComplete,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
          UserRow,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> phone = const Value.absent(),
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<bool> isComplete = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                isComplete: isComplete,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String phone,
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<bool> isComplete = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                isComplete: isComplete,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
      UserRow,
      PrefetchHooks Function()
    >;
typedef $$AppMetaTableCreateCompanionBuilder =
    AppMetaCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppMetaTableUpdateCompanionBuilder =
    AppMetaCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaRow,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaRow,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>,
          ),
          AppMetaRow,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) =>
                  AppMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaRow,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaRow, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>),
      AppMetaRow,
      PrefetchHooks Function()
    >;
typedef $$CartItemsTableCreateCompanionBuilder =
    CartItemsCompanion Function({
      required String productId,
      required int quantity,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CartItemsTableUpdateCompanionBuilder =
    CartItemsCompanion Function({
      Value<String> productId,
      Value<int> quantity,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CartItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemsTable,
          CartItemRow,
          $$CartItemsTableFilterComposer,
          $$CartItemsTableOrderingComposer,
          $$CartItemsTableAnnotationComposer,
          $$CartItemsTableCreateCompanionBuilder,
          $$CartItemsTableUpdateCompanionBuilder,
          (
            CartItemRow,
            BaseReferences<_$AppDatabase, $CartItemsTable, CartItemRow>,
          ),
          CartItemRow,
          PrefetchHooks Function()
        > {
  $$CartItemsTableTableManager(_$AppDatabase db, $CartItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CartItemsCompanion(
                productId: productId,
                quantity: quantity,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productId,
                required int quantity,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CartItemsCompanion.insert(
                productId: productId,
                quantity: quantity,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemsTable,
      CartItemRow,
      $$CartItemsTableFilterComposer,
      $$CartItemsTableOrderingComposer,
      $$CartItemsTableAnnotationComposer,
      $$CartItemsTableCreateCompanionBuilder,
      $$CartItemsTableUpdateCompanionBuilder,
      (
        CartItemRow,
        BaseReferences<_$AppDatabase, $CartItemsTable, CartItemRow>,
      ),
      CartItemRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$BannersTableTableManager get banners =>
      $$BannersTableTableManager(_db, _db.banners);
  $$HomeSectionsTableTableManager get homeSections =>
      $$HomeSectionsTableTableManager(_db, _db.homeSections);
  $$HomeSectionItemsTableTableManager get homeSectionItems =>
      $$HomeSectionItemsTableTableManager(_db, _db.homeSectionItems);
  $$ShopsTableTableManager get shops =>
      $$ShopsTableTableManager(_db, _db.shops);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db, _db.challenges);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db, _db.cartItems);
}
