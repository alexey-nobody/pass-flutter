import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:pass_flutter/src/common/color_helper.dart';
import 'package:pass_flutter/src/models/pass_json/barcode/barcode.dart';
import 'package:pass_flutter/src/models/pass_json/location/location.dart';
import 'package:pass_flutter/src/models/pass_json/structure_dictionary/pass_structure_dictionary.dart';

part 'pass_json.g.dart';

/// A JSON dictionary that defines the pass.
@JsonSerializable()
class PassJson extends Equatable {
  /// Creates a new [PassJson]
  const PassJson({
    required this.formatVersion,
    required this.passTypeIdentifier,
    required this.description,
    required this.teamIdentifier,
    required this.organizationName,
    required this.serialNumber,
    this.storeCard,
    this.coupon,
    this.generic,
    this.eventTicket,
    this.boardingPass,
    this.labelColor,
    this.backgroundColor,
    this.foregroundColor,
    this.webServiceURL,
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
    this.maxDistance,
    this.relevantDate,
  });

  /// Convert from json
  factory PassJson.fromJson(Map<String, dynamic> json) =>
      _$PassJsonFromJson(json);

  // Standart keys

  /// Required. Brief description of the pass, used by the iOS accessibility technologies.
  /// Don’t try to include all of the data on the pass in its description,
  /// just include enough detail to distinguish passes of the same type.
  final String description;

  /// Required. Version of the file format. The value must be 1.
  final int formatVersion;

  /// Required. Display name of the organization that originated and signed the pass.
  final String organizationName;

  /// Required. Pass type identifier, as issued by Apple. The value must correspond with your signing certificate.
  final String passTypeIdentifier;

  /// Required. Serial number that uniquely identifies the pass. No two passes with the same pass type identifier may have the same serial number.
  final String serialNumber;

  /// Required. Team identifier of the organization that originated and signed the pass, as issued by Apple.
  final String teamIdentifier;

  // Web Service Keys

  /// The URL of a web service that conforms to the API described in PassKit Web Service Reference.
  /// The web service must use the HTTPS protocol; the leading https:// is included in the value of this key.
  /// On devices configured for development, there is UI in Settings to allow HTTP web services.
  final String? webServiceURL;

  /// The authentication token to use with the web service. The token must be 16 characters or longer.
  final String? authenticationToken;

  // Visual Appearance Keys

  /// Optional. Information specific to the pass’s barcode. For this dictionary’s keys, see Barcode Dictionary Keys.
  /// Note:Deprecated in iOS 9.0 and later; use barcodes instead.
  final Barcode? barcode;

  /// Optional. Information specific to the pass’s barcode.
  /// The system uses the first valid barcode dictionary in the array.
  /// Additional dictionaries can be added as fallbacks. For this dictionary’s keys,
  /// see Barcode Dictionary Keys.
  /// Note: Available only in iOS 9.0 and later.
  final List<Barcode>? barcodes;

  /// Optional. Background [Color] of the pass.
  @JsonKey(
      fromJson: ColorHelper.convertToColor,
      toJson: ColorHelper.convertFromColor)
  final Color? backgroundColor;

  /// Optional. Foreground [Color] of the pass.
  @JsonKey(
      fromJson: ColorHelper.convertToColor,
      toJson: ColorHelper.convertFromColor)
  final Color? foregroundColor;

  /// Optional. [Color] of the label text.
  /// If omitted, the label color is determined automatically.
  @JsonKey(
      fromJson: ColorHelper.convertToColor,
      toJson: ColorHelper.convertFromColor)
  final Color? labelColor;

  /// Optional for event tickets and boarding passes; otherwise not allowed.
  /// Identifier used to group related passes. If a grouping identifier is specified,
  /// passes with the same style, pass type identifier, and grouping identifier are displayed as a group.
  /// Otherwise, passes are grouped automatically.
  /// Use this to group passes that are tightly related, such as the boarding passes for different
  /// connections of the same trip.
  /// Available in iOS 7.0.
  final String? groupingIdentifier;

  /// Optional. Text displayed next to the logo on the pass.
  final String? logoText;

  /// Optional. If true, the strip image is displayed without a shine effect.
  /// The default value prior to iOS 7.0 is false.
  /// In iOS 7.0, a shine effect is never applied, and this key is deprecated.
  final bool? suppressStripShine;

  // Style Keys

  /// Information specific to a store card.
  final PassStructureDictionary? storeCard;

  /// Information specific to a generic pass.
  final PassStructureDictionary? generic;

  /// Information specific to an event ticket.
  final PassStructureDictionary? eventTicket;

  /// Information specific to a coupon.
  final PassStructureDictionary? coupon;

  /// Information specific to a boarding pass.
  final PassStructureDictionary? boardingPass;

  // Relevance Keys

  /// Optional. Locations where the pass is relevant. For example, the location of your store.
  final List<Location>? locations;

  /// Optional. Maximum distance in meters from a relevant latitude and longitude that the pass is relevant.
  /// This number is compared to the pass’s default distance and the smaller value is used.
  /// Available in iOS 7.0.
  final int? maxDistance;

  /// Recommended for event tickets and boarding passes; otherwise optional.
  /// Date and time when the pass becomes relevant. For example, the start time of a movie.
  /// The value must be a complete date with hours and minutes, and may optionally include seconds.
  final String? relevantDate;

  // Associated App Keys

  /// Optional. A list of iTunes Store item identifiers for the associated apps.
  /// Only one item in the list is used—the first item identifier for an app compatible with the current device.
  /// If the app is not installed, the link opens the App Store and shows the app.
  /// If the app is already installed, the link launches the app.
  final List<int>? associatedStoreIdentifiers;

  /// Optional. A URL to be passed to the associated app when launching it.
  /// The app receives this URL in the application:didFinishLaunchingWithOptions: and application:openURL:options:
  /// methods of its app delegate.
  /// If this key is present, the associatedStoreIdentifiers key must also be present.
  final String? appLaunchURL;

  // Expiration Keys

  /// Optional. Date and time when the pass expires.
  /// The value must be a complete date with hours and minutes, and may optionally include seconds.
  /// Available in iOS 7.0.
  final String? expirationDate;

  /// Optional. Indicates that the pass is void—for example, a one time use coupon that has been redeemed. The default value is false.
  /// Available in iOS 7.0.
  final bool? voided;

  /// Convert to json
  Map<String, dynamic> toJson() => _$PassJsonToJson(this);

  @override
  List<Object?> get props => [
        formatVersion,
        storeCard,
        coupon,
        generic,
        eventTicket,
        boardingPass,
        passTypeIdentifier,
        description,
        teamIdentifier,
        labelColor,
        backgroundColor,
        foregroundColor,
        organizationName,
        webServiceURL,
        serialNumber,
        authenticationToken,
        associatedStoreIdentifiers,
        appLaunchURL,
        expirationDate,
        voided,
        groupingIdentifier,
        logoText,
        suppressStripShine,
        barcodes,
        barcode,
        locations,
      ];
}
