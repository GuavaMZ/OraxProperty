// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'categories.g.dart';

@JsonSerializable()
class PropertyCategoriesModel {
  PropertyCategoriesModel({required this.categories});

  List categories;

  factory PropertyCategoriesModel.fromJson(var json) =>
      _$PropertyCategoriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyCategoriesModelToJson(this);
}
