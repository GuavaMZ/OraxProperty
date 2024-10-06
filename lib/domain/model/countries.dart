// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'countries.g.dart';

@JsonSerializable()
class CountriesModel {
  CountriesModel({required this.countries});

  List countries;

  factory CountriesModel.fromJson(var json) =>
      _$CountriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesModelToJson(this);
}