import 'package:json_annotation/json_annotation.dart';
import 'package:pass_flutter/src/models/pass_json/store_card/fields/fields.dart';

part 'pass_structure_dictionary.g.dart';

@JsonSerializable()
class PassStructureDictionary {
  List<Fields> headerFields;
  List<Fields> secondaryFields;
  List<Fields> backFields;

  PassStructureDictionary({this.headerFields, this.secondaryFields, this.backFields});

  factory PassStructureDictionary.fromJson(Map<String, dynamic> json) =>
      _$PassStructureDictionaryFromJson(json);

  Map<String, dynamic> toJson() => _$PassStructureDictionaryToJson(this);
}
