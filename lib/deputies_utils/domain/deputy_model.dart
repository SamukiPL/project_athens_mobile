import 'package:flutter/cupertino.dart';

class DeputyModel {

  final String deputyId;

  final String name;

  final String thumbnailUrl;

  final String club;

  DeputyModel({@required this.deputyId, @required this.name, this.thumbnailUrl, this.club});

}