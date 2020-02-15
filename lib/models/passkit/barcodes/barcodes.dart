import 'package:json_annotation/json_annotation.dart';

part 'barcodes.g.dart';

@JsonSerializable()
class Barcodes {
  String altText;
  String format;
  String message;
  String messageEncoding;

  Barcodes({this.altText, this.format, this.message, this.messageEncoding});

  factory Barcodes.fromJson(Map<String, dynamic> json) =>
      _$BarcodesFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodesToJson(this);
}