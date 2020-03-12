import 'package:json_annotation/json_annotation.dart';

part 'barcode.g.dart';

@JsonSerializable()
class Barcode {
  String altText;
  String format;
  String message;
  String messageEncoding;

  Barcode({this.altText, this.format, this.message, this.messageEncoding});

  factory Barcode.fromJson(Map<String, dynamic> json) =>
      _$BarcodeFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeToJson(this);
}