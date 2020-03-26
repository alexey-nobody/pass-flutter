import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fields.g.dart';

@JsonSerializable()
class Fields extends Equatable {
  final String key;
  final String label;
  final String value;
  final String changeMessage;

  Fields({
    this.key,
    this.label,
    this.value,
    this.changeMessage,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FieldsToJson(this);

  @override
  List<Object> get props => [
        this.key,
        this.label,
        this.value,
        this.changeMessage,
      ];
}
