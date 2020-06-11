import 'package:flutter/cupertino.dart';

abstract class DataMapper<FROM, TO> {
  List<TO> call(List<FROM> data) {
    return data.map((from) => transform(from)).toList();
  }

  TO transform(FROM data);
}
