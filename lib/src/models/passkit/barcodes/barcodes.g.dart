// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcodes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Barcodes _$BarcodesFromJson(Map<String, dynamic> json) {
  return Barcodes(
    altText: json['altText'] as String,
    format: json['format'] as String,
    message: json['message'] as String,
    messageEncoding: json['messageEncoding'] as String,
  );
}

Map<String, dynamic> _$BarcodesToJson(Barcodes instance) => <String, dynamic>{
      'altText': instance.altText,
      'format': instance.format,
      'message': instance.message,
      'messageEncoding': instance.messageEncoding,
    };
