import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fields.g.dart';

@JsonSerializable()
class Fields extends Equatable {
  /// Required. The key must be unique within the scope of the entire pass. For example, “departure-gate.”
  final String key;

  /// Optional. Label text for the field.
  final String label;

  /// Required. Value of the field, for example, 42.
  final String value;

  /// Optional. Format string for the alert text that is displayed when the pass is updated.
  /// The format string must contain the escape %@, which is replaced with the field’s new value.
  /// For example, “Gate changed to %@.”
  /// If you don’t specify a change message, the user isn’t notified when the field changes.
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
