// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OshisTable extends Oshis with TableInfo<$OshisTable, Oshi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OshisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  @override
  late final GeneratedColumn<String> birthday = GeneratedColumn<String>(
    'birthday',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
    'memo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _youtubeChannelIdMeta = const VerificationMeta(
    'youtubeChannelId',
  );
  @override
  late final GeneratedColumn<String> youtubeChannelId = GeneratedColumn<String>(
    'youtube_channel_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    groupName,
    color,
    birthday,
    memo,
    imagePath,
    youtubeChannelId,
    isFavorite,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'oshis';
  @override
  VerificationContext validateIntegrity(
    Insertable<Oshi> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    }
    if (data.containsKey('memo')) {
      context.handle(
        _memoMeta,
        memo.isAcceptableOrUnknown(data['memo']!, _memoMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('youtube_channel_id')) {
      context.handle(
        _youtubeChannelIdMeta,
        youtubeChannelId.isAcceptableOrUnknown(
          data['youtube_channel_id']!,
          _youtubeChannelIdMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Oshi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Oshi(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      birthday: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birthday'],
      ),
      memo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      youtubeChannelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}youtube_channel_id'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OshisTable createAlias(String alias) {
    return $OshisTable(attachedDatabase, alias);
  }
}

class Oshi extends DataClass implements Insertable<Oshi> {
  final int id;
  final String name;
  final String? groupName;
  final String? color;
  final String? birthday;
  final String? memo;
  final String? imagePath;
  final String? youtubeChannelId;
  final bool isFavorite;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Oshi({
    required this.id,
    required this.name,
    this.groupName,
    this.color,
    this.birthday,
    this.memo,
    this.imagePath,
    this.youtubeChannelId,
    required this.isFavorite,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || groupName != null) {
      map['group_name'] = Variable<String>(groupName);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<String>(birthday);
    }
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || youtubeChannelId != null) {
      map['youtube_channel_id'] = Variable<String>(youtubeChannelId);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OshisCompanion toCompanion(bool nullToAbsent) {
    return OshisCompanion(
      id: Value(id),
      name: Value(name),
      groupName: groupName == null && nullToAbsent
          ? const Value.absent()
          : Value(groupName),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      youtubeChannelId: youtubeChannelId == null && nullToAbsent
          ? const Value.absent()
          : Value(youtubeChannelId),
      isFavorite: Value(isFavorite),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Oshi.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Oshi(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      groupName: serializer.fromJson<String?>(json['groupName']),
      color: serializer.fromJson<String?>(json['color']),
      birthday: serializer.fromJson<String?>(json['birthday']),
      memo: serializer.fromJson<String?>(json['memo']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      youtubeChannelId: serializer.fromJson<String?>(json['youtubeChannelId']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'groupName': serializer.toJson<String?>(groupName),
      'color': serializer.toJson<String?>(color),
      'birthday': serializer.toJson<String?>(birthday),
      'memo': serializer.toJson<String?>(memo),
      'imagePath': serializer.toJson<String?>(imagePath),
      'youtubeChannelId': serializer.toJson<String?>(youtubeChannelId),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Oshi copyWith({
    int? id,
    String? name,
    Value<String?> groupName = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> birthday = const Value.absent(),
    Value<String?> memo = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    Value<String?> youtubeChannelId = const Value.absent(),
    bool? isFavorite,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Oshi(
    id: id ?? this.id,
    name: name ?? this.name,
    groupName: groupName.present ? groupName.value : this.groupName,
    color: color.present ? color.value : this.color,
    birthday: birthday.present ? birthday.value : this.birthday,
    memo: memo.present ? memo.value : this.memo,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    youtubeChannelId: youtubeChannelId.present
        ? youtubeChannelId.value
        : this.youtubeChannelId,
    isFavorite: isFavorite ?? this.isFavorite,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Oshi copyWithCompanion(OshisCompanion data) {
    return Oshi(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      color: data.color.present ? data.color.value : this.color,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      memo: data.memo.present ? data.memo.value : this.memo,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      youtubeChannelId: data.youtubeChannelId.present
          ? data.youtubeChannelId.value
          : this.youtubeChannelId,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Oshi(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('color: $color, ')
          ..write('birthday: $birthday, ')
          ..write('memo: $memo, ')
          ..write('imagePath: $imagePath, ')
          ..write('youtubeChannelId: $youtubeChannelId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    groupName,
    color,
    birthday,
    memo,
    imagePath,
    youtubeChannelId,
    isFavorite,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Oshi &&
          other.id == this.id &&
          other.name == this.name &&
          other.groupName == this.groupName &&
          other.color == this.color &&
          other.birthday == this.birthday &&
          other.memo == this.memo &&
          other.imagePath == this.imagePath &&
          other.youtubeChannelId == this.youtubeChannelId &&
          other.isFavorite == this.isFavorite &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OshisCompanion extends UpdateCompanion<Oshi> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> groupName;
  final Value<String?> color;
  final Value<String?> birthday;
  final Value<String?> memo;
  final Value<String?> imagePath;
  final Value<String?> youtubeChannelId;
  final Value<bool> isFavorite;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OshisCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.groupName = const Value.absent(),
    this.color = const Value.absent(),
    this.birthday = const Value.absent(),
    this.memo = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.youtubeChannelId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OshisCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.groupName = const Value.absent(),
    this.color = const Value.absent(),
    this.birthday = const Value.absent(),
    this.memo = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.youtubeChannelId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Oshi> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? groupName,
    Expression<String>? color,
    Expression<String>? birthday,
    Expression<String>? memo,
    Expression<String>? imagePath,
    Expression<String>? youtubeChannelId,
    Expression<bool>? isFavorite,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (groupName != null) 'group_name': groupName,
      if (color != null) 'color': color,
      if (birthday != null) 'birthday': birthday,
      if (memo != null) 'memo': memo,
      if (imagePath != null) 'image_path': imagePath,
      if (youtubeChannelId != null) 'youtube_channel_id': youtubeChannelId,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OshisCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? groupName,
    Value<String?>? color,
    Value<String?>? birthday,
    Value<String?>? memo,
    Value<String?>? imagePath,
    Value<String?>? youtubeChannelId,
    Value<bool>? isFavorite,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return OshisCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      groupName: groupName ?? this.groupName,
      color: color ?? this.color,
      birthday: birthday ?? this.birthday,
      memo: memo ?? this.memo,
      imagePath: imagePath ?? this.imagePath,
      youtubeChannelId: youtubeChannelId ?? this.youtubeChannelId,
      isFavorite: isFavorite ?? this.isFavorite,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (youtubeChannelId.present) {
      map['youtube_channel_id'] = Variable<String>(youtubeChannelId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OshisCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('color: $color, ')
          ..write('birthday: $birthday, ')
          ..write('memo: $memo, ')
          ..write('imagePath: $imagePath, ')
          ..write('youtubeChannelId: $youtubeChannelId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $YoutubeItemsTable extends YoutubeItems
    with TableInfo<$YoutubeItemsTable, YoutubeItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $YoutubeItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _oshiIdMeta = const VerificationMeta('oshiId');
  @override
  late final GeneratedColumn<int> oshiId = GeneratedColumn<int>(
    'oshi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES oshis (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _videoIdMeta = const VerificationMeta(
    'videoId',
  );
  @override
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailUrlMeta = const VerificationMeta(
    'thumbnailUrl',
  );
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
    'thumbnail_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    oshiId,
    videoId,
    title,
    publishedAt,
    thumbnailUrl,
    isRead,
    isFavorite,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'youtube_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<YoutubeItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('oshi_id')) {
      context.handle(
        _oshiIdMeta,
        oshiId.isAcceptableOrUnknown(data['oshi_id']!, _oshiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_oshiIdMeta);
    }
    if (data.containsKey('video_id')) {
      context.handle(
        _videoIdMeta,
        videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
        _thumbnailUrlMeta,
        thumbnailUrl.isAcceptableOrUnknown(
          data['thumbnail_url']!,
          _thumbnailUrlMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  YoutubeItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return YoutubeItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      oshiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oshi_id'],
      )!,
      videoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      )!,
      thumbnailUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_url'],
      ),
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $YoutubeItemsTable createAlias(String alias) {
    return $YoutubeItemsTable(attachedDatabase, alias);
  }
}

class YoutubeItem extends DataClass implements Insertable<YoutubeItem> {
  final int id;
  final int oshiId;
  final String videoId;
  final String title;
  final DateTime publishedAt;
  final String? thumbnailUrl;
  final bool isRead;
  final bool isFavorite;
  final DateTime createdAt;
  const YoutubeItem({
    required this.id,
    required this.oshiId,
    required this.videoId,
    required this.title,
    required this.publishedAt,
    this.thumbnailUrl,
    required this.isRead,
    required this.isFavorite,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['oshi_id'] = Variable<int>(oshiId);
    map['video_id'] = Variable<String>(videoId);
    map['title'] = Variable<String>(title);
    map['published_at'] = Variable<DateTime>(publishedAt);
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    map['is_read'] = Variable<bool>(isRead);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  YoutubeItemsCompanion toCompanion(bool nullToAbsent) {
    return YoutubeItemsCompanion(
      id: Value(id),
      oshiId: Value(oshiId),
      videoId: Value(videoId),
      title: Value(title),
      publishedAt: Value(publishedAt),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      isRead: Value(isRead),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
    );
  }

  factory YoutubeItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return YoutubeItem(
      id: serializer.fromJson<int>(json['id']),
      oshiId: serializer.fromJson<int>(json['oshiId']),
      videoId: serializer.fromJson<String>(json['videoId']),
      title: serializer.fromJson<String>(json['title']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'oshiId': serializer.toJson<int>(oshiId),
      'videoId': serializer.toJson<String>(videoId),
      'title': serializer.toJson<String>(title),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'isRead': serializer.toJson<bool>(isRead),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  YoutubeItem copyWith({
    int? id,
    int? oshiId,
    String? videoId,
    String? title,
    DateTime? publishedAt,
    Value<String?> thumbnailUrl = const Value.absent(),
    bool? isRead,
    bool? isFavorite,
    DateTime? createdAt,
  }) => YoutubeItem(
    id: id ?? this.id,
    oshiId: oshiId ?? this.oshiId,
    videoId: videoId ?? this.videoId,
    title: title ?? this.title,
    publishedAt: publishedAt ?? this.publishedAt,
    thumbnailUrl: thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
    isRead: isRead ?? this.isRead,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
  );
  YoutubeItem copyWithCompanion(YoutubeItemsCompanion data) {
    return YoutubeItem(
      id: data.id.present ? data.id.value : this.id,
      oshiId: data.oshiId.present ? data.oshiId.value : this.oshiId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      title: data.title.present ? data.title.value : this.title,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('YoutubeItem(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('videoId: $videoId, ')
          ..write('title: $title, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('isRead: $isRead, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    oshiId,
    videoId,
    title,
    publishedAt,
    thumbnailUrl,
    isRead,
    isFavorite,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YoutubeItem &&
          other.id == this.id &&
          other.oshiId == this.oshiId &&
          other.videoId == this.videoId &&
          other.title == this.title &&
          other.publishedAt == this.publishedAt &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.isRead == this.isRead &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt);
}

class YoutubeItemsCompanion extends UpdateCompanion<YoutubeItem> {
  final Value<int> id;
  final Value<int> oshiId;
  final Value<String> videoId;
  final Value<String> title;
  final Value<DateTime> publishedAt;
  final Value<String?> thumbnailUrl;
  final Value<bool> isRead;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  const YoutubeItemsCompanion({
    this.id = const Value.absent(),
    this.oshiId = const Value.absent(),
    this.videoId = const Value.absent(),
    this.title = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  YoutubeItemsCompanion.insert({
    this.id = const Value.absent(),
    required int oshiId,
    required String videoId,
    required String title,
    required DateTime publishedAt,
    this.thumbnailUrl = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : oshiId = Value(oshiId),
       videoId = Value(videoId),
       title = Value(title),
       publishedAt = Value(publishedAt);
  static Insertable<YoutubeItem> custom({
    Expression<int>? id,
    Expression<int>? oshiId,
    Expression<String>? videoId,
    Expression<String>? title,
    Expression<DateTime>? publishedAt,
    Expression<String>? thumbnailUrl,
    Expression<bool>? isRead,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (oshiId != null) 'oshi_id': oshiId,
      if (videoId != null) 'video_id': videoId,
      if (title != null) 'title': title,
      if (publishedAt != null) 'published_at': publishedAt,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (isRead != null) 'is_read': isRead,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  YoutubeItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? oshiId,
    Value<String>? videoId,
    Value<String>? title,
    Value<DateTime>? publishedAt,
    Value<String?>? thumbnailUrl,
    Value<bool>? isRead,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
  }) {
    return YoutubeItemsCompanion(
      id: id ?? this.id,
      oshiId: oshiId ?? this.oshiId,
      videoId: videoId ?? this.videoId,
      title: title ?? this.title,
      publishedAt: publishedAt ?? this.publishedAt,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isRead: isRead ?? this.isRead,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (oshiId.present) {
      map['oshi_id'] = Variable<int>(oshiId.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('YoutubeItemsCompanion(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('videoId: $videoId, ')
          ..write('title: $title, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('isRead: $isRead, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DiaryEntriesTable extends DiaryEntries
    with TableInfo<$DiaryEntriesTable, DiaryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _oshiIdMeta = const VerificationMeta('oshiId');
  @override
  late final GeneratedColumn<int> oshiId = GeneratedColumn<int>(
    'oshi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES oshis (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    oshiId,
    content,
    imagePath,
    tags,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diary_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiaryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('oshi_id')) {
      context.handle(
        _oshiIdMeta,
        oshiId.isAcceptableOrUnknown(data['oshi_id']!, _oshiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_oshiIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      oshiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oshi_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DiaryEntriesTable createAlias(String alias) {
    return $DiaryEntriesTable(attachedDatabase, alias);
  }
}

class DiaryEntry extends DataClass implements Insertable<DiaryEntry> {
  final int id;
  final int oshiId;
  final String content;
  final String? imagePath;
  final String? tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DiaryEntry({
    required this.id,
    required this.oshiId,
    required this.content,
    this.imagePath,
    this.tags,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['oshi_id'] = Variable<int>(oshiId);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DiaryEntriesCompanion toCompanion(bool nullToAbsent) {
    return DiaryEntriesCompanion(
      id: Value(id),
      oshiId: Value(oshiId),
      content: Value(content),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DiaryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryEntry(
      id: serializer.fromJson<int>(json['id']),
      oshiId: serializer.fromJson<int>(json['oshiId']),
      content: serializer.fromJson<String>(json['content']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      tags: serializer.fromJson<String?>(json['tags']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'oshiId': serializer.toJson<int>(oshiId),
      'content': serializer.toJson<String>(content),
      'imagePath': serializer.toJson<String?>(imagePath),
      'tags': serializer.toJson<String?>(tags),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DiaryEntry copyWith({
    int? id,
    int? oshiId,
    String? content,
    Value<String?> imagePath = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DiaryEntry(
    id: id ?? this.id,
    oshiId: oshiId ?? this.oshiId,
    content: content ?? this.content,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    tags: tags.present ? tags.value : this.tags,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DiaryEntry copyWithCompanion(DiaryEntriesCompanion data) {
    return DiaryEntry(
      id: data.id.present ? data.id.value : this.id,
      oshiId: data.oshiId.present ? data.oshiId.value : this.oshiId,
      content: data.content.present ? data.content.value : this.content,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiaryEntry(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('content: $content, ')
          ..write('imagePath: $imagePath, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, oshiId, content, imagePath, tags, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryEntry &&
          other.id == this.id &&
          other.oshiId == this.oshiId &&
          other.content == this.content &&
          other.imagePath == this.imagePath &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DiaryEntriesCompanion extends UpdateCompanion<DiaryEntry> {
  final Value<int> id;
  final Value<int> oshiId;
  final Value<String> content;
  final Value<String?> imagePath;
  final Value<String?> tags;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DiaryEntriesCompanion({
    this.id = const Value.absent(),
    this.oshiId = const Value.absent(),
    this.content = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DiaryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int oshiId,
    required String content,
    this.imagePath = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : oshiId = Value(oshiId),
       content = Value(content);
  static Insertable<DiaryEntry> custom({
    Expression<int>? id,
    Expression<int>? oshiId,
    Expression<String>? content,
    Expression<String>? imagePath,
    Expression<String>? tags,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (oshiId != null) 'oshi_id': oshiId,
      if (content != null) 'content': content,
      if (imagePath != null) 'image_path': imagePath,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DiaryEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? oshiId,
    Value<String>? content,
    Value<String?>? imagePath,
    Value<String?>? tags,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return DiaryEntriesCompanion(
      id: id ?? this.id,
      oshiId: oshiId ?? this.oshiId,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (oshiId.present) {
      map['oshi_id'] = Variable<int>(oshiId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('content: $content, ')
          ..write('imagePath: $imagePath, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GoodsTable extends Goods with TableInfo<$GoodsTable, Good> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _oshiIdMeta = const VerificationMeta('oshiId');
  @override
  late final GeneratedColumn<int> oshiId = GeneratedColumn<int>(
    'oshi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES oshis (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('want'),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
    'memo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    oshiId,
    name,
    price,
    status,
    imagePath,
    memo,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goods';
  @override
  VerificationContext validateIntegrity(
    Insertable<Good> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('oshi_id')) {
      context.handle(
        _oshiIdMeta,
        oshiId.isAcceptableOrUnknown(data['oshi_id']!, _oshiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_oshiIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('memo')) {
      context.handle(
        _memoMeta,
        memo.isAcceptableOrUnknown(data['memo']!, _memoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Good map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Good(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      oshiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oshi_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      memo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GoodsTable createAlias(String alias) {
    return $GoodsTable(attachedDatabase, alias);
  }
}

class Good extends DataClass implements Insertable<Good> {
  final int id;
  final int oshiId;
  final String name;
  final int? price;
  final String status;
  final String? imagePath;
  final String? memo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Good({
    required this.id,
    required this.oshiId,
    required this.name,
    this.price,
    required this.status,
    this.imagePath,
    this.memo,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['oshi_id'] = Variable<int>(oshiId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GoodsCompanion toCompanion(bool nullToAbsent) {
    return GoodsCompanion(
      id: Value(id),
      oshiId: Value(oshiId),
      name: Value(name),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      status: Value(status),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Good.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Good(
      id: serializer.fromJson<int>(json['id']),
      oshiId: serializer.fromJson<int>(json['oshiId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int?>(json['price']),
      status: serializer.fromJson<String>(json['status']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      memo: serializer.fromJson<String?>(json['memo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'oshiId': serializer.toJson<int>(oshiId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<int?>(price),
      'status': serializer.toJson<String>(status),
      'imagePath': serializer.toJson<String?>(imagePath),
      'memo': serializer.toJson<String?>(memo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Good copyWith({
    int? id,
    int? oshiId,
    String? name,
    Value<int?> price = const Value.absent(),
    String? status,
    Value<String?> imagePath = const Value.absent(),
    Value<String?> memo = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Good(
    id: id ?? this.id,
    oshiId: oshiId ?? this.oshiId,
    name: name ?? this.name,
    price: price.present ? price.value : this.price,
    status: status ?? this.status,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    memo: memo.present ? memo.value : this.memo,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Good copyWithCompanion(GoodsCompanion data) {
    return Good(
      id: data.id.present ? data.id.value : this.id,
      oshiId: data.oshiId.present ? data.oshiId.value : this.oshiId,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      status: data.status.present ? data.status.value : this.status,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      memo: data.memo.present ? data.memo.value : this.memo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Good(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('status: $status, ')
          ..write('imagePath: $imagePath, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    oshiId,
    name,
    price,
    status,
    imagePath,
    memo,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Good &&
          other.id == this.id &&
          other.oshiId == this.oshiId &&
          other.name == this.name &&
          other.price == this.price &&
          other.status == this.status &&
          other.imagePath == this.imagePath &&
          other.memo == this.memo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoodsCompanion extends UpdateCompanion<Good> {
  final Value<int> id;
  final Value<int> oshiId;
  final Value<String> name;
  final Value<int?> price;
  final Value<String> status;
  final Value<String?> imagePath;
  final Value<String?> memo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GoodsCompanion({
    this.id = const Value.absent(),
    this.oshiId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.status = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GoodsCompanion.insert({
    this.id = const Value.absent(),
    required int oshiId,
    required String name,
    this.price = const Value.absent(),
    this.status = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : oshiId = Value(oshiId),
       name = Value(name);
  static Insertable<Good> custom({
    Expression<int>? id,
    Expression<int>? oshiId,
    Expression<String>? name,
    Expression<int>? price,
    Expression<String>? status,
    Expression<String>? imagePath,
    Expression<String>? memo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (oshiId != null) 'oshi_id': oshiId,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (status != null) 'status': status,
      if (imagePath != null) 'image_path': imagePath,
      if (memo != null) 'memo': memo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GoodsCompanion copyWith({
    Value<int>? id,
    Value<int>? oshiId,
    Value<String>? name,
    Value<int?>? price,
    Value<String>? status,
    Value<String?>? imagePath,
    Value<String?>? memo,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return GoodsCompanion(
      id: id ?? this.id,
      oshiId: oshiId ?? this.oshiId,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath,
      memo: memo ?? this.memo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (oshiId.present) {
      map['oshi_id'] = Variable<int>(oshiId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoodsCompanion(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('status: $status, ')
          ..write('imagePath: $imagePath, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _oshiIdMeta = const VerificationMeta('oshiId');
  @override
  late final GeneratedColumn<int> oshiId = GeneratedColumn<int>(
    'oshi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES oshis (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _eventDateMeta = const VerificationMeta(
    'eventDate',
  );
  @override
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
    'event_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _notificationEnabledMeta =
      const VerificationMeta('notificationEnabled');
  @override
  late final GeneratedColumn<bool> notificationEnabled = GeneratedColumn<bool>(
    'notification_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notification_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
    'memo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    oshiId,
    title,
    eventDate,
    eventType,
    notificationEnabled,
    memo,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<Schedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('oshi_id')) {
      context.handle(
        _oshiIdMeta,
        oshiId.isAcceptableOrUnknown(data['oshi_id']!, _oshiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_oshiIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('event_date')) {
      context.handle(
        _eventDateMeta,
        eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta),
      );
    } else if (isInserting) {
      context.missing(_eventDateMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    }
    if (data.containsKey('notification_enabled')) {
      context.handle(
        _notificationEnabledMeta,
        notificationEnabled.isAcceptableOrUnknown(
          data['notification_enabled']!,
          _notificationEnabledMeta,
        ),
      );
    }
    if (data.containsKey('memo')) {
      context.handle(
        _memoMeta,
        memo.isAcceptableOrUnknown(data['memo']!, _memoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      oshiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oshi_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      eventDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}event_date'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      notificationEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_enabled'],
      )!,
      memo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final int oshiId;
  final String title;
  final DateTime eventDate;
  final String eventType;
  final bool notificationEnabled;
  final String? memo;
  final DateTime createdAt;
  const Schedule({
    required this.id,
    required this.oshiId,
    required this.title,
    required this.eventDate,
    required this.eventType,
    required this.notificationEnabled,
    this.memo,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['oshi_id'] = Variable<int>(oshiId);
    map['title'] = Variable<String>(title);
    map['event_date'] = Variable<DateTime>(eventDate);
    map['event_type'] = Variable<String>(eventType);
    map['notification_enabled'] = Variable<bool>(notificationEnabled);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      oshiId: Value(oshiId),
      title: Value(title),
      eventDate: Value(eventDate),
      eventType: Value(eventType),
      notificationEnabled: Value(notificationEnabled),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      createdAt: Value(createdAt),
    );
  }

  factory Schedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      oshiId: serializer.fromJson<int>(json['oshiId']),
      title: serializer.fromJson<String>(json['title']),
      eventDate: serializer.fromJson<DateTime>(json['eventDate']),
      eventType: serializer.fromJson<String>(json['eventType']),
      notificationEnabled: serializer.fromJson<bool>(
        json['notificationEnabled'],
      ),
      memo: serializer.fromJson<String?>(json['memo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'oshiId': serializer.toJson<int>(oshiId),
      'title': serializer.toJson<String>(title),
      'eventDate': serializer.toJson<DateTime>(eventDate),
      'eventType': serializer.toJson<String>(eventType),
      'notificationEnabled': serializer.toJson<bool>(notificationEnabled),
      'memo': serializer.toJson<String?>(memo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Schedule copyWith({
    int? id,
    int? oshiId,
    String? title,
    DateTime? eventDate,
    String? eventType,
    bool? notificationEnabled,
    Value<String?> memo = const Value.absent(),
    DateTime? createdAt,
  }) => Schedule(
    id: id ?? this.id,
    oshiId: oshiId ?? this.oshiId,
    title: title ?? this.title,
    eventDate: eventDate ?? this.eventDate,
    eventType: eventType ?? this.eventType,
    notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    memo: memo.present ? memo.value : this.memo,
    createdAt: createdAt ?? this.createdAt,
  );
  Schedule copyWithCompanion(SchedulesCompanion data) {
    return Schedule(
      id: data.id.present ? data.id.value : this.id,
      oshiId: data.oshiId.present ? data.oshiId.value : this.oshiId,
      title: data.title.present ? data.title.value : this.title,
      eventDate: data.eventDate.present ? data.eventDate.value : this.eventDate,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      notificationEnabled: data.notificationEnabled.present
          ? data.notificationEnabled.value
          : this.notificationEnabled,
      memo: data.memo.present ? data.memo.value : this.memo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('title: $title, ')
          ..write('eventDate: $eventDate, ')
          ..write('eventType: $eventType, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    oshiId,
    title,
    eventDate,
    eventType,
    notificationEnabled,
    memo,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.oshiId == this.oshiId &&
          other.title == this.title &&
          other.eventDate == this.eventDate &&
          other.eventType == this.eventType &&
          other.notificationEnabled == this.notificationEnabled &&
          other.memo == this.memo &&
          other.createdAt == this.createdAt);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<int> oshiId;
  final Value<String> title;
  final Value<DateTime> eventDate;
  final Value<String> eventType;
  final Value<bool> notificationEnabled;
  final Value<String?> memo;
  final Value<DateTime> createdAt;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.oshiId = const Value.absent(),
    this.title = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.eventType = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int oshiId,
    required String title,
    required DateTime eventDate,
    this.eventType = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : oshiId = Value(oshiId),
       title = Value(title),
       eventDate = Value(eventDate);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<int>? oshiId,
    Expression<String>? title,
    Expression<DateTime>? eventDate,
    Expression<String>? eventType,
    Expression<bool>? notificationEnabled,
    Expression<String>? memo,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (oshiId != null) 'oshi_id': oshiId,
      if (title != null) 'title': title,
      if (eventDate != null) 'event_date': eventDate,
      if (eventType != null) 'event_type': eventType,
      if (notificationEnabled != null)
        'notification_enabled': notificationEnabled,
      if (memo != null) 'memo': memo,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? oshiId,
    Value<String>? title,
    Value<DateTime>? eventDate,
    Value<String>? eventType,
    Value<bool>? notificationEnabled,
    Value<String?>? memo,
    Value<DateTime>? createdAt,
  }) {
    return SchedulesCompanion(
      id: id ?? this.id,
      oshiId: oshiId ?? this.oshiId,
      title: title ?? this.title,
      eventDate: eventDate ?? this.eventDate,
      eventType: eventType ?? this.eventType,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      memo: memo ?? this.memo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (oshiId.present) {
      map['oshi_id'] = Variable<int>(oshiId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (notificationEnabled.present) {
      map['notification_enabled'] = Variable<bool>(notificationEnabled.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('oshiId: $oshiId, ')
          ..write('title: $title, ')
          ..write('eventDate: $eventDate, ')
          ..write('eventType: $eventType, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OshisTable oshis = $OshisTable(this);
  late final $YoutubeItemsTable youtubeItems = $YoutubeItemsTable(this);
  late final $DiaryEntriesTable diaryEntries = $DiaryEntriesTable(this);
  late final $GoodsTable goods = $GoodsTable(this);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    oshis,
    youtubeItems,
    diaryEntries,
    goods,
    schedules,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('youtube_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('youtube_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('diary_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('diary_entries', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goods', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('goods', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('schedules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'oshis',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('schedules', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$OshisTableCreateCompanionBuilder =
    OshisCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> groupName,
      Value<String?> color,
      Value<String?> birthday,
      Value<String?> memo,
      Value<String?> imagePath,
      Value<String?> youtubeChannelId,
      Value<bool> isFavorite,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$OshisTableUpdateCompanionBuilder =
    OshisCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> groupName,
      Value<String?> color,
      Value<String?> birthday,
      Value<String?> memo,
      Value<String?> imagePath,
      Value<String?> youtubeChannelId,
      Value<bool> isFavorite,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$OshisTableReferences
    extends BaseReferences<_$AppDatabase, $OshisTable, Oshi> {
  $$OshisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$YoutubeItemsTable, List<YoutubeItem>>
  _youtubeItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.youtubeItems,
    aliasName: $_aliasNameGenerator(db.oshis.id, db.youtubeItems.oshiId),
  );

  $$YoutubeItemsTableProcessedTableManager get youtubeItemsRefs {
    final manager = $$YoutubeItemsTableTableManager(
      $_db,
      $_db.youtubeItems,
    ).filter((f) => f.oshiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_youtubeItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DiaryEntriesTable, List<DiaryEntry>>
  _diaryEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.diaryEntries,
    aliasName: $_aliasNameGenerator(db.oshis.id, db.diaryEntries.oshiId),
  );

  $$DiaryEntriesTableProcessedTableManager get diaryEntriesRefs {
    final manager = $$DiaryEntriesTableTableManager(
      $_db,
      $_db.diaryEntries,
    ).filter((f) => f.oshiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_diaryEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GoodsTable, List<Good>> _goodsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goods,
    aliasName: $_aliasNameGenerator(db.oshis.id, db.goods.oshiId),
  );

  $$GoodsTableProcessedTableManager get goodsRefs {
    final manager = $$GoodsTableTableManager(
      $_db,
      $_db.goods,
    ).filter((f) => f.oshiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_goodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SchedulesTable, List<Schedule>>
  _schedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.schedules,
    aliasName: $_aliasNameGenerator(db.oshis.id, db.schedules.oshiId),
  );

  $$SchedulesTableProcessedTableManager get schedulesRefs {
    final manager = $$SchedulesTableTableManager(
      $_db,
      $_db.schedules,
    ).filter((f) => f.oshiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_schedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OshisTableFilterComposer extends Composer<_$AppDatabase, $OshisTable> {
  $$OshisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get youtubeChannelId => $composableBuilder(
    column: $table.youtubeChannelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> youtubeItemsRefs(
    Expression<bool> Function($$YoutubeItemsTableFilterComposer f) f,
  ) {
    final $$YoutubeItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.youtubeItems,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$YoutubeItemsTableFilterComposer(
            $db: $db,
            $table: $db.youtubeItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> diaryEntriesRefs(
    Expression<bool> Function($$DiaryEntriesTableFilterComposer f) f,
  ) {
    final $$DiaryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diaryEntries,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiaryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.diaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goodsRefs(
    Expression<bool> Function($$GoodsTableFilterComposer f) f,
  ) {
    final $$GoodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goods,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoodsTableFilterComposer(
            $db: $db,
            $table: $db.goods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> schedulesRefs(
    Expression<bool> Function($$SchedulesTableFilterComposer f) f,
  ) {
    final $$SchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableFilterComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OshisTableOrderingComposer
    extends Composer<_$AppDatabase, $OshisTable> {
  $$OshisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get youtubeChannelId => $composableBuilder(
    column: $table.youtubeChannelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OshisTableAnnotationComposer
    extends Composer<_$AppDatabase, $OshisTable> {
  $$OshisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get youtubeChannelId => $composableBuilder(
    column: $table.youtubeChannelId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> youtubeItemsRefs<T extends Object>(
    Expression<T> Function($$YoutubeItemsTableAnnotationComposer a) f,
  ) {
    final $$YoutubeItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.youtubeItems,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$YoutubeItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.youtubeItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> diaryEntriesRefs<T extends Object>(
    Expression<T> Function($$DiaryEntriesTableAnnotationComposer a) f,
  ) {
    final $$DiaryEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diaryEntries,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiaryEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.diaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goodsRefs<T extends Object>(
    Expression<T> Function($$GoodsTableAnnotationComposer a) f,
  ) {
    final $$GoodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goods,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoodsTableAnnotationComposer(
            $db: $db,
            $table: $db.goods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> schedulesRefs<T extends Object>(
    Expression<T> Function($$SchedulesTableAnnotationComposer a) f,
  ) {
    final $$SchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.oshiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OshisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OshisTable,
          Oshi,
          $$OshisTableFilterComposer,
          $$OshisTableOrderingComposer,
          $$OshisTableAnnotationComposer,
          $$OshisTableCreateCompanionBuilder,
          $$OshisTableUpdateCompanionBuilder,
          (Oshi, $$OshisTableReferences),
          Oshi,
          PrefetchHooks Function({
            bool youtubeItemsRefs,
            bool diaryEntriesRefs,
            bool goodsRefs,
            bool schedulesRefs,
          })
        > {
  $$OshisTableTableManager(_$AppDatabase db, $OshisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OshisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OshisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OshisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> birthday = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> youtubeChannelId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OshisCompanion(
                id: id,
                name: name,
                groupName: groupName,
                color: color,
                birthday: birthday,
                memo: memo,
                imagePath: imagePath,
                youtubeChannelId: youtubeChannelId,
                isFavorite: isFavorite,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> groupName = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> birthday = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> youtubeChannelId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OshisCompanion.insert(
                id: id,
                name: name,
                groupName: groupName,
                color: color,
                birthday: birthday,
                memo: memo,
                imagePath: imagePath,
                youtubeChannelId: youtubeChannelId,
                isFavorite: isFavorite,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$OshisTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                youtubeItemsRefs = false,
                diaryEntriesRefs = false,
                goodsRefs = false,
                schedulesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (youtubeItemsRefs) db.youtubeItems,
                    if (diaryEntriesRefs) db.diaryEntries,
                    if (goodsRefs) db.goods,
                    if (schedulesRefs) db.schedules,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (youtubeItemsRefs)
                        await $_getPrefetchedData<
                          Oshi,
                          $OshisTable,
                          YoutubeItem
                        >(
                          currentTable: table,
                          referencedTable: $$OshisTableReferences
                              ._youtubeItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OshisTableReferences(
                                db,
                                table,
                                p0,
                              ).youtubeItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.oshiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (diaryEntriesRefs)
                        await $_getPrefetchedData<
                          Oshi,
                          $OshisTable,
                          DiaryEntry
                        >(
                          currentTable: table,
                          referencedTable: $$OshisTableReferences
                              ._diaryEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OshisTableReferences(
                                db,
                                table,
                                p0,
                              ).diaryEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.oshiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (goodsRefs)
                        await $_getPrefetchedData<Oshi, $OshisTable, Good>(
                          currentTable: table,
                          referencedTable: $$OshisTableReferences
                              ._goodsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OshisTableReferences(db, table, p0).goodsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.oshiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (schedulesRefs)
                        await $_getPrefetchedData<Oshi, $OshisTable, Schedule>(
                          currentTable: table,
                          referencedTable: $$OshisTableReferences
                              ._schedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OshisTableReferences(
                                db,
                                table,
                                p0,
                              ).schedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.oshiId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OshisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OshisTable,
      Oshi,
      $$OshisTableFilterComposer,
      $$OshisTableOrderingComposer,
      $$OshisTableAnnotationComposer,
      $$OshisTableCreateCompanionBuilder,
      $$OshisTableUpdateCompanionBuilder,
      (Oshi, $$OshisTableReferences),
      Oshi,
      PrefetchHooks Function({
        bool youtubeItemsRefs,
        bool diaryEntriesRefs,
        bool goodsRefs,
        bool schedulesRefs,
      })
    >;
typedef $$YoutubeItemsTableCreateCompanionBuilder =
    YoutubeItemsCompanion Function({
      Value<int> id,
      required int oshiId,
      required String videoId,
      required String title,
      required DateTime publishedAt,
      Value<String?> thumbnailUrl,
      Value<bool> isRead,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
    });
typedef $$YoutubeItemsTableUpdateCompanionBuilder =
    YoutubeItemsCompanion Function({
      Value<int> id,
      Value<int> oshiId,
      Value<String> videoId,
      Value<String> title,
      Value<DateTime> publishedAt,
      Value<String?> thumbnailUrl,
      Value<bool> isRead,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
    });

final class $$YoutubeItemsTableReferences
    extends BaseReferences<_$AppDatabase, $YoutubeItemsTable, YoutubeItem> {
  $$YoutubeItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OshisTable _oshiIdTable(_$AppDatabase db) => db.oshis.createAlias(
    $_aliasNameGenerator(db.youtubeItems.oshiId, db.oshis.id),
  );

  $$OshisTableProcessedTableManager get oshiId {
    final $_column = $_itemColumn<int>('oshi_id')!;

    final manager = $$OshisTableTableManager(
      $_db,
      $_db.oshis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_oshiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$YoutubeItemsTableFilterComposer
    extends Composer<_$AppDatabase, $YoutubeItemsTable> {
  $$YoutubeItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get videoId => $composableBuilder(
    column: $table.videoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OshisTableFilterComposer get oshiId {
    final $$OshisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableFilterComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$YoutubeItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $YoutubeItemsTable> {
  $$YoutubeItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get videoId => $composableBuilder(
    column: $table.videoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OshisTableOrderingComposer get oshiId {
    final $$OshisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableOrderingComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$YoutubeItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $YoutubeItemsTable> {
  $$YoutubeItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get videoId =>
      $composableBuilder(column: $table.videoId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OshisTableAnnotationComposer get oshiId {
    final $$OshisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableAnnotationComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$YoutubeItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $YoutubeItemsTable,
          YoutubeItem,
          $$YoutubeItemsTableFilterComposer,
          $$YoutubeItemsTableOrderingComposer,
          $$YoutubeItemsTableAnnotationComposer,
          $$YoutubeItemsTableCreateCompanionBuilder,
          $$YoutubeItemsTableUpdateCompanionBuilder,
          (YoutubeItem, $$YoutubeItemsTableReferences),
          YoutubeItem,
          PrefetchHooks Function({bool oshiId})
        > {
  $$YoutubeItemsTableTableManager(_$AppDatabase db, $YoutubeItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$YoutubeItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$YoutubeItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$YoutubeItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> oshiId = const Value.absent(),
                Value<String> videoId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> publishedAt = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => YoutubeItemsCompanion(
                id: id,
                oshiId: oshiId,
                videoId: videoId,
                title: title,
                publishedAt: publishedAt,
                thumbnailUrl: thumbnailUrl,
                isRead: isRead,
                isFavorite: isFavorite,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int oshiId,
                required String videoId,
                required String title,
                required DateTime publishedAt,
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => YoutubeItemsCompanion.insert(
                id: id,
                oshiId: oshiId,
                videoId: videoId,
                title: title,
                publishedAt: publishedAt,
                thumbnailUrl: thumbnailUrl,
                isRead: isRead,
                isFavorite: isFavorite,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$YoutubeItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({oshiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (oshiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.oshiId,
                                referencedTable: $$YoutubeItemsTableReferences
                                    ._oshiIdTable(db),
                                referencedColumn: $$YoutubeItemsTableReferences
                                    ._oshiIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$YoutubeItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $YoutubeItemsTable,
      YoutubeItem,
      $$YoutubeItemsTableFilterComposer,
      $$YoutubeItemsTableOrderingComposer,
      $$YoutubeItemsTableAnnotationComposer,
      $$YoutubeItemsTableCreateCompanionBuilder,
      $$YoutubeItemsTableUpdateCompanionBuilder,
      (YoutubeItem, $$YoutubeItemsTableReferences),
      YoutubeItem,
      PrefetchHooks Function({bool oshiId})
    >;
typedef $$DiaryEntriesTableCreateCompanionBuilder =
    DiaryEntriesCompanion Function({
      Value<int> id,
      required int oshiId,
      required String content,
      Value<String?> imagePath,
      Value<String?> tags,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$DiaryEntriesTableUpdateCompanionBuilder =
    DiaryEntriesCompanion Function({
      Value<int> id,
      Value<int> oshiId,
      Value<String> content,
      Value<String?> imagePath,
      Value<String?> tags,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$DiaryEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $DiaryEntriesTable, DiaryEntry> {
  $$DiaryEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OshisTable _oshiIdTable(_$AppDatabase db) => db.oshis.createAlias(
    $_aliasNameGenerator(db.diaryEntries.oshiId, db.oshis.id),
  );

  $$OshisTableProcessedTableManager get oshiId {
    final $_column = $_itemColumn<int>('oshi_id')!;

    final manager = $$OshisTableTableManager(
      $_db,
      $_db.oshis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_oshiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DiaryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DiaryEntriesTable> {
  $$DiaryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OshisTableFilterComposer get oshiId {
    final $$OshisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableFilterComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiaryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DiaryEntriesTable> {
  $$DiaryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OshisTableOrderingComposer get oshiId {
    final $$OshisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableOrderingComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiaryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiaryEntriesTable> {
  $$DiaryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$OshisTableAnnotationComposer get oshiId {
    final $$OshisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableAnnotationComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiaryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiaryEntriesTable,
          DiaryEntry,
          $$DiaryEntriesTableFilterComposer,
          $$DiaryEntriesTableOrderingComposer,
          $$DiaryEntriesTableAnnotationComposer,
          $$DiaryEntriesTableCreateCompanionBuilder,
          $$DiaryEntriesTableUpdateCompanionBuilder,
          (DiaryEntry, $$DiaryEntriesTableReferences),
          DiaryEntry,
          PrefetchHooks Function({bool oshiId})
        > {
  $$DiaryEntriesTableTableManager(_$AppDatabase db, $DiaryEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiaryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiaryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiaryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> oshiId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DiaryEntriesCompanion(
                id: id,
                oshiId: oshiId,
                content: content,
                imagePath: imagePath,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int oshiId,
                required String content,
                Value<String?> imagePath = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DiaryEntriesCompanion.insert(
                id: id,
                oshiId: oshiId,
                content: content,
                imagePath: imagePath,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DiaryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({oshiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (oshiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.oshiId,
                                referencedTable: $$DiaryEntriesTableReferences
                                    ._oshiIdTable(db),
                                referencedColumn: $$DiaryEntriesTableReferences
                                    ._oshiIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DiaryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiaryEntriesTable,
      DiaryEntry,
      $$DiaryEntriesTableFilterComposer,
      $$DiaryEntriesTableOrderingComposer,
      $$DiaryEntriesTableAnnotationComposer,
      $$DiaryEntriesTableCreateCompanionBuilder,
      $$DiaryEntriesTableUpdateCompanionBuilder,
      (DiaryEntry, $$DiaryEntriesTableReferences),
      DiaryEntry,
      PrefetchHooks Function({bool oshiId})
    >;
typedef $$GoodsTableCreateCompanionBuilder =
    GoodsCompanion Function({
      Value<int> id,
      required int oshiId,
      required String name,
      Value<int?> price,
      Value<String> status,
      Value<String?> imagePath,
      Value<String?> memo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$GoodsTableUpdateCompanionBuilder =
    GoodsCompanion Function({
      Value<int> id,
      Value<int> oshiId,
      Value<String> name,
      Value<int?> price,
      Value<String> status,
      Value<String?> imagePath,
      Value<String?> memo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$GoodsTableReferences
    extends BaseReferences<_$AppDatabase, $GoodsTable, Good> {
  $$GoodsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OshisTable _oshiIdTable(_$AppDatabase db) =>
      db.oshis.createAlias($_aliasNameGenerator(db.goods.oshiId, db.oshis.id));

  $$OshisTableProcessedTableManager get oshiId {
    final $_column = $_itemColumn<int>('oshi_id')!;

    final manager = $$OshisTableTableManager(
      $_db,
      $_db.oshis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_oshiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoodsTableFilterComposer extends Composer<_$AppDatabase, $GoodsTable> {
  $$GoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OshisTableFilterComposer get oshiId {
    final $$OshisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableFilterComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoodsTable> {
  $$GoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OshisTableOrderingComposer get oshiId {
    final $$OshisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableOrderingComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoodsTable> {
  $$GoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$OshisTableAnnotationComposer get oshiId {
    final $$OshisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableAnnotationComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoodsTable,
          Good,
          $$GoodsTableFilterComposer,
          $$GoodsTableOrderingComposer,
          $$GoodsTableAnnotationComposer,
          $$GoodsTableCreateCompanionBuilder,
          $$GoodsTableUpdateCompanionBuilder,
          (Good, $$GoodsTableReferences),
          Good,
          PrefetchHooks Function({bool oshiId})
        > {
  $$GoodsTableTableManager(_$AppDatabase db, $GoodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> oshiId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> price = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GoodsCompanion(
                id: id,
                oshiId: oshiId,
                name: name,
                price: price,
                status: status,
                imagePath: imagePath,
                memo: memo,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int oshiId,
                required String name,
                Value<int?> price = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GoodsCompanion.insert(
                id: id,
                oshiId: oshiId,
                name: name,
                price: price,
                status: status,
                imagePath: imagePath,
                memo: memo,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GoodsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({oshiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (oshiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.oshiId,
                                referencedTable: $$GoodsTableReferences
                                    ._oshiIdTable(db),
                                referencedColumn: $$GoodsTableReferences
                                    ._oshiIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GoodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoodsTable,
      Good,
      $$GoodsTableFilterComposer,
      $$GoodsTableOrderingComposer,
      $$GoodsTableAnnotationComposer,
      $$GoodsTableCreateCompanionBuilder,
      $$GoodsTableUpdateCompanionBuilder,
      (Good, $$GoodsTableReferences),
      Good,
      PrefetchHooks Function({bool oshiId})
    >;
typedef $$SchedulesTableCreateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      required int oshiId,
      required String title,
      required DateTime eventDate,
      Value<String> eventType,
      Value<bool> notificationEnabled,
      Value<String?> memo,
      Value<DateTime> createdAt,
    });
typedef $$SchedulesTableUpdateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      Value<int> oshiId,
      Value<String> title,
      Value<DateTime> eventDate,
      Value<String> eventType,
      Value<bool> notificationEnabled,
      Value<String?> memo,
      Value<DateTime> createdAt,
    });

final class $$SchedulesTableReferences
    extends BaseReferences<_$AppDatabase, $SchedulesTable, Schedule> {
  $$SchedulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OshisTable _oshiIdTable(_$AppDatabase db) => db.oshis.createAlias(
    $_aliasNameGenerator(db.schedules.oshiId, db.oshis.id),
  );

  $$OshisTableProcessedTableManager get oshiId {
    final $_column = $_itemColumn<int>('oshi_id')!;

    final manager = $$OshisTableTableManager(
      $_db,
      $_db.oshis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_oshiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OshisTableFilterComposer get oshiId {
    final $$OshisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableFilterComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OshisTableOrderingComposer get oshiId {
    final $$OshisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableOrderingComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get eventDate =>
      $composableBuilder(column: $table.eventDate, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OshisTableAnnotationComposer get oshiId {
    final $$OshisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.oshiId,
      referencedTable: $db.oshis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OshisTableAnnotationComposer(
            $db: $db,
            $table: $db.oshis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchedulesTable,
          Schedule,
          $$SchedulesTableFilterComposer,
          $$SchedulesTableOrderingComposer,
          $$SchedulesTableAnnotationComposer,
          $$SchedulesTableCreateCompanionBuilder,
          $$SchedulesTableUpdateCompanionBuilder,
          (Schedule, $$SchedulesTableReferences),
          Schedule,
          PrefetchHooks Function({bool oshiId})
        > {
  $$SchedulesTableTableManager(_$AppDatabase db, $SchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> oshiId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> eventDate = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<bool> notificationEnabled = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SchedulesCompanion(
                id: id,
                oshiId: oshiId,
                title: title,
                eventDate: eventDate,
                eventType: eventType,
                notificationEnabled: notificationEnabled,
                memo: memo,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int oshiId,
                required String title,
                required DateTime eventDate,
                Value<String> eventType = const Value.absent(),
                Value<bool> notificationEnabled = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SchedulesCompanion.insert(
                id: id,
                oshiId: oshiId,
                title: title,
                eventDate: eventDate,
                eventType: eventType,
                notificationEnabled: notificationEnabled,
                memo: memo,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({oshiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (oshiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.oshiId,
                                referencedTable: $$SchedulesTableReferences
                                    ._oshiIdTable(db),
                                referencedColumn: $$SchedulesTableReferences
                                    ._oshiIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchedulesTable,
      Schedule,
      $$SchedulesTableFilterComposer,
      $$SchedulesTableOrderingComposer,
      $$SchedulesTableAnnotationComposer,
      $$SchedulesTableCreateCompanionBuilder,
      $$SchedulesTableUpdateCompanionBuilder,
      (Schedule, $$SchedulesTableReferences),
      Schedule,
      PrefetchHooks Function({bool oshiId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OshisTableTableManager get oshis =>
      $$OshisTableTableManager(_db, _db.oshis);
  $$YoutubeItemsTableTableManager get youtubeItems =>
      $$YoutubeItemsTableTableManager(_db, _db.youtubeItems);
  $$DiaryEntriesTableTableManager get diaryEntries =>
      $$DiaryEntriesTableTableManager(_db, _db.diaryEntries);
  $$GoodsTableTableManager get goods =>
      $$GoodsTableTableManager(_db, _db.goods);
  $$SchedulesTableTableManager get schedules =>
      $$SchedulesTableTableManager(_db, _db.schedules);
}
