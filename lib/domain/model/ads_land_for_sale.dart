// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'ads_land_for_sale.g.dart';

@JsonSerializable()
class LandForSaleModel {
  LandForSaleModel({
     this.uid,
    required this.category_id,
    required this.price,
    required this.area,
    required this.landType,
    required this.description,
    required this.location_latlng,
    required this.location_address,
    required this.country,
    required this.street_width,
  });
  String? uid;
  int category_id;
  String price;
  String area;
  String landType;
  String description;
  String location_latlng;
  String location_address;
  int country;
  String street_width;

  factory LandForSaleModel.fromJson(var json) => _$LandForSaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$LandForSaleModelToJson(this);
}
