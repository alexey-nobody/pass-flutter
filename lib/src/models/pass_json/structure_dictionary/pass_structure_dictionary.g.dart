// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_structure_dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassStructureDictionary _$PassStructureDictionaryFromJson(
    Map<String, dynamic> json) {
  return PassStructureDictionary(
    headerFields: (json['headerFields'] as List<dynamic>?)
        ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
        .toList(),
    secondaryFields: (json['secondaryFields'] as List<dynamic>?)
        ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
        .toList(),
    backFields: (json['backFields'] as List<dynamic>?)
        ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
        .toList(),
    auxiliaryFields: (json['auxiliaryFields'] as List<dynamic>?)
        ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
        .toList(),
    primaryFields: (json['primaryFields'] as List<dynamic>?)
        ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
        .toList(),
    transitType: json['transitType'] as String?,
  );
}

Map<String, dynamic> _$PassStructureDictionaryToJson(
        PassStructureDictionary instance) =>
    <String, dynamic>{
      'auxiliaryFields': instance.auxiliaryFields,
      'headerFields': instance.headerFields,
      'secondaryFields': instance.secondaryFields,
      'backFields': instance.backFields,
      'primaryFields': instance.primaryFields,
      'transitType': instance.transitType,
    };
