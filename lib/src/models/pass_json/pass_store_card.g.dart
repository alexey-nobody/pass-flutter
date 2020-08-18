// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_store_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassStoreCard _$PassStoreCardFromJson(Map<String, dynamic> json) {
  return PassStoreCard(
    passData: json['storeCard'] == null
        ? null
        : PassStructureDictionary.fromJson(
            json['storeCard'] as Map<String, dynamic>),
    formatVersion: json['formatVersion'] as int,
    passTypeIdentifier: json['passTypeIdentifier'] as String,
    description: json['description'] as String,
    teamIdentifier: json['teamIdentifier'] as String,
    labelColor: ColorHelper.convertToColor(json['labelColor'] as String),
    backgroundColor:
        ColorHelper.convertToColor(json['backgroundColor'] as String),
    foregroundColor:
        ColorHelper.convertToColor(json['foregroundColor'] as String),
    organizationName: json['organizationName'] as String,
    webServiceURL: json['webServiceURL'] as String,
    serialNumber: json['serialNumber'] as String,
    authenticationToken: json['authenticationToken'] as String,
    associatedStoreIdentifiers: (json['associatedStoreIdentifiers'] as List)
        ?.map((e) => e as int)
        ?.toList(),
    appLaunchURL: json['appLaunchURL'] as String,
    expirationDate: json['expirationDate'] as String,
    voided: json['voided'] as bool,
    groupingIdentifier: json['groupingIdentifier'] as String,
    logoText: json['logoText'] as String,
    suppressStripShine: json['suppressStripShine'] as bool,
    barcodes: (json['barcodes'] as List)
        ?.map((e) =>
            e == null ? null : Barcode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    barcode: json['barcode'] == null
        ? null
        : Barcode.fromJson(json['barcode'] as Map<String, dynamic>),
    locations: (json['locations'] as List)
        ?.map((e) =>
            e == null ? null : Location.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    maxDistance: json['maxDistance'] as int,
    relevantDate: json['relevantDate'] as String,
  );
}

Map<String, dynamic> _$PassStoreCardToJson(PassStoreCard instance) =>
    <String, dynamic>{
      'description': instance.description,
      'formatVersion': instance.formatVersion,
      'organizationName': instance.organizationName,
      'passTypeIdentifier': instance.passTypeIdentifier,
      'serialNumber': instance.serialNumber,
      'teamIdentifier': instance.teamIdentifier,
      'webServiceURL': instance.webServiceURL,
      'authenticationToken': instance.authenticationToken,
      'barcode': instance.barcode,
      'barcodes': instance.barcodes,
      'backgroundColor': ColorHelper.convertFromColor(instance.backgroundColor),
      'foregroundColor': ColorHelper.convertFromColor(instance.foregroundColor),
      'labelColor': ColorHelper.convertFromColor(instance.labelColor),
      'groupingIdentifier': instance.groupingIdentifier,
      'logoText': instance.logoText,
      'suppressStripShine': instance.suppressStripShine,
      'locations': instance.locations,
      'maxDistance': instance.maxDistance,
      'relevantDate': instance.relevantDate,
      'associatedStoreIdentifiers': instance.associatedStoreIdentifiers,
      'appLaunchURL': instance.appLaunchURL,
      'expirationDate': instance.expirationDate,
      'voided': instance.voided,
      'storeCard': instance.passData,
    };
