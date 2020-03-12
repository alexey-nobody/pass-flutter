import 'package:json_annotation/json_annotation.dart';
import 'package:pass_flutter/src/models/pass_json/barcodes/barcodes.dart';
import 'package:pass_flutter/src/models/pass_json/locations/locations.dart';
import 'package:pass_flutter/src/models/pass_json/structure_dictionary/pass_structure_dictionary.dart';

part 'pass_json.g.dart';

@JsonSerializable()
class PassJson {
  int formatVersion;
  PassStructureDictionary storeCard;
  PassStructureDictionary generic;
  PassStructureDictionary eventTicket;
  PassStructureDictionary coupon;
  PassStructureDictionary boardingPass;
  String passTypeIdentifier;
  String description;
  String teamIdentifier;
  String labelColor;
  String backgroundColor;
  String foregroundColor;
  String organizationName;
  String webServiceURL;
  String serialNumber;
  String authenticationToken;
  List<int> associatedStoreIdentifiers;
  String appLaunchURL;
  String expirationDate;
  List<Barcodes> barcodes;
  List<Locations> locations;

  PassJson({
    this.formatVersion,
    this.storeCard,
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
  });

  factory PassJson.fromJson(Map<String, dynamic> json) =>
      _$PassJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PassJsonToJson(this);
}
