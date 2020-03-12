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
            json['boardingPass'] as Map<String, dynamic>)
    ..barcodes = (json['barcodes'] as List)
        ?.map((e) =>
            e == null ? null : Barcodes.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..locations = (json['locations'] as List)
        ?.map((e) =>
            e == null ? null : Locations.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PassJsonToJson(PassJson instance) => <String, dynamic>{
      'formatVersion': instance.formatVersion,
      'storeCard': instance.storeCard,
      'generic': instance.generic,
      'eventTicket': instance.eventTicket,
      'coupon': instance.coupon,
      'boardingPass': instance.boardingPass,
      'passTypeIdentifier': instance.passTypeIdentifier,
      'description': instance.description,
      'teamIdentifier': instance.teamIdentifier,
      'labelColor': instance.labelColor,
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'organizationName': instance.organizationName,
      'webServiceURL': instance.webServiceURL,
      'serialNumber': instance.serialNumber,
      'authenticationToken': instance.authenticationToken,
      'associatedStoreIdentifiers': instance.associatedStoreIdentifiers,
      'appLaunchURL': instance.appLaunchURL,
      'expirationDate': instance.expirationDate,
      'barcodes': instance.barcodes,
      'locations': instance.locations,
    };
