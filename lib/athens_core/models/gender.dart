import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue("male")
  MALE,
  @JsonValue("female")
  FEMALE
}
