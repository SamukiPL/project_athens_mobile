import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';

class DeputyModel extends BaseModel {

  final String id;

  final String name;

  final String? thumbnailUrl;

  final String? club;

  final String? clubId;

  final int? cardId;

  DeputyModel({required this.id, required this.name, this.thumbnailUrl, required this.clubId, this.club, this.cardId});

}