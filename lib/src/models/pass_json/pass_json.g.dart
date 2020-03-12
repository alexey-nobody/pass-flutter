// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassJson _$PassJsonFromJson(Map<String, dynamic> json) {
  return PassJson(
    formatVersion: json['formatVersion'] as int,
    storeCard: json['storeCard'] == null
        ? null
        : PassStructureDictionary.fromJson(
            json['storeCard'] as Map<String, dynamic>),
    passTypeIdentifier: json['passTypeIdentifier'] as String,
    description: json['description'] as String,
    teamIdentifier: json['teamIdentifier'] as String,
    labelColor: json['labelColor'] as String,
    backgroundColor: json['backgroundColor'] as String,
    foregroundColor: json['foregroundColor'] as String,
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
  )
    ..generic = json['generic'] == null
        ? null
        : PassStructureDictionary.fromJson(
            json['generic'] as Map<String, dynamic>)
    ..eventTicket = json['eventTicket'] == null
        ? null
        : PassStructureDictionary.fromJson(
            json['eventTicket'] as Map<String, dynamic>)
    ..coupon = json['coupon'] == null
        ? null
        : PassStructureDictionary.fromJson(
            json['coupon'] as Map<String, dynamic>)
    ..boardingPass = json['boardingPass'] == null
        ? null
        : PassStructureDictionary.fromJson(
            json['boardingPass'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PassJsonToJson(PassJson instance) => <String, dynamic>{
      'formatVersion': instance.formatVersion,
      'passTypeIdentifier': instance.passTypeIdentifier,
      'description': instance.description,
      'teamIdentifier': instance.teamIdentifier,
      'serialNumber': instance.serialNumber,
      'organizationName': instance.organizationName,
      'webServiceURL': instance.webServiceURL,
      'authenticationToken': instance.authenticationToken,
      'barcode': instance.barcode,
      'barcodes': instance.barcodes,
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'labelColor': instance.labelColor,
      'groupingIdentifier': instance.groupingIdentifier,
      'logoText': instance.logoText,
      'suppressStripShine': instance.suppressStripShine,
      'storeCard': instance.storeCard,
      'generic': instance.generic,
      'eventTicket': instance.eventTicket,
      'coupon': instance.coupon,
      'boardingPass': instance.boardingPass,
      'locations': instance.locations,
      'associatedStoreIdentifiers': instance.associatedStoreIdentifiers,
      'appLaunchURL': instance.appLaunchURL,
      'expirationDate': instance.expirationDate,
      'voided': instance.voided,
    };
