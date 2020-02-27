// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passkit_pass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasskitPass _$PasskitPassFromJson(Map<String, dynamic> json) {
  return PasskitPass(
    formatVersion: json['formatVersion'] as int,
    storeCard: json['storeCard'] == null
        ? null
        : StoreCard.fromJson(json['storeCard'] as Map<String, dynamic>),
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
  );
}

Map<String, dynamic> _$PasskitPassToJson(PasskitPass instance) =>
    <String, dynamic>{
      'formatVersion': instance.formatVersion,
      'storeCard': instance.storeCard,
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
      'voided': instance.voided,
    };
