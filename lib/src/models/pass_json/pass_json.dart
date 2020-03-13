import 'package:json_annotation/json_annotation.dart';
import 'package:pass_flutter/src/models/pass_json/barcode/barcode.dart';
import 'package:pass_flutter/src/models/pass_json/location/location.dart';
import 'package:pass_flutter/src/models/pass_json/structure_dictionary/pass_structure_dictionary.dart';

part 'pass_json.g.dart';

@JsonSerializable()
class PassJson {
  // Standart keys

  /// Required. Brief description of the pass, used by the iOS accessibility technologies.
  /// Don’t try to include all of the data on the pass in its description,
  /// just include enough detail to distinguish passes of the same type.
  String description;

  /// Required. Version of the file format. The value must be 1.
  int formatVersion;

  /// Required. Display name of the organization that originated and signed the pass.
  String organizationName;

  /// Required. Pass type identifier, as issued by Apple. The value must correspond with your signing certificate.
  String passTypeIdentifier;

  /// Required. Serial number that uniquely identifies the pass. No two passes with the same pass type identifier may have the same serial number.
  String serialNumber;

  /// Required. Team identifier of the organization that originated and signed the pass, as issued by Apple.
  String teamIdentifier;

  // Web Service Keys
  String webServiceURL;
  String authenticationToken;

  // Visual Appearance Keys

  /// Optional. Information specific to the pass’s barcode. For this dictionary’s keys, see Barcode Dictionary Keys.
  /// Note:Deprecated in iOS 9.0 and later; use barcodes instead.
  Barcode barcode;

  /// Optional. Information specific to the pass’s barcode.
  /// The system uses the first valid barcode dictionary in the array.
  /// Additional dictionaries can be added as fallbacks. For this dictionary’s keys,
  /// see Barcode Dictionary Keys.
  /// Note: Available only in iOS 9.0 and later.
  List<Barcode> barcodes;

  /// Optional. Background color of the pass, specified as an CSS-style RGB triple. For example, rgb(23, 187, 82).
  String backgroundColor;

  /// Optional. Foreground color of the pass, specified as a CSS-style RGB triple. For example, rgb(100, 10, 110).
  String foregroundColor;

  /// Optional. Color of the label text, specified as a CSS-style RGB triple. For example, rgb(255, 255, 255).
  /// If omitted, the label color is determined automatically.
  String labelColor;

  /// Optional for event tickets and boarding passes; otherwise not allowed.
  /// Identifier used to group related passes. If a grouping identifier is specified,
  /// passes with the same style, pass type identifier, and grouping identifier are displayed as a group.
  /// Otherwise, passes are grouped automatically.
  /// Use this to group passes that are tightly related, such as the boarding passes for different
  /// connections of the same trip.
  /// Available in iOS 7.0.
  String groupingIdentifier;

  /// Optional. Text displayed next to the logo on the pass.
  String logoText;

  /// Optional. If true, the strip image is displayed without a shine effect. The default value prior to iOS 7.0 is false.
  /// In iOS 7.0, a shine effect is never applied, and this key is deprecated.
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
