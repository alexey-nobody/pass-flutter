import 'package:json_annotation/json_annotation.dart';
import 'package:pass_flutter/src/models/pass_json/barcode/barcode.dart';
import 'package:pass_flutter/src/models/pass_json/location/location.dart';
import 'package:pass_flutter/src/models/pass_json/structure_dictionary/pass_structure_dictionary.dart';

part 'pass_json.g.dart';

@JsonSerializable()
class PassJson {
  // Standard Keys
  int formatVersion;
  String passTypeIdentifier;
  String description;
  String teamIdentifier;
  String serialNumber;
  String organizationName;

  // Web Service Keys
  String webServiceURL;
  String authenticationToken;

  // Visual Appearance Keys
  Barcode barcode;
  List<Barcode> barcodes;
  String backgroundColor;
  String foregroundColor;
  String labelColor;
  String groupingIdentifier;
  String logoText;
  bool suppressStripShine;

  // Style Keys
  PassStructureDictionary storeCard;
  PassStructureDictionary generic;
  PassStructureDictionary eventTicket;
  PassStructureDictionary coupon;
  PassStructureDictionary boardingPass;

  // Relevance Keys
  List<Location> locations;

  // Associated App Keys
  List<int> associatedStoreIdentifiers;
  String appLaunchURL;

  // Expiration Keys
  String expirationDate;
  bool voided;

  PassJson({
    this.formatVersion,
    this.storeCard,
    this.coupon,
    this.generic,
    this.eventTicket,
    this.boardingPass,
    this.passTypeIdentifier,
    this.description,
    this.teamIdentifier,
    this.labelColor,
    this.backgroundColor,
    this.foregroundColor,
    this.organizationName,
    this.webServiceURL,
    this.serialNumber,
    this.authenticationToken,
    this.associatedStoreIdentifiers,
    this.appLaunchURL,
    this.expirationDate,
    this.voided,
    this.groupingIdentifier,
    this.logoText,
    this.suppressStripShine,
    this.barcodes,
    this.barcode,
    this.locations,
  });

  factory PassJson.fromJson(Map<String, dynamic> json) =>
      _$PassJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PassJsonToJson(this);
}
