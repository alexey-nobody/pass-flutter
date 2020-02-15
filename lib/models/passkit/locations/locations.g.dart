// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
    relevantText: json['relevantText'] as String,
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'relevantText': instance.relevantText,
    };
