// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'order_apartment_for_rent.g.dart';

@JsonSerializable()
class OrderApartmentForRentModel {
  OrderApartmentForRentModel(
      {required this.uid,
      required this.category_id,
      required this.rent_pay_period,
      required this.bedrooms,
      required this.livingrooms,
      required this.bathrooms,
      required this.floor_number,
      required this.property_age,
      required this.is_furnished,
      required this.has_car_entrance,
      required this.has_special_roof,
      required this.is_apartment_in_a_villa,
      required this.has_double_entrance,
      required this.has_special_entrance,
      required this.price,
      required this.area,
      required this.description,
      required this.location_address,
      required this.location_latlng,
      required this.country});

  String uid;
  int category_id;
  String rent_pay_period;
  String bedrooms;
  String livingrooms;
  String bathrooms;
  String floor_number;
  String property_age;
  bool is_furnished;
  bool has_car_entrance;
  bool has_special_roof;
  bool is_apartment_in_a_villa;
  bool has_double_entrance;
  bool has_special_entrance;
  String price;
  String area;
  String description;
  String location_address;
  String location_latlng;
  int country;

  factory OrderApartmentForRentModel.fromJson(var json) =>
      _$OrderApartmentForRentModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderApartmentForRentModelToJson(this);
}
