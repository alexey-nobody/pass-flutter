import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barcode.g.dart';

/// Information specific to the pass’s barcode.
@JsonSerializable()
class Barcode extends Equatable {
  /// Creates a new [Barcode]
  const Barcode({
    required this.format,
    required this.message,
    required this.messageEncoding,
    this.altText,
  });

  /// Convert from json
  factory Barcode.fromJson(Map<String, dynamic> json) =>
      _$BarcodeFromJson(json);

  /// Optional. Text displayed near the barcode.
  /// For example, a human-readable version of the barcode data in case the barcode doesn’t scan.
  final String? altText;

  /// Required. Barcode format. For the barcode dictionary, you can use only the following values:
  /// PKBarcodeFormatQR, PKBarcodeFormatPDF417, or PKBarcodeFormatAztec.
  /// For dictionaries in the barcodes array, you may also use PKBarcodeFormatCode128.
  final String format;

  /// Required. Message or payload to be displayed as a barcode.
  final String message;

  /// Required. Text encoding that is used to convert the message from the string representation
  /// to a data representation to render the barcode. The value is typically iso-8859-1, but you may
  /// use another encoding that is supported by your barcode scanning infrastructure.
  final String messageEncoding;

  /// Convert to json
  Map<String, dynamic> toJson() => _$BarcodeToJson(this);

  @override
  List<Object?> get props => [altText, format, message, messageEncoding];
}
