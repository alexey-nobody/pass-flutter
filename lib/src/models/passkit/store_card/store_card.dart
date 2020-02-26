import 'package:json_annotation/json_annotation.dart';
import 'package:pass_flutter/src/models/passkit/store_card/fields/fields.dart';

part 'store_card.g.dart';

@JsonSerializable()
class StoreCard {
  List<Fields> headerFields;
  List<Fields> secondaryFields;
  List<Fields> backFields;

  StoreCard({this.headerFields, this.secondaryFields, this.backFields});

  factory StoreCard.fromJson(Map<String, dynamic> json) =>
      _$StoreCardFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCardToJson(this);
}
