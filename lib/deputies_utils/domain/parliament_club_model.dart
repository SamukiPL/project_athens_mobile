import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/domain/list/base_model.dart';

class ParliamentClubModel extends BaseModel {

  final String id;

  final int cadency;

  final String name;

  final String shortName;

  final String imageSrc;

  final DateTime createAt;

  final DateTime updateAt;

  ParliamentClubModel({@required this.id, @required this.cadency, @required this.name, @required this.shortName, this.imageSrc, this.createAt, this.updateAt});
}