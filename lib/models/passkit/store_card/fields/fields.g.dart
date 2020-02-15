// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
    json['key'] as String,
    json['label'] as String,
    json['value'] as String,
    json['changeMessage'] as String,
  );
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'value': instance.value,
      'changeMessage': instance.changeMessage,
    };
