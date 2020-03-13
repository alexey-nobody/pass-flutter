import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  double altitude;
  double latitude;
  double longitude;
  String relevantText;

  Location({this.altitude, this.latitude, this.longitude, this.relevantText});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
