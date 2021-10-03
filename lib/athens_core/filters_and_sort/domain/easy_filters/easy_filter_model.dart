import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';

class EasyFilterModel<T> extends BaseModel {
  final String title;
  final String? iconUrl;
  final T filterValue;

  EasyFilterModel({required this.title, this.iconUrl, required this.filterValue});

  @override
  bool operator ==(Object other) {
    return other is EasyFilterModel<T> && other.filterValue == filterValue;
  }

  @override
  int get hashCode => hashValues(title, iconUrl, filterValue);
}
