import 'package:json_annotation/json_annotation.dart';
import 'package:pass_flutter/models/passkit/store_card/store_card.dart';

part 'passkit_pass.g.dart';

@JsonSerializable()
class PasskitPass {
  int formatVersion;
  StoreCard storeCard;
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
  bool voided;

  PasskitPass({
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
    this.voided,
  });

  factory PasskitPass.fromJson(Map<String, dynamic> json) =>
      _$PasskitPassFromJson(json);

  Map<String, dynamic> toJson() => _$PasskitPassToJson(this);
}
