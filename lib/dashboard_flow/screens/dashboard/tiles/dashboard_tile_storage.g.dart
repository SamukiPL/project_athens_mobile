// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_tile_storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardTileStorage _$DashboardTileStorageFromJson(Map<String, dynamic> json) {
  return DashboardTileStorage(
    _$enumDecode(_$DashboardTilesEnumMap, json['type']),
    json['order'] as int,
  );
}

Map<String, dynamic> _$DashboardTileStorageToJson(
        DashboardTileStorage instance) =>
    <String, dynamic>{
      'type': _$DashboardTilesEnumMap[instance.type],
      'order': instance.order,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$DashboardTilesEnumMap = {
  DashboardTiles.NAME: 'NAME',
  DashboardTiles.NOTIFICATIONS: 'NOTIFICATIONS',
  DashboardTiles.SETTINGS_BUTTON: 'SETTINGS_BUTTON',
  DashboardTiles.NEAREST_MEETING: 'NEAREST_MEETING',
  DashboardTiles.DEPUTIES: 'DEPUTIES',
  DashboardTiles.SPEECHES: 'SPEECHES',
  DashboardTiles.VOTES: 'VOTES',
  DashboardTiles.CHART_VOTES_ABSENT: 'CHART_VOTES_ABSENT',
  DashboardTiles.CHART_VOTES_ABSENT_PER_YEAR: 'CHART_VOTES_ABSENT_PER_YEAR',
  DashboardTiles.CHART_SPEECHES_COUNTER: 'CHART_SPEECHES_COUNTER',
  DashboardTiles.CHART_SPEECHES_COUNTER_PER_YEAR:
      'CHART_SPEECHES_COUNTER_PER_YEAR',
};
