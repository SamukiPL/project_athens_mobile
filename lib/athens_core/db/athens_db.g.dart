// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'athens_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SlimDeputyVoteTypeEntityData extends DataClass
    implements Insertable<SlimDeputyVoteTypeEntityData> {
  final String votingId;
  final String deputyId;
  final int type;
  SlimDeputyVoteTypeEntityData(
      {required this.votingId, required this.deputyId, required this.type});
  factory SlimDeputyVoteTypeEntityData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SlimDeputyVoteTypeEntityData(
      votingId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}voting_id'])!,
      deputyId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deputy_id'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['voting_id'] = Variable<String>(votingId);
    map['deputy_id'] = Variable<String>(deputyId);
    map['type'] = Variable<int>(type);
    return map;
  }

  SlimDeputyVoteTypeEntityCompanion toCompanion(bool nullToAbsent) {
    return SlimDeputyVoteTypeEntityCompanion(
      votingId: Value(votingId),
      deputyId: Value(deputyId),
      type: Value(type),
    );
  }

  factory SlimDeputyVoteTypeEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SlimDeputyVoteTypeEntityData(
      votingId: serializer.fromJson<String>(json['votingId']),
      deputyId: serializer.fromJson<String>(json['deputyId']),
      type: serializer.fromJson<int>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'votingId': serializer.toJson<String>(votingId),
      'deputyId': serializer.toJson<String>(deputyId),
      'type': serializer.toJson<int>(type),
    };
  }

  SlimDeputyVoteTypeEntityData copyWith(
          {String? votingId, String? deputyId, int? type}) =>
      SlimDeputyVoteTypeEntityData(
        votingId: votingId ?? this.votingId,
        deputyId: deputyId ?? this.deputyId,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('SlimDeputyVoteTypeEntityData(')
          ..write('votingId: $votingId, ')
          ..write('deputyId: $deputyId, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(votingId, deputyId, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SlimDeputyVoteTypeEntityData &&
          other.votingId == this.votingId &&
          other.deputyId == this.deputyId &&
          other.type == this.type);
}

class SlimDeputyVoteTypeEntityCompanion
    extends UpdateCompanion<SlimDeputyVoteTypeEntityData> {
  final Value<String> votingId;
  final Value<String> deputyId;
  final Value<int> type;
  const SlimDeputyVoteTypeEntityCompanion({
    this.votingId = const Value.absent(),
    this.deputyId = const Value.absent(),
    this.type = const Value.absent(),
  });
  SlimDeputyVoteTypeEntityCompanion.insert({
    required String votingId,
    required String deputyId,
    required int type,
  })  : votingId = Value(votingId),
        deputyId = Value(deputyId),
        type = Value(type);
  static Insertable<SlimDeputyVoteTypeEntityData> custom({
    Expression<String>? votingId,
    Expression<String>? deputyId,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (votingId != null) 'voting_id': votingId,
      if (deputyId != null) 'deputy_id': deputyId,
      if (type != null) 'type': type,
    });
  }

  SlimDeputyVoteTypeEntityCompanion copyWith(
      {Value<String>? votingId, Value<String>? deputyId, Value<int>? type}) {
    return SlimDeputyVoteTypeEntityCompanion(
      votingId: votingId ?? this.votingId,
      deputyId: deputyId ?? this.deputyId,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (votingId.present) {
      map['voting_id'] = Variable<String>(votingId.value);
    }
    if (deputyId.present) {
      map['deputy_id'] = Variable<String>(deputyId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SlimDeputyVoteTypeEntityCompanion(')
          ..write('votingId: $votingId, ')
          ..write('deputyId: $deputyId, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $SlimDeputyVoteTypeEntityTable extends SlimDeputyVoteTypeEntity
    with
        TableInfo<$SlimDeputyVoteTypeEntityTable,
            SlimDeputyVoteTypeEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SlimDeputyVoteTypeEntityTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _votingIdMeta = const VerificationMeta('votingId');
  @override
  late final GeneratedColumn<String?> votingId = GeneratedColumn<String?>(
      'voting_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _deputyIdMeta = const VerificationMeta('deputyId');
  @override
  late final GeneratedColumn<String?> deputyId = GeneratedColumn<String?>(
      'deputy_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [votingId, deputyId, type];
  @override
  String get aliasedName => _alias ?? 'slim_deputy_vote_type_entity';
  @override
  String get actualTableName => 'slim_deputy_vote_type_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<SlimDeputyVoteTypeEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('voting_id')) {
      context.handle(_votingIdMeta,
          votingId.isAcceptableOrUnknown(data['voting_id']!, _votingIdMeta));
    } else if (isInserting) {
      context.missing(_votingIdMeta);
    }
    if (data.containsKey('deputy_id')) {
      context.handle(_deputyIdMeta,
          deputyId.isAcceptableOrUnknown(data['deputy_id']!, _deputyIdMeta));
    } else if (isInserting) {
      context.missing(_deputyIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {votingId, deputyId};
  @override
  SlimDeputyVoteTypeEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return SlimDeputyVoteTypeEntityData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SlimDeputyVoteTypeEntityTable createAlias(String alias) {
    return $SlimDeputyVoteTypeEntityTable(attachedDatabase, alias);
  }
}

class VoteSlimEntityData extends DataClass
    implements Insertable<VoteSlimEntityData> {
  final String id;
  final String title;
  final int votingType;
  final DateTime date;
  final int inFavor;
  final int against;
  final int hold;
  final int absent;
  final int? orderPoint;
  final int? qualifyingMajority;
  final int? absoluteMajority;
  final bool viewed;
  VoteSlimEntityData(
      {required this.id,
      required this.title,
      required this.votingType,
      required this.date,
      required this.inFavor,
      required this.against,
      required this.hold,
      required this.absent,
      this.orderPoint,
      this.qualifyingMajority,
      this.absoluteMajority,
      required this.viewed});
  factory VoteSlimEntityData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VoteSlimEntityData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      votingType: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}voting_type'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      inFavor: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}in_favor'])!,
      against: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}against'])!,
      hold: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hold'])!,
      absent: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}absent'])!,
      orderPoint: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_point']),
      qualifyingMajority: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}qualifying_majority']),
      absoluteMajority: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}absolute_majority']),
      viewed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}viewed'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['voting_type'] = Variable<int>(votingType);
    map['date'] = Variable<DateTime>(date);
    map['in_favor'] = Variable<int>(inFavor);
    map['against'] = Variable<int>(against);
    map['hold'] = Variable<int>(hold);
    map['absent'] = Variable<int>(absent);
    if (!nullToAbsent || orderPoint != null) {
      map['order_point'] = Variable<int?>(orderPoint);
    }
    if (!nullToAbsent || qualifyingMajority != null) {
      map['qualifying_majority'] = Variable<int?>(qualifyingMajority);
    }
    if (!nullToAbsent || absoluteMajority != null) {
      map['absolute_majority'] = Variable<int?>(absoluteMajority);
    }
    map['viewed'] = Variable<bool>(viewed);
    return map;
  }

  VoteSlimEntityCompanion toCompanion(bool nullToAbsent) {
    return VoteSlimEntityCompanion(
      id: Value(id),
      title: Value(title),
      votingType: Value(votingType),
      date: Value(date),
      inFavor: Value(inFavor),
      against: Value(against),
      hold: Value(hold),
      absent: Value(absent),
      orderPoint: orderPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(orderPoint),
      qualifyingMajority: qualifyingMajority == null && nullToAbsent
          ? const Value.absent()
          : Value(qualifyingMajority),
      absoluteMajority: absoluteMajority == null && nullToAbsent
          ? const Value.absent()
          : Value(absoluteMajority),
      viewed: Value(viewed),
    );
  }

  factory VoteSlimEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VoteSlimEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      votingType: serializer.fromJson<int>(json['votingType']),
      date: serializer.fromJson<DateTime>(json['date']),
      inFavor: serializer.fromJson<int>(json['inFavor']),
      against: serializer.fromJson<int>(json['against']),
      hold: serializer.fromJson<int>(json['hold']),
      absent: serializer.fromJson<int>(json['absent']),
      orderPoint: serializer.fromJson<int?>(json['orderPoint']),
      qualifyingMajority: serializer.fromJson<int?>(json['qualifyingMajority']),
      absoluteMajority: serializer.fromJson<int?>(json['absoluteMajority']),
      viewed: serializer.fromJson<bool>(json['viewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'votingType': serializer.toJson<int>(votingType),
      'date': serializer.toJson<DateTime>(date),
      'inFavor': serializer.toJson<int>(inFavor),
      'against': serializer.toJson<int>(against),
      'hold': serializer.toJson<int>(hold),
      'absent': serializer.toJson<int>(absent),
      'orderPoint': serializer.toJson<int?>(orderPoint),
      'qualifyingMajority': serializer.toJson<int?>(qualifyingMajority),
      'absoluteMajority': serializer.toJson<int?>(absoluteMajority),
      'viewed': serializer.toJson<bool>(viewed),
    };
  }

  VoteSlimEntityData copyWith(
          {String? id,
          String? title,
          int? votingType,
          DateTime? date,
          int? inFavor,
          int? against,
          int? hold,
          int? absent,
          int? orderPoint,
          int? qualifyingMajority,
          int? absoluteMajority,
          bool? viewed}) =>
      VoteSlimEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        votingType: votingType ?? this.votingType,
        date: date ?? this.date,
        inFavor: inFavor ?? this.inFavor,
        against: against ?? this.against,
        hold: hold ?? this.hold,
        absent: absent ?? this.absent,
        orderPoint: orderPoint ?? this.orderPoint,
        qualifyingMajority: qualifyingMajority ?? this.qualifyingMajority,
        absoluteMajority: absoluteMajority ?? this.absoluteMajority,
        viewed: viewed ?? this.viewed,
      );
  @override
  String toString() {
    return (StringBuffer('VoteSlimEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('votingType: $votingType, ')
          ..write('date: $date, ')
          ..write('inFavor: $inFavor, ')
          ..write('against: $against, ')
          ..write('hold: $hold, ')
          ..write('absent: $absent, ')
          ..write('orderPoint: $orderPoint, ')
          ..write('qualifyingMajority: $qualifyingMajority, ')
          ..write('absoluteMajority: $absoluteMajority, ')
          ..write('viewed: $viewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, votingType, date, inFavor, against,
      hold, absent, orderPoint, qualifyingMajority, absoluteMajority, viewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoteSlimEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.votingType == this.votingType &&
          other.date == this.date &&
          other.inFavor == this.inFavor &&
          other.against == this.against &&
          other.hold == this.hold &&
          other.absent == this.absent &&
          other.orderPoint == this.orderPoint &&
          other.qualifyingMajority == this.qualifyingMajority &&
          other.absoluteMajority == this.absoluteMajority &&
          other.viewed == this.viewed);
}

class VoteSlimEntityCompanion extends UpdateCompanion<VoteSlimEntityData> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> votingType;
  final Value<DateTime> date;
  final Value<int> inFavor;
  final Value<int> against;
  final Value<int> hold;
  final Value<int> absent;
  final Value<int?> orderPoint;
  final Value<int?> qualifyingMajority;
  final Value<int?> absoluteMajority;
  final Value<bool> viewed;
  const VoteSlimEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.votingType = const Value.absent(),
    this.date = const Value.absent(),
    this.inFavor = const Value.absent(),
    this.against = const Value.absent(),
    this.hold = const Value.absent(),
    this.absent = const Value.absent(),
    this.orderPoint = const Value.absent(),
    this.qualifyingMajority = const Value.absent(),
    this.absoluteMajority = const Value.absent(),
    this.viewed = const Value.absent(),
  });
  VoteSlimEntityCompanion.insert({
    required String id,
    required String title,
    required int votingType,
    required DateTime date,
    required int inFavor,
    required int against,
    required int hold,
    required int absent,
    this.orderPoint = const Value.absent(),
    this.qualifyingMajority = const Value.absent(),
    this.absoluteMajority = const Value.absent(),
    required bool viewed,
  })  : id = Value(id),
        title = Value(title),
        votingType = Value(votingType),
        date = Value(date),
        inFavor = Value(inFavor),
        against = Value(against),
        hold = Value(hold),
        absent = Value(absent),
        viewed = Value(viewed);
  static Insertable<VoteSlimEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? votingType,
    Expression<DateTime>? date,
    Expression<int>? inFavor,
    Expression<int>? against,
    Expression<int>? hold,
    Expression<int>? absent,
    Expression<int?>? orderPoint,
    Expression<int?>? qualifyingMajority,
    Expression<int?>? absoluteMajority,
    Expression<bool>? viewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (votingType != null) 'voting_type': votingType,
      if (date != null) 'date': date,
      if (inFavor != null) 'in_favor': inFavor,
      if (against != null) 'against': against,
      if (hold != null) 'hold': hold,
      if (absent != null) 'absent': absent,
      if (orderPoint != null) 'order_point': orderPoint,
      if (qualifyingMajority != null) 'qualifying_majority': qualifyingMajority,
      if (absoluteMajority != null) 'absolute_majority': absoluteMajority,
      if (viewed != null) 'viewed': viewed,
    });
  }

  VoteSlimEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<int>? votingType,
      Value<DateTime>? date,
      Value<int>? inFavor,
      Value<int>? against,
      Value<int>? hold,
      Value<int>? absent,
      Value<int?>? orderPoint,
      Value<int?>? qualifyingMajority,
      Value<int?>? absoluteMajority,
      Value<bool>? viewed}) {
    return VoteSlimEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      votingType: votingType ?? this.votingType,
      date: date ?? this.date,
      inFavor: inFavor ?? this.inFavor,
      against: against ?? this.against,
      hold: hold ?? this.hold,
      absent: absent ?? this.absent,
      orderPoint: orderPoint ?? this.orderPoint,
      qualifyingMajority: qualifyingMajority ?? this.qualifyingMajority,
      absoluteMajority: absoluteMajority ?? this.absoluteMajority,
      viewed: viewed ?? this.viewed,
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
    if (votingType.present) {
      map['voting_type'] = Variable<int>(votingType.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (inFavor.present) {
      map['in_favor'] = Variable<int>(inFavor.value);
    }
    if (against.present) {
      map['against'] = Variable<int>(against.value);
    }
    if (hold.present) {
      map['hold'] = Variable<int>(hold.value);
    }
    if (absent.present) {
      map['absent'] = Variable<int>(absent.value);
    }
    if (orderPoint.present) {
      map['order_point'] = Variable<int?>(orderPoint.value);
    }
    if (qualifyingMajority.present) {
      map['qualifying_majority'] = Variable<int?>(qualifyingMajority.value);
    }
    if (absoluteMajority.present) {
      map['absolute_majority'] = Variable<int?>(absoluteMajority.value);
    }
    if (viewed.present) {
      map['viewed'] = Variable<bool>(viewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VoteSlimEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('votingType: $votingType, ')
          ..write('date: $date, ')
          ..write('inFavor: $inFavor, ')
          ..write('against: $against, ')
          ..write('hold: $hold, ')
          ..write('absent: $absent, ')
          ..write('orderPoint: $orderPoint, ')
          ..write('qualifyingMajority: $qualifyingMajority, ')
          ..write('absoluteMajority: $absoluteMajority, ')
          ..write('viewed: $viewed')
          ..write(')'))
        .toString();
  }
}

class $VoteSlimEntityTable extends VoteSlimEntity
    with TableInfo<$VoteSlimEntityTable, VoteSlimEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VoteSlimEntityTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _votingTypeMeta = const VerificationMeta('votingType');
  @override
  late final GeneratedColumn<int?> votingType = GeneratedColumn<int?>(
      'voting_type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _inFavorMeta = const VerificationMeta('inFavor');
  @override
  late final GeneratedColumn<int?> inFavor = GeneratedColumn<int?>(
      'in_favor', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _againstMeta = const VerificationMeta('against');
  @override
  late final GeneratedColumn<int?> against = GeneratedColumn<int?>(
      'against', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _holdMeta = const VerificationMeta('hold');
  @override
  late final GeneratedColumn<int?> hold = GeneratedColumn<int?>(
      'hold', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _absentMeta = const VerificationMeta('absent');
  @override
  late final GeneratedColumn<int?> absent = GeneratedColumn<int?>(
      'absent', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _orderPointMeta = const VerificationMeta('orderPoint');
  @override
  late final GeneratedColumn<int?> orderPoint = GeneratedColumn<int?>(
      'order_point', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _qualifyingMajorityMeta =
      const VerificationMeta('qualifyingMajority');
  @override
  late final GeneratedColumn<int?> qualifyingMajority = GeneratedColumn<int?>(
      'qualifying_majority', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _absoluteMajorityMeta =
      const VerificationMeta('absoluteMajority');
  @override
  late final GeneratedColumn<int?> absoluteMajority = GeneratedColumn<int?>(
      'absolute_majority', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _viewedMeta = const VerificationMeta('viewed');
  @override
  late final GeneratedColumn<bool?> viewed = GeneratedColumn<bool?>(
      'viewed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (viewed IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        votingType,
        date,
        inFavor,
        against,
        hold,
        absent,
        orderPoint,
        qualifyingMajority,
        absoluteMajority,
        viewed
      ];
  @override
  String get aliasedName => _alias ?? 'vote_slim_entity';
  @override
  String get actualTableName => 'vote_slim_entity';
  @override
  VerificationContext validateIntegrity(Insertable<VoteSlimEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('voting_type')) {
      context.handle(
          _votingTypeMeta,
          votingType.isAcceptableOrUnknown(
              data['voting_type']!, _votingTypeMeta));
    } else if (isInserting) {
      context.missing(_votingTypeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('in_favor')) {
      context.handle(_inFavorMeta,
          inFavor.isAcceptableOrUnknown(data['in_favor']!, _inFavorMeta));
    } else if (isInserting) {
      context.missing(_inFavorMeta);
    }
    if (data.containsKey('against')) {
      context.handle(_againstMeta,
          against.isAcceptableOrUnknown(data['against']!, _againstMeta));
    } else if (isInserting) {
      context.missing(_againstMeta);
    }
    if (data.containsKey('hold')) {
      context.handle(
          _holdMeta, hold.isAcceptableOrUnknown(data['hold']!, _holdMeta));
    } else if (isInserting) {
      context.missing(_holdMeta);
    }
    if (data.containsKey('absent')) {
      context.handle(_absentMeta,
          absent.isAcceptableOrUnknown(data['absent']!, _absentMeta));
    } else if (isInserting) {
      context.missing(_absentMeta);
    }
    if (data.containsKey('order_point')) {
      context.handle(
          _orderPointMeta,
          orderPoint.isAcceptableOrUnknown(
              data['order_point']!, _orderPointMeta));
    }
    if (data.containsKey('qualifying_majority')) {
      context.handle(
          _qualifyingMajorityMeta,
          qualifyingMajority.isAcceptableOrUnknown(
              data['qualifying_majority']!, _qualifyingMajorityMeta));
    }
    if (data.containsKey('absolute_majority')) {
      context.handle(
          _absoluteMajorityMeta,
          absoluteMajority.isAcceptableOrUnknown(
              data['absolute_majority']!, _absoluteMajorityMeta));
    }
    if (data.containsKey('viewed')) {
      context.handle(_viewedMeta,
          viewed.isAcceptableOrUnknown(data['viewed']!, _viewedMeta));
    } else if (isInserting) {
      context.missing(_viewedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VoteSlimEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VoteSlimEntityData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VoteSlimEntityTable createAlias(String alias) {
    return $VoteSlimEntityTable(attachedDatabase, alias);
  }
}

class SlimClubMajorityEntityData extends DataClass
    implements Insertable<SlimClubMajorityEntityData> {
  final String votingId;
  final String parliamentClubId;
  final int voteMajority;
  final int? deputyCardNumber;
  SlimClubMajorityEntityData(
      {required this.votingId,
      required this.parliamentClubId,
      required this.voteMajority,
      this.deputyCardNumber});
  factory SlimClubMajorityEntityData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SlimClubMajorityEntityData(
      votingId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}voting_id'])!,
      parliamentClubId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}parliament_club_id'])!,
      voteMajority: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vote_majority'])!,
      deputyCardNumber: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}deputy_card_number']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['voting_id'] = Variable<String>(votingId);
    map['parliament_club_id'] = Variable<String>(parliamentClubId);
    map['vote_majority'] = Variable<int>(voteMajority);
    if (!nullToAbsent || deputyCardNumber != null) {
      map['deputy_card_number'] = Variable<int?>(deputyCardNumber);
    }
    return map;
  }

  SlimClubMajorityEntityCompanion toCompanion(bool nullToAbsent) {
    return SlimClubMajorityEntityCompanion(
      votingId: Value(votingId),
      parliamentClubId: Value(parliamentClubId),
      voteMajority: Value(voteMajority),
      deputyCardNumber: deputyCardNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(deputyCardNumber),
    );
  }

  factory SlimClubMajorityEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SlimClubMajorityEntityData(
      votingId: serializer.fromJson<String>(json['votingId']),
      parliamentClubId: serializer.fromJson<String>(json['parliamentClubId']),
      voteMajority: serializer.fromJson<int>(json['voteMajority']),
      deputyCardNumber: serializer.fromJson<int?>(json['deputyCardNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'votingId': serializer.toJson<String>(votingId),
      'parliamentClubId': serializer.toJson<String>(parliamentClubId),
      'voteMajority': serializer.toJson<int>(voteMajority),
      'deputyCardNumber': serializer.toJson<int?>(deputyCardNumber),
    };
  }

  SlimClubMajorityEntityData copyWith(
          {String? votingId,
          String? parliamentClubId,
          int? voteMajority,
          int? deputyCardNumber}) =>
      SlimClubMajorityEntityData(
        votingId: votingId ?? this.votingId,
        parliamentClubId: parliamentClubId ?? this.parliamentClubId,
        voteMajority: voteMajority ?? this.voteMajority,
        deputyCardNumber: deputyCardNumber ?? this.deputyCardNumber,
      );
  @override
  String toString() {
    return (StringBuffer('SlimClubMajorityEntityData(')
          ..write('votingId: $votingId, ')
          ..write('parliamentClubId: $parliamentClubId, ')
          ..write('voteMajority: $voteMajority, ')
          ..write('deputyCardNumber: $deputyCardNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(votingId, parliamentClubId, voteMajority, deputyCardNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SlimClubMajorityEntityData &&
          other.votingId == this.votingId &&
          other.parliamentClubId == this.parliamentClubId &&
          other.voteMajority == this.voteMajority &&
          other.deputyCardNumber == this.deputyCardNumber);
}

class SlimClubMajorityEntityCompanion
    extends UpdateCompanion<SlimClubMajorityEntityData> {
  final Value<String> votingId;
  final Value<String> parliamentClubId;
  final Value<int> voteMajority;
  final Value<int?> deputyCardNumber;
  const SlimClubMajorityEntityCompanion({
    this.votingId = const Value.absent(),
    this.parliamentClubId = const Value.absent(),
    this.voteMajority = const Value.absent(),
    this.deputyCardNumber = const Value.absent(),
  });
  SlimClubMajorityEntityCompanion.insert({
    required String votingId,
    required String parliamentClubId,
    required int voteMajority,
    this.deputyCardNumber = const Value.absent(),
  })  : votingId = Value(votingId),
        parliamentClubId = Value(parliamentClubId),
        voteMajority = Value(voteMajority);
  static Insertable<SlimClubMajorityEntityData> custom({
    Expression<String>? votingId,
    Expression<String>? parliamentClubId,
    Expression<int>? voteMajority,
    Expression<int?>? deputyCardNumber,
  }) {
    return RawValuesInsertable({
      if (votingId != null) 'voting_id': votingId,
      if (parliamentClubId != null) 'parliament_club_id': parliamentClubId,
      if (voteMajority != null) 'vote_majority': voteMajority,
      if (deputyCardNumber != null) 'deputy_card_number': deputyCardNumber,
    });
  }

  SlimClubMajorityEntityCompanion copyWith(
      {Value<String>? votingId,
      Value<String>? parliamentClubId,
      Value<int>? voteMajority,
      Value<int?>? deputyCardNumber}) {
    return SlimClubMajorityEntityCompanion(
      votingId: votingId ?? this.votingId,
      parliamentClubId: parliamentClubId ?? this.parliamentClubId,
      voteMajority: voteMajority ?? this.voteMajority,
      deputyCardNumber: deputyCardNumber ?? this.deputyCardNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (votingId.present) {
      map['voting_id'] = Variable<String>(votingId.value);
    }
    if (parliamentClubId.present) {
      map['parliament_club_id'] = Variable<String>(parliamentClubId.value);
    }
    if (voteMajority.present) {
      map['vote_majority'] = Variable<int>(voteMajority.value);
    }
    if (deputyCardNumber.present) {
      map['deputy_card_number'] = Variable<int?>(deputyCardNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SlimClubMajorityEntityCompanion(')
          ..write('votingId: $votingId, ')
          ..write('parliamentClubId: $parliamentClubId, ')
          ..write('voteMajority: $voteMajority, ')
          ..write('deputyCardNumber: $deputyCardNumber')
          ..write(')'))
        .toString();
  }
}

class $SlimClubMajorityEntityTable extends SlimClubMajorityEntity
    with TableInfo<$SlimClubMajorityEntityTable, SlimClubMajorityEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SlimClubMajorityEntityTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _votingIdMeta = const VerificationMeta('votingId');
  @override
  late final GeneratedColumn<String?> votingId = GeneratedColumn<String?>(
      'voting_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _parliamentClubIdMeta =
      const VerificationMeta('parliamentClubId');
  @override
  late final GeneratedColumn<String?> parliamentClubId =
      GeneratedColumn<String?>('parliament_club_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _voteMajorityMeta =
      const VerificationMeta('voteMajority');
  @override
  late final GeneratedColumn<int?> voteMajority = GeneratedColumn<int?>(
      'vote_majority', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _deputyCardNumberMeta =
      const VerificationMeta('deputyCardNumber');
  @override
  late final GeneratedColumn<int?> deputyCardNumber = GeneratedColumn<int?>(
      'deputy_card_number', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [votingId, parliamentClubId, voteMajority, deputyCardNumber];
  @override
  String get aliasedName => _alias ?? 'slim_club_majority_entity';
  @override
  String get actualTableName => 'slim_club_majority_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<SlimClubMajorityEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('voting_id')) {
      context.handle(_votingIdMeta,
          votingId.isAcceptableOrUnknown(data['voting_id']!, _votingIdMeta));
    } else if (isInserting) {
      context.missing(_votingIdMeta);
    }
    if (data.containsKey('parliament_club_id')) {
      context.handle(
          _parliamentClubIdMeta,
          parliamentClubId.isAcceptableOrUnknown(
              data['parliament_club_id']!, _parliamentClubIdMeta));
    } else if (isInserting) {
      context.missing(_parliamentClubIdMeta);
    }
    if (data.containsKey('vote_majority')) {
      context.handle(
          _voteMajorityMeta,
          voteMajority.isAcceptableOrUnknown(
              data['vote_majority']!, _voteMajorityMeta));
    } else if (isInserting) {
      context.missing(_voteMajorityMeta);
    }
    if (data.containsKey('deputy_card_number')) {
      context.handle(
          _deputyCardNumberMeta,
          deputyCardNumber.isAcceptableOrUnknown(
              data['deputy_card_number']!, _deputyCardNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {votingId, parliamentClubId, deputyCardNumber};
  @override
  SlimClubMajorityEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return SlimClubMajorityEntityData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SlimClubMajorityEntityTable createAlias(String alias) {
    return $SlimClubMajorityEntityTable(attachedDatabase, alias);
  }
}

class SpeechEntityData extends DataClass
    implements Insertable<SpeechEntityData> {
  final String id;
  final String personName;
  final String? deputyId;
  final String? clubId;
  final String? desc;
  final DateTime date;
  final String videoUrl;
  final DateTime createAt;
  final DateTime updateAt;
  final int? nextDeputyCardId;
  final String? nextName;
  final String? nextSpeechId;
  final int? previousDeputyCardId;
  final String? previousName;
  final String? previousSpeechId;
  final bool viewed;
  SpeechEntityData(
      {required this.id,
      required this.personName,
      this.deputyId,
      this.clubId,
      this.desc,
      required this.date,
      required this.videoUrl,
      required this.createAt,
      required this.updateAt,
      this.nextDeputyCardId,
      this.nextName,
      this.nextSpeechId,
      this.previousDeputyCardId,
      this.previousName,
      this.previousSpeechId,
      required this.viewed});
  factory SpeechEntityData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SpeechEntityData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      personName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}person_name'])!,
      deputyId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deputy_id']),
      clubId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}club_id']),
      desc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}desc']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      videoUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}video_url'])!,
      createAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_at'])!,
      updateAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at'])!,
      nextDeputyCardId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}next_deputy_card_id']),
      nextName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}next_name']),
      nextSpeechId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}next_speech_id']),
      previousDeputyCardId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}previous_deputy_card_id']),
      previousName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}previous_name']),
      previousSpeechId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}previous_speech_id']),
      viewed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}viewed'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['person_name'] = Variable<String>(personName);
    if (!nullToAbsent || deputyId != null) {
      map['deputy_id'] = Variable<String?>(deputyId);
    }
    if (!nullToAbsent || clubId != null) {
      map['club_id'] = Variable<String?>(clubId);
    }
    if (!nullToAbsent || desc != null) {
      map['desc'] = Variable<String?>(desc);
    }
    map['date'] = Variable<DateTime>(date);
    map['video_url'] = Variable<String>(videoUrl);
    map['create_at'] = Variable<DateTime>(createAt);
    map['update_at'] = Variable<DateTime>(updateAt);
    if (!nullToAbsent || nextDeputyCardId != null) {
      map['next_deputy_card_id'] = Variable<int?>(nextDeputyCardId);
    }
    if (!nullToAbsent || nextName != null) {
      map['next_name'] = Variable<String?>(nextName);
    }
    if (!nullToAbsent || nextSpeechId != null) {
      map['next_speech_id'] = Variable<String?>(nextSpeechId);
    }
    if (!nullToAbsent || previousDeputyCardId != null) {
      map['previous_deputy_card_id'] = Variable<int?>(previousDeputyCardId);
    }
    if (!nullToAbsent || previousName != null) {
      map['previous_name'] = Variable<String?>(previousName);
    }
    if (!nullToAbsent || previousSpeechId != null) {
      map['previous_speech_id'] = Variable<String?>(previousSpeechId);
    }
    map['viewed'] = Variable<bool>(viewed);
    return map;
  }

  SpeechEntityCompanion toCompanion(bool nullToAbsent) {
    return SpeechEntityCompanion(
      id: Value(id),
      personName: Value(personName),
      deputyId: deputyId == null && nullToAbsent
          ? const Value.absent()
          : Value(deputyId),
      clubId:
          clubId == null && nullToAbsent ? const Value.absent() : Value(clubId),
      desc: desc == null && nullToAbsent ? const Value.absent() : Value(desc),
      date: Value(date),
      videoUrl: Value(videoUrl),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
      nextDeputyCardId: nextDeputyCardId == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDeputyCardId),
      nextName: nextName == null && nullToAbsent
          ? const Value.absent()
          : Value(nextName),
      nextSpeechId: nextSpeechId == null && nullToAbsent
          ? const Value.absent()
          : Value(nextSpeechId),
      previousDeputyCardId: previousDeputyCardId == null && nullToAbsent
          ? const Value.absent()
          : Value(previousDeputyCardId),
      previousName: previousName == null && nullToAbsent
          ? const Value.absent()
          : Value(previousName),
      previousSpeechId: previousSpeechId == null && nullToAbsent
          ? const Value.absent()
          : Value(previousSpeechId),
      viewed: Value(viewed),
    );
  }

  factory SpeechEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeechEntityData(
      id: serializer.fromJson<String>(json['id']),
      personName: serializer.fromJson<String>(json['personName']),
      deputyId: serializer.fromJson<String?>(json['deputyId']),
      clubId: serializer.fromJson<String?>(json['clubId']),
      desc: serializer.fromJson<String?>(json['desc']),
      date: serializer.fromJson<DateTime>(json['date']),
      videoUrl: serializer.fromJson<String>(json['videoUrl']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      updateAt: serializer.fromJson<DateTime>(json['updateAt']),
      nextDeputyCardId: serializer.fromJson<int?>(json['nextDeputyCardId']),
      nextName: serializer.fromJson<String?>(json['nextName']),
      nextSpeechId: serializer.fromJson<String?>(json['nextSpeechId']),
      previousDeputyCardId:
          serializer.fromJson<int?>(json['previousDeputyCardId']),
      previousName: serializer.fromJson<String?>(json['previousName']),
      previousSpeechId: serializer.fromJson<String?>(json['previousSpeechId']),
      viewed: serializer.fromJson<bool>(json['viewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'personName': serializer.toJson<String>(personName),
      'deputyId': serializer.toJson<String?>(deputyId),
      'clubId': serializer.toJson<String?>(clubId),
      'desc': serializer.toJson<String?>(desc),
      'date': serializer.toJson<DateTime>(date),
      'videoUrl': serializer.toJson<String>(videoUrl),
      'createAt': serializer.toJson<DateTime>(createAt),
      'updateAt': serializer.toJson<DateTime>(updateAt),
      'nextDeputyCardId': serializer.toJson<int?>(nextDeputyCardId),
      'nextName': serializer.toJson<String?>(nextName),
      'nextSpeechId': serializer.toJson<String?>(nextSpeechId),
      'previousDeputyCardId': serializer.toJson<int?>(previousDeputyCardId),
      'previousName': serializer.toJson<String?>(previousName),
      'previousSpeechId': serializer.toJson<String?>(previousSpeechId),
      'viewed': serializer.toJson<bool>(viewed),
    };
  }

  SpeechEntityData copyWith(
          {String? id,
          String? personName,
          String? deputyId,
          String? clubId,
          String? desc,
          DateTime? date,
          String? videoUrl,
          DateTime? createAt,
          DateTime? updateAt,
          int? nextDeputyCardId,
          String? nextName,
          String? nextSpeechId,
          int? previousDeputyCardId,
          String? previousName,
          String? previousSpeechId,
          bool? viewed}) =>
      SpeechEntityData(
        id: id ?? this.id,
        personName: personName ?? this.personName,
        deputyId: deputyId ?? this.deputyId,
        clubId: clubId ?? this.clubId,
        desc: desc ?? this.desc,
        date: date ?? this.date,
        videoUrl: videoUrl ?? this.videoUrl,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        nextDeputyCardId: nextDeputyCardId ?? this.nextDeputyCardId,
        nextName: nextName ?? this.nextName,
        nextSpeechId: nextSpeechId ?? this.nextSpeechId,
        previousDeputyCardId: previousDeputyCardId ?? this.previousDeputyCardId,
        previousName: previousName ?? this.previousName,
        previousSpeechId: previousSpeechId ?? this.previousSpeechId,
        viewed: viewed ?? this.viewed,
      );
  @override
  String toString() {
    return (StringBuffer('SpeechEntityData(')
          ..write('id: $id, ')
          ..write('personName: $personName, ')
          ..write('deputyId: $deputyId, ')
          ..write('clubId: $clubId, ')
          ..write('desc: $desc, ')
          ..write('date: $date, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('nextDeputyCardId: $nextDeputyCardId, ')
          ..write('nextName: $nextName, ')
          ..write('nextSpeechId: $nextSpeechId, ')
          ..write('previousDeputyCardId: $previousDeputyCardId, ')
          ..write('previousName: $previousName, ')
          ..write('previousSpeechId: $previousSpeechId, ')
          ..write('viewed: $viewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      personName,
      deputyId,
      clubId,
      desc,
      date,
      videoUrl,
      createAt,
      updateAt,
      nextDeputyCardId,
      nextName,
      nextSpeechId,
      previousDeputyCardId,
      previousName,
      previousSpeechId,
      viewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeechEntityData &&
          other.id == this.id &&
          other.personName == this.personName &&
          other.deputyId == this.deputyId &&
          other.clubId == this.clubId &&
          other.desc == this.desc &&
          other.date == this.date &&
          other.videoUrl == this.videoUrl &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt &&
          other.nextDeputyCardId == this.nextDeputyCardId &&
          other.nextName == this.nextName &&
          other.nextSpeechId == this.nextSpeechId &&
          other.previousDeputyCardId == this.previousDeputyCardId &&
          other.previousName == this.previousName &&
          other.previousSpeechId == this.previousSpeechId &&
          other.viewed == this.viewed);
}

class SpeechEntityCompanion extends UpdateCompanion<SpeechEntityData> {
  final Value<String> id;
  final Value<String> personName;
  final Value<String?> deputyId;
  final Value<String?> clubId;
  final Value<String?> desc;
  final Value<DateTime> date;
  final Value<String> videoUrl;
  final Value<DateTime> createAt;
  final Value<DateTime> updateAt;
  final Value<int?> nextDeputyCardId;
  final Value<String?> nextName;
  final Value<String?> nextSpeechId;
  final Value<int?> previousDeputyCardId;
  final Value<String?> previousName;
  final Value<String?> previousSpeechId;
  final Value<bool> viewed;
  const SpeechEntityCompanion({
    this.id = const Value.absent(),
    this.personName = const Value.absent(),
    this.deputyId = const Value.absent(),
    this.clubId = const Value.absent(),
    this.desc = const Value.absent(),
    this.date = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.nextDeputyCardId = const Value.absent(),
    this.nextName = const Value.absent(),
    this.nextSpeechId = const Value.absent(),
    this.previousDeputyCardId = const Value.absent(),
    this.previousName = const Value.absent(),
    this.previousSpeechId = const Value.absent(),
    this.viewed = const Value.absent(),
  });
  SpeechEntityCompanion.insert({
    required String id,
    required String personName,
    this.deputyId = const Value.absent(),
    this.clubId = const Value.absent(),
    this.desc = const Value.absent(),
    required DateTime date,
    required String videoUrl,
    required DateTime createAt,
    required DateTime updateAt,
    this.nextDeputyCardId = const Value.absent(),
    this.nextName = const Value.absent(),
    this.nextSpeechId = const Value.absent(),
    this.previousDeputyCardId = const Value.absent(),
    this.previousName = const Value.absent(),
    this.previousSpeechId = const Value.absent(),
    required bool viewed,
  })  : id = Value(id),
        personName = Value(personName),
        date = Value(date),
        videoUrl = Value(videoUrl),
        createAt = Value(createAt),
        updateAt = Value(updateAt),
        viewed = Value(viewed);
  static Insertable<SpeechEntityData> custom({
    Expression<String>? id,
    Expression<String>? personName,
    Expression<String?>? deputyId,
    Expression<String?>? clubId,
    Expression<String?>? desc,
    Expression<DateTime>? date,
    Expression<String>? videoUrl,
    Expression<DateTime>? createAt,
    Expression<DateTime>? updateAt,
    Expression<int?>? nextDeputyCardId,
    Expression<String?>? nextName,
    Expression<String?>? nextSpeechId,
    Expression<int?>? previousDeputyCardId,
    Expression<String?>? previousName,
    Expression<String?>? previousSpeechId,
    Expression<bool>? viewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personName != null) 'person_name': personName,
      if (deputyId != null) 'deputy_id': deputyId,
      if (clubId != null) 'club_id': clubId,
      if (desc != null) 'desc': desc,
      if (date != null) 'date': date,
      if (videoUrl != null) 'video_url': videoUrl,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (nextDeputyCardId != null) 'next_deputy_card_id': nextDeputyCardId,
      if (nextName != null) 'next_name': nextName,
      if (nextSpeechId != null) 'next_speech_id': nextSpeechId,
      if (previousDeputyCardId != null)
        'previous_deputy_card_id': previousDeputyCardId,
      if (previousName != null) 'previous_name': previousName,
      if (previousSpeechId != null) 'previous_speech_id': previousSpeechId,
      if (viewed != null) 'viewed': viewed,
    });
  }

  SpeechEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? personName,
      Value<String?>? deputyId,
      Value<String?>? clubId,
      Value<String?>? desc,
      Value<DateTime>? date,
      Value<String>? videoUrl,
      Value<DateTime>? createAt,
      Value<DateTime>? updateAt,
      Value<int?>? nextDeputyCardId,
      Value<String?>? nextName,
      Value<String?>? nextSpeechId,
      Value<int?>? previousDeputyCardId,
      Value<String?>? previousName,
      Value<String?>? previousSpeechId,
      Value<bool>? viewed}) {
    return SpeechEntityCompanion(
      id: id ?? this.id,
      personName: personName ?? this.personName,
      deputyId: deputyId ?? this.deputyId,
      clubId: clubId ?? this.clubId,
      desc: desc ?? this.desc,
      date: date ?? this.date,
      videoUrl: videoUrl ?? this.videoUrl,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      nextDeputyCardId: nextDeputyCardId ?? this.nextDeputyCardId,
      nextName: nextName ?? this.nextName,
      nextSpeechId: nextSpeechId ?? this.nextSpeechId,
      previousDeputyCardId: previousDeputyCardId ?? this.previousDeputyCardId,
      previousName: previousName ?? this.previousName,
      previousSpeechId: previousSpeechId ?? this.previousSpeechId,
      viewed: viewed ?? this.viewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (personName.present) {
      map['person_name'] = Variable<String>(personName.value);
    }
    if (deputyId.present) {
      map['deputy_id'] = Variable<String?>(deputyId.value);
    }
    if (clubId.present) {
      map['club_id'] = Variable<String?>(clubId.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String?>(desc.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (videoUrl.present) {
      map['video_url'] = Variable<String>(videoUrl.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<DateTime>(updateAt.value);
    }
    if (nextDeputyCardId.present) {
      map['next_deputy_card_id'] = Variable<int?>(nextDeputyCardId.value);
    }
    if (nextName.present) {
      map['next_name'] = Variable<String?>(nextName.value);
    }
    if (nextSpeechId.present) {
      map['next_speech_id'] = Variable<String?>(nextSpeechId.value);
    }
    if (previousDeputyCardId.present) {
      map['previous_deputy_card_id'] =
          Variable<int?>(previousDeputyCardId.value);
    }
    if (previousName.present) {
      map['previous_name'] = Variable<String?>(previousName.value);
    }
    if (previousSpeechId.present) {
      map['previous_speech_id'] = Variable<String?>(previousSpeechId.value);
    }
    if (viewed.present) {
      map['viewed'] = Variable<bool>(viewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeechEntityCompanion(')
          ..write('id: $id, ')
          ..write('personName: $personName, ')
          ..write('deputyId: $deputyId, ')
          ..write('clubId: $clubId, ')
          ..write('desc: $desc, ')
          ..write('date: $date, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('nextDeputyCardId: $nextDeputyCardId, ')
          ..write('nextName: $nextName, ')
          ..write('nextSpeechId: $nextSpeechId, ')
          ..write('previousDeputyCardId: $previousDeputyCardId, ')
          ..write('previousName: $previousName, ')
          ..write('previousSpeechId: $previousSpeechId, ')
          ..write('viewed: $viewed')
          ..write(')'))
        .toString();
  }
}

class $SpeechEntityTable extends SpeechEntity
    with TableInfo<$SpeechEntityTable, SpeechEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeechEntityTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _personNameMeta = const VerificationMeta('personName');
  @override
  late final GeneratedColumn<String?> personName = GeneratedColumn<String?>(
      'person_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _deputyIdMeta = const VerificationMeta('deputyId');
  @override
  late final GeneratedColumn<String?> deputyId = GeneratedColumn<String?>(
      'deputy_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _clubIdMeta = const VerificationMeta('clubId');
  @override
  late final GeneratedColumn<String?> clubId = GeneratedColumn<String?>(
      'club_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String?> desc = GeneratedColumn<String?>(
      'desc', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _videoUrlMeta = const VerificationMeta('videoUrl');
  @override
  late final GeneratedColumn<String?> videoUrl = GeneratedColumn<String?>(
      'video_url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createAtMeta = const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<DateTime?> createAt = GeneratedColumn<DateTime?>(
      'create_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updateAtMeta = const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<DateTime?> updateAt = GeneratedColumn<DateTime?>(
      'update_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nextDeputyCardIdMeta =
      const VerificationMeta('nextDeputyCardId');
  @override
  late final GeneratedColumn<int?> nextDeputyCardId = GeneratedColumn<int?>(
      'next_deputy_card_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _nextNameMeta = const VerificationMeta('nextName');
  @override
  late final GeneratedColumn<String?> nextName = GeneratedColumn<String?>(
      'next_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _nextSpeechIdMeta =
      const VerificationMeta('nextSpeechId');
  @override
  late final GeneratedColumn<String?> nextSpeechId = GeneratedColumn<String?>(
      'next_speech_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _previousDeputyCardIdMeta =
      const VerificationMeta('previousDeputyCardId');
  @override
  late final GeneratedColumn<int?> previousDeputyCardId = GeneratedColumn<int?>(
      'previous_deputy_card_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _previousNameMeta =
      const VerificationMeta('previousName');
  @override
  late final GeneratedColumn<String?> previousName = GeneratedColumn<String?>(
      'previous_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _previousSpeechIdMeta =
      const VerificationMeta('previousSpeechId');
  @override
  late final GeneratedColumn<String?> previousSpeechId =
      GeneratedColumn<String?>('previous_speech_id', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _viewedMeta = const VerificationMeta('viewed');
  @override
  late final GeneratedColumn<bool?> viewed = GeneratedColumn<bool?>(
      'viewed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (viewed IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        personName,
        deputyId,
        clubId,
        desc,
        date,
        videoUrl,
        createAt,
        updateAt,
        nextDeputyCardId,
        nextName,
        nextSpeechId,
        previousDeputyCardId,
        previousName,
        previousSpeechId,
        viewed
      ];
  @override
  String get aliasedName => _alias ?? 'speech_entity';
  @override
  String get actualTableName => 'speech_entity';
  @override
  VerificationContext validateIntegrity(Insertable<SpeechEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('person_name')) {
      context.handle(
          _personNameMeta,
          personName.isAcceptableOrUnknown(
              data['person_name']!, _personNameMeta));
    } else if (isInserting) {
      context.missing(_personNameMeta);
    }
    if (data.containsKey('deputy_id')) {
      context.handle(_deputyIdMeta,
          deputyId.isAcceptableOrUnknown(data['deputy_id']!, _deputyIdMeta));
    }
    if (data.containsKey('club_id')) {
      context.handle(_clubIdMeta,
          clubId.isAcceptableOrUnknown(data['club_id']!, _clubIdMeta));
    }
    if (data.containsKey('desc')) {
      context.handle(
          _descMeta, desc.isAcceptableOrUnknown(data['desc']!, _descMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('video_url')) {
      context.handle(_videoUrlMeta,
          videoUrl.isAcceptableOrUnknown(data['video_url']!, _videoUrlMeta));
    } else if (isInserting) {
      context.missing(_videoUrlMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    } else if (isInserting) {
      context.missing(_createAtMeta);
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    } else if (isInserting) {
      context.missing(_updateAtMeta);
    }
    if (data.containsKey('next_deputy_card_id')) {
      context.handle(
          _nextDeputyCardIdMeta,
          nextDeputyCardId.isAcceptableOrUnknown(
              data['next_deputy_card_id']!, _nextDeputyCardIdMeta));
    }
    if (data.containsKey('next_name')) {
      context.handle(_nextNameMeta,
          nextName.isAcceptableOrUnknown(data['next_name']!, _nextNameMeta));
    }
    if (data.containsKey('next_speech_id')) {
      context.handle(
          _nextSpeechIdMeta,
          nextSpeechId.isAcceptableOrUnknown(
              data['next_speech_id']!, _nextSpeechIdMeta));
    }
    if (data.containsKey('previous_deputy_card_id')) {
      context.handle(
          _previousDeputyCardIdMeta,
          previousDeputyCardId.isAcceptableOrUnknown(
              data['previous_deputy_card_id']!, _previousDeputyCardIdMeta));
    }
    if (data.containsKey('previous_name')) {
      context.handle(
          _previousNameMeta,
          previousName.isAcceptableOrUnknown(
              data['previous_name']!, _previousNameMeta));
    }
    if (data.containsKey('previous_speech_id')) {
      context.handle(
          _previousSpeechIdMeta,
          previousSpeechId.isAcceptableOrUnknown(
              data['previous_speech_id']!, _previousSpeechIdMeta));
    }
    if (data.containsKey('viewed')) {
      context.handle(_viewedMeta,
          viewed.isAcceptableOrUnknown(data['viewed']!, _viewedMeta));
    } else if (isInserting) {
      context.missing(_viewedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeechEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SpeechEntityData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SpeechEntityTable createAlias(String alias) {
    return $SpeechEntityTable(attachedDatabase, alias);
  }
}

abstract class _$AthensDatabase extends GeneratedDatabase {
  _$AthensDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SlimDeputyVoteTypeEntityTable slimDeputyVoteTypeEntity =
      $SlimDeputyVoteTypeEntityTable(this);
  late final $VoteSlimEntityTable voteSlimEntity = $VoteSlimEntityTable(this);
  late final $SlimClubMajorityEntityTable slimClubMajorityEntity =
      $SlimClubMajorityEntityTable(this);
  late final $SpeechEntityTable speechEntity = $SpeechEntityTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        slimDeputyVoteTypeEntity,
        voteSlimEntity,
        slimClubMajorityEntity,
        speechEntity
      ];
}
