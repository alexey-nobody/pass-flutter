// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_structure_dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassStructureDictionary _$PassStructureDictionaryFromJson(
    Map<String, dynamic> json) {
  return PassStructureDictionary(
    headerFields: (json['headerFields'] as List)
        ?.map((e) =>
            e == null ? null : Fields.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    secondaryFields: (json['secondaryFields'] as List)
        ?.map((e) =>
            e == null ? null : Fields.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    backFields: (json['backFields'] as List)
        ?.map((e) =>
            e == null ? null : Fields.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PassStructureDictionaryToJson(
        PassStructureDictionary instance) =>
    <String, dynamic>{
      'headerFields': instance.headerFields,
      'secondaryFields': instance.secondaryFields,
      'backFields': instance.backFields,
    };
