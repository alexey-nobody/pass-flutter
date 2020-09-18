import 'package:json_annotation/json_annotation.dart';
import 'package:pass_flutter/pass_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pass_flutter/src/common/color_helper.dart';

part 'pass_boarding_pass.g.dart';

/// A JSON dictionary that defines the pass with type coupon card
@JsonSerializable()
class PassBoardingPass extends PassJson {
  /// Information specific to a coupon card.
  @JsonKey(name: 'boardingPass')
  final PassStructureDictionary passData;

  /// Creates a new [PassCouponCard]
  const PassBoardingPass({
    this.passData,
    int formatVersion,
    String passTypeIdentifier,
    String description,
    String teamIdentifier,
    Color labelColor,
    Color backgroundColor,
    Color foregroundColor,
    String organizationName,
    String webServiceURL,
    String serialNumber,
    String authenticationToken,
    List<int> associatedStoreIdentifiers,
    String appLaunchURL,
    String expirationDate,
    bool voided,
    String groupingIdentifier,
    String logoText,
    bool suppressStripShine,
    List<Barcode> barcodes,
    Barcode barcode,
    List<Location> locations,
    int maxDistance,
    String relevantDate,
  }) : super(
          formatVersion: formatVersion,
          passTypeIdentifier: passTypeIdentifier,
          description: description,
          teamIdentifier: teamIdentifier,
          labelColor: labelColor,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          organizationName: organizationName,
          webServiceURL: webServiceURL,
          serialNumber: serialNumber,
          authenticationToken: authenticationToken,
          associatedStoreIdentifiers: associatedStoreIdentifiers,
          appLaunchURL: appLaunchURL,
          expirationDate: expirationDate,
          voided: voided,
          groupingIdentifier: groupingIdentifier,
          logoText: logoText,
          suppressStripShine: suppressStripShine,
          barcodes: barcodes,
          barcode: barcode,
          locations: locations,
          maxDistance: maxDistance,
          relevantDate: relevantDate,
        );

  @override
  List<Object> get props => [
        passData,
        formatVersion,
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

  /// Convert from json
  factory PassBoardingPass.fromJson(Map<String, dynamic> json) =>
      _$PassBoardingPassFromJson(json);

  /// Convert to json
  @override
  Map<String, dynamic> toJson() => _$PassBoardingPassToJson(this);
}
