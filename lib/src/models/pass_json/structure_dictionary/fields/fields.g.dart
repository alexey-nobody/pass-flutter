// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
    key: json['key'] as String,
    label: json['label'] as String,
    value: json['value'] as String,
    changeMessage: json['changeMessage'] as String,
  );
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'value': instance.value,
      'changeMessage': instance.changeMessage,
    };
