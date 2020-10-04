import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/domain/list/base_model.dart';

class DeputyModel extends BaseModel {

  final String id;

  final String name;

  final String thumbnailUrl;

  final String club;

  DeputyModel({@required this.id, @required this.name, this.thumbnailUrl, this.club});

}