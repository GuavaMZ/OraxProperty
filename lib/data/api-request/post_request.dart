// ignore_for_file: non_constant_identifier_names

import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/domain/model/order_apartment_for_rent.dart';
import 'package:oraxproperty/domain/model/order_apartment_for_sale.dart';
import 'package:oraxproperty/domain/model/order_villa_for_rent.dart';
import 'package:oraxproperty/domain/model/order_villa_for_sale.dart';
import 'package:oraxproperty/domain/model/property_order_model.dart';
import 'package:oraxproperty/main.dart';

class PostPropertyRequestRequest {
  Future<String?> postRequestApartmentForSale(
      String uid,
      int category_id,
      String bedrooms,
      String livingrooms,
      String bathrooms,
      String floor_number,
      String property_age,
      bool has_car_entrance,
      bool has_special_roof,
      bool is_apartment_in_a_villa,
      bool has_double_entrance,
      bool has_special_entrance,
      String price,
      String area,
      String description,
      String location_address,
      String location_latlng,
      int country) async {
    String? requestResult;
    Map<String, dynamic> orderApartmentForSaleModel =
        OrderApartmentForSaleModel(
                uid: uid,
                category_id: category_id,
                bedrooms: bedrooms,
                livingrooms: livingrooms,
                bathrooms: bathrooms,
                floor_number: floor_number,
                property_age: property_age,
                has_car_entrance: has_car_entrance,
                has_special_roof: has_special_roof,
                is_apartment_in_a_villa: is_apartment_in_a_villa,
                has_double_entrance: has_double_entrance,
                has_special_entrance: has_special_entrance,
                price: price,
                area: area,
                description: description,
                location_address: location_address,
                location_latlng: location_latlng,
                country: country)
            .toJson();
    try {
      await supabase
          .from('properties_orders')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['order_id'] != null) {
              orderApartmentForSaleModel['order_id'] = val[0]['order_id'];
              await supabase
                  .from('order_apartment_for_sale')
                  .insert(orderApartmentForSaleModel)
                  .select()
                  .then((value) async {
                if (value[0]['order_id'] != null) {
                  requestResult = 'Success';
                }
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
      await supabase
          .from('properties_orders')
          .delete()
          .eq('order_id', orderApartmentForSaleModel['order_id']);
      Fluttertoast.showToast(msg: e.toString());
    }
    return requestResult;
  }

  Future<String?> postApartmentRequestForRent(
      String uid,
      int category_id,
      String rent_pay_period,
      String bedrooms,
      String livingrooms,
      String bathrooms,
      String floor_number,
      String property_age,
      bool is_furnished,
      bool has_car_entrance,
      bool has_special_roof,
      bool is_apartment_in_a_villa,
      bool has_double_entrance,
      bool has_special_entrance,
      String price,
      String area,
      String description,
      String location_address,
      String location_latlng,
      int country
      // Map<String, String> images,
      ) async {
    String? requestResult;
    Map<String, dynamic> orderApartmentForRentModel =
        OrderApartmentForRentModel(
                uid: uid,
                category_id: category_id,
                bedrooms: bedrooms,
                livingrooms: livingrooms,
                bathrooms: bathrooms,
                floor_number: floor_number,
                property_age: property_age,
                has_car_entrance: has_car_entrance,
                has_special_roof: has_special_roof,
                is_apartment_in_a_villa: is_apartment_in_a_villa,
                has_double_entrance: has_double_entrance,
                has_special_entrance: has_special_entrance,
                price: price,
                area: area,
                description: description,
                location_address: location_address,
                location_latlng: location_latlng,
                country: country,
                rent_pay_period: rent_pay_period,
                is_furnished: is_furnished)
            .toJson();
    try {
      await supabase
          .from('properties_orders')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['order_id'] != null) {
              orderApartmentForRentModel['order_id'] = val[0]['order_id'];
              await supabase
                  .from('order_apartment_for_rent')
                  .insert(orderApartmentForRentModel)
                  .select()
                  .then((value) async {
                if (value[0]['order_id'] != null) {
                  requestResult = 'Success';
                }
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
      await supabase
          .from('properties_orders')
          .delete()
          .eq('order_id', orderApartmentForRentModel['order_id']);
      Fluttertoast.showToast(msg: e.toString());
    }
    return requestResult;
  }

  Future<String?> postVillaRequestForSale(
    String uid,
    int category_id,
    String bedrooms,
    String livingrooms,
    String bathrooms,
    String property_age,
    bool has_car_entrance,
    bool has_special_roof,
    // bool is_apartment_in_a_villa,
    bool has_double_entrance,
    bool has_special_entrance,
    String price,
    String area,
    String description,
    String location_address,
    String location_latlng,
    int country,
    bool is_furnished,
    String apartments,
    String street_width,
    bool has_driver_room,
    bool has_kitchen,
    bool is_duplex,
    bool has_basement,
    bool with_stairs,
    bool has_maid_room,
    bool has_pool,
    // Map<String, String> images,
  ) async {
    String? requestResult;
    Map<String, dynamic> orderVillaForSaleModel = OrderVillaForSaleModel(
            uid: uid,
            category_id: category_id,
            bedrooms: bedrooms,
            livingrooms: livingrooms,
            bathrooms: bathrooms,
            property_age: property_age,
            has_car_entrance: has_car_entrance,
            // has_special_roof: has_special_roof,
            // is_apartment_in_a_villa: is_apartment_in_a_villa,
            // has_double_entrance: has_double_entrance,
            // has_special_entrance: has_special_entrance,
            price: price,
            area: area,
            description: description,
            location_address: location_address,
            location_latlng: location_latlng,
            country: country,
            is_furnished: is_furnished,
            apartments: apartments,
            street_width: street_width,
            has_driver_room: has_driver_room,
            has_kitchen: has_kitchen,
            is_duplex: is_duplex,
            has_basement: has_basement,
            with_stairs: with_stairs,
            has_maid_room: has_maid_room,
            has_pool: has_pool)
        .toJson();
    try {
      await supabase
          .from('properties_orders')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['order_id'] != null) {
              orderVillaForSaleModel['order_id'] = val[0]['order_id'];
              await supabase
                  .from('order_villa_for_sale')
                  .insert(orderVillaForSaleModel)
                  .select()
                  .then((value) async {
                if (value[0]['order_id'] != null) {
                  requestResult = 'Success';
                }
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
      await supabase
          .from('properties_orders')
          .delete()
          .eq('order_id', orderVillaForSaleModel['order_id']);
      Fluttertoast.showToast(msg: e.toString());
    }
    return requestResult;
  }

  Future<String?> postVillaForRent(
    String uid,
    int category_id,
    String bedrooms,
    String livingrooms,
    String bathrooms,
    String property_age,
    bool has_car_entrance,
    bool has_special_roof,
    // bool is_apartment_in_a_villa,
    bool has_double_entrance,
    bool has_special_entrance,
    String price,
    String area,
    String description,
    String location_address,
    String location_latlng,
    int country,
    bool is_furnished,
    String apartments,
    String street_width,
    bool has_driver_room,
    bool has_kitchen,
    bool is_duplex,
    bool has_basement,
    bool with_stairs,
    bool has_maid_room,
    bool has_pool,
    bool is_air_conditioned,
    String rent_pay_period,
    // Map<String, String> images,
  ) async {
    String? requestResult;
    Map<String, dynamic> orderVillaForRentModel = OrderVillaForRentModel(
            uid: uid,
            category_id: category_id,
            bedrooms: bedrooms,
            livingrooms: livingrooms,
            bathrooms: bathrooms,
            property_age: property_age,
            has_car_entrance: has_car_entrance,
            // has_special_roof: has_special_roof,
            // is_apartment_in_a_villa: is_apartment_in_a_villa,
            // has_double_entrance: has_double_entrance,
            // has_special_entrance: has_special_entrance,
            price: price,
            area: area,
            description: description,
            location_address: location_address,
            location_latlng: location_latlng,
            country: country,
            is_furnished: is_furnished,
            apartments: apartments,
            street_width: street_width,
            has_driver_room: has_driver_room,
            has_kitchen: has_kitchen,
            is_duplex: is_duplex,
            has_basement: has_basement,
            with_stairs: with_stairs,
            has_maid_room: has_maid_room,
            has_pool: has_pool,
            is_air_conditioned: is_air_conditioned,
            rent_pay_period: rent_pay_period)
        .toJson();
    try {
      await supabase
          .from('properties_orders')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['order_id'] != null) {
              orderVillaForRentModel['order_id'] = val[0]['order_id'];
              await supabase
                  .from('order_villa_for_rent')
                  .insert(orderVillaForRentModel)
                  .select()
                  .then((value) async {
                if (value[0]['order_id'] != null) {
                  requestResult = 'Success';
                }
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
      await supabase
          .from('properties_orders')
          .delete()
          .eq('order_id', orderVillaForRentModel['order_id']);

      Fluttertoast.showToast(msg: e.toString());
    }
    return requestResult;
  }

  Future postPropertyOrder(
    int category_id,
    int country,
    String price_range,
    String area_range,
    String description,
    String phoneNumber,
    String email,
  ) async {
    String? requestResult;
    Map<String, dynamic> propertyOrderModel = PropertyOrderModel(
            category_id: category_id,
            country: country,
            price_range: price_range,
            area_range: area_range,
            description: description,
            phoneNumber: phoneNumber,
            email: email)
        .toJson();
    try {
      await supabase
          .from('properties_orders')
          .insert(propertyOrderModel)
          .select()
          .then((res) {
        if (res[0]['order_id'] != null) {
          requestResult = 'Success';
        }
      });
      {}
    } catch (e) {
      requestResult = 'Upload Failed';
      Fluttertoast.showToast(msg: e.toString());
    }
    return requestResult;
  }
}
