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
  )
    ..auxiliaryFields = (json['auxiliaryFields'] as List)
        ?.map((e) =>
            e == null ? null : Fields.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..primaryFields = (json['primaryFields'] as List)
        ?.map((e) =>
            e == null ? null : Fields.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..transitType = json['transitType'] as String;
}

Map<String, dynamic> _$PassStructureDictionaryToJson(
    PassStructureDictionary instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('auxiliaryFields', instance.auxiliaryFields);
  writeNotNull('headerFields', instance.headerFields);
  writeNotNull('secondaryFields', instance.secondaryFields);
  writeNotNull('backFields', instance.backFields);
  writeNotNull('primaryFields', instance.primaryFields);
  writeNotNull('transitType', instance.transitType);
  return val;
}
