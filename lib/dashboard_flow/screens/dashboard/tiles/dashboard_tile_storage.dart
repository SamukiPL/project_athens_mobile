import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_tiles.dart';

part 'dashboard_tile_storage.g.dart';

@JsonSerializable()
class DashboardTileStorage {
  final DashboardTiles type;
  final int order;


  DashboardTileStorage(this.type, this.order);

  factory DashboardTileStorage.fromJson(Map<String, dynamic> json) => _$DashboardTileStorageFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardTileStorageToJson(this);
}