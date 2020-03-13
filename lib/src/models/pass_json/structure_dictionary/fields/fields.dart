import 'package:json_annotation/json_annotation.dart';

part 'fields.g.dart';

@JsonSerializable()
class Fields {
  Fields(this.key, this.label, this.value, this.changeMessage);

  String key;
  String label;
  String value;
  String changeMessage;

  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
