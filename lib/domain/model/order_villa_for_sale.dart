// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'order_villa_for_sale.g.dart';

@JsonSerializable()
class OrderVillaForSaleModel {
  OrderVillaForSaleModel(
      {required this.uid,
      required this.category_id,
      required this.bedrooms,
      required this.livingrooms,
      required this.bathrooms,
      required this.property_age,
      required this.has_car_entrance,
      // required this.has_special_roof,
      // required this.is_apartment_in_a_villa,
      // required this.has_double_entrance,
      // required this.has_special_entrance,
      required this.price,
      required this.area,
      required this.is_furnished,
      required this.apartments,
      required this.street_width,
      required this.has_driver_room,
      required this.has_kitchen,
      required this.is_duplex,
      required this.has_basement,
      required this.with_stairs,
      required this.has_maid_room,
      required this.has_pool,
      required this.description,
      required this.location_address,
      required this.location_latlng,required this.country});

  String uid;
  int category_id;
  String bedrooms;
  String livingrooms;
  String bathrooms;
  String property_age;
  bool has_car_entrance;
  // bool has_special_roof;
  // bool is_apartment_in_a_villa;
  // bool has_double_entrance;
  // bool has_special_entrance;
  String price;
  String area;
  bool is_furnished;
  String apartments;
  String street_width;
  bool has_driver_room;
  bool has_kitchen;
  bool is_duplex;
  bool has_basement;
  bool with_stairs;
  bool has_maid_room;
  bool has_pool;
  String description;
  String location_address;
  String location_latlng;
  int country;

  factory OrderVillaForSaleModel.fromJson(var json) =>
      _$OrderVillaForSaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderVillaForSaleModelToJson(this);
}
