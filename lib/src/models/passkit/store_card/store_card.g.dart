// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreCard _$StoreCardFromJson(Map<String, dynamic> json) {
  return StoreCard(
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

Map<String, dynamic> _$StoreCardToJson(StoreCard instance) => <String, dynamic>{
      'headerFields': instance.headerFields,
      'secondaryFields': instance.secondaryFields,
      'backFields': instance.backFields,
    };
