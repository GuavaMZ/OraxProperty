// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'ads_apartment_for_sale.g.dart';

@JsonSerializable()
class ApartmentForSaleModel {
  ApartmentForSaleModel({
    this.uid,
    required this.category_id,
    required this.bedrooms,
    required this.livingrooms,
    required this.bathrooms,
    required this.floor_number,
    required this.property_age,
    required this.has_car_entrance,
    required this.has_special_roof,
    required this.is_apartment_in_a_villa,
    required this.has_double_entrances,
    required this.has_special_entrance,
    required this.price,
    required this.area,
    required this.description,
    required this.location_latlng,
    required this.location_address,
    required this.country,
  });
  String? uid;
  int category_id;
  String bedrooms;
  String livingrooms;
  String bathrooms;
  String floor_number;
  String property_age;
  bool has_car_entrance;
  bool has_special_roof;
  bool is_apartment_in_a_villa;
  bool has_double_entrances;
  bool has_special_entrance;
  String price;
  String area;
  String description;
  String location_latlng;
  String location_address;
  int country;

  factory ApartmentForSaleModel.fromJson(var json) =>
      _$ApartmentForSaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApartmentForSaleModelToJson(this);
}
