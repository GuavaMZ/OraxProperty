// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:oraxproperty/domain/model/ads_apartment_for_rent.dart';
import 'package:oraxproperty/domain/model/ads_apartment_for_sale.dart';
import 'package:oraxproperty/domain/model/ads_land_for_rent.dart';
import 'package:oraxproperty/domain/model/ads_land_for_sale.dart';
import 'package:oraxproperty/domain/model/ads_villa_for_rent.dart';
import 'package:oraxproperty/domain/model/ads_villa_for_sale.dart';
import 'package:oraxproperty/main.dart';

class PostPropertyAdvertisementRequest {
  Future<String?> postApartmentForSale(
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
    bool has_double_entrances,
    bool has_special_entrance,
    String price,
    String area,
    String description,
    Map<String, String> images,
    String location_latlng,
    String location_address,
    int country,
  ) async {
    String? requestResult;
    Map<String, dynamic> apartmentForSaleModel = ApartmentForSaleModel(
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
      has_double_entrances: has_double_entrances,
      has_special_entrance: has_special_entrance,
      price: price,
      area: area,
      description: description,
      location_address: location_address,
      location_latlng: location_latlng,
      country: country,
    ).toJson();
    try {
      await supabase
          .from('advertisements')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['ad_id'] != null) {
              apartmentForSaleModel['ad_id'] = val[0]['ad_id'];
              await supabase
                  .from('ads_apartment_for_sale')
                  .insert(apartmentForSaleModel)
                  .select()
                  .then((value) async {
                if (value[0]['ad_id'] != null) {
                  for (var key in images.keys) {
                    await supabase.storage.from('properties_ads').upload(
                        'apartments_for_sale/${value[0]['ad_id']}/${File(images[key]!).path.toString().split('/').last}',
                        File(images[key]!));
                  }
                  requestResult = 'Success';
                }
                // await supabase.storage.from('properties_ads').upload('apartments_for_sale/${value[0]['id']}', file)
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
    }
    return requestResult;
  }

  Future<String?> postApartmentForRent(
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
    bool has_double_entrances,
    bool has_special_entrance,
    String price,
    String area,
    String description,
    Map<String, String> images,
    String location_latlng,
    String location_address,
    int country,
  ) async {
    String? requestResult;
    Map<String, dynamic> apartmentForRentModel = ApartmentForRentModel(
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
      has_double_entrances: has_double_entrances,
      has_special_entrance: has_special_entrance,
      price: price,
      area: area,
      description: description,
      location_address: location_address,
      location_latlng: location_latlng,
      rent_pay_period: rent_pay_period,
      is_furnished: is_furnished,
      country: country,
    ).toJson();
    try {
      await supabase
          .from('advertisements')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['ad_id'] != null) {
              apartmentForRentModel['ad_id'] = val[0]['ad_id'];
              await supabase
                  .from('ads_apartment_for_rent')
                  .insert(apartmentForRentModel)
                  .select()
                  .then((value) async {
                if (value[0]['ad_id'] != null) {
                  for (var key in images.keys) {
                    await supabase.storage.from('properties_ads').upload(
                        'apartments_for_rent/${value[0]['ad_id']}/${File(images[key]!).path.toString().split('/').last}',
                        File(images[key]!));
                  }
                  requestResult = 'Success';
                }
                // await supabase.storage.from('properties_ads').upload('apartments_for_rent/${value[0]['id']}', file)
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
    }
    return requestResult;
  }

  Future<String?> postVillaForSale(
    String uid,
    int category_id,
    String bedrooms,
    String livingrooms,
    String bathrooms,
    String property_age,
    bool has_car_entrance,
    bool has_special_roof,
    // bool is_apartment_in_a_villa,
    bool has_double_entrances,
    bool has_special_entrance,
    String price,
    String area,
    String description,
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
    Map<String, String> images,
    String location_latlng,
    String location_address,
    int country,
  ) async {
    String? requestResult;
    Map<String, dynamic> adsVillaForSaleModel = AdsVillaForSaleModel(
            uid: uid,
            category_id: category_id,
            bedrooms: bedrooms,
            livingrooms: livingrooms,
            bathrooms: bathrooms,
            property_age: property_age,
            has_car_entrance: has_car_entrance,
            has_special_roof: has_special_roof,
            // is_apartment_in_a_villa: is_apartment_in_a_villa,
            has_double_entrances: has_double_entrances,
            has_special_entrance: has_special_entrance,
            price: price,
            area: area,
            description: description,
            location_address: location_address,
            location_latlng: location_latlng,
            is_furnished: is_furnished,
            country: country,
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
          .from('advertisements')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['ad_id'] != null) {
              adsVillaForSaleModel['ad_id'] = val[0]['ad_id'];
              await supabase
                  .from('ads_villa_for_sale')
                  .insert(adsVillaForSaleModel)
                  .select()
                  .then((value) async {
                if (value[0]['ad_id'] != null) {
                  for (var key in images.keys) {
                    await supabase.storage.from('properties_ads').upload(
                        'villas_for_sale/${value[0]['ad_id']}/${File(images[key]!).path.toString().split('/').last}',
                        File(images[key]!));
                  }
                  requestResult = 'Success';
                }
                // await supabase.storage.from('properties_ads').upload('villas_for_sale/${value[0]['id']}', file)
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
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
    bool has_double_entrances,
    bool has_special_entrance,
    String price,
    String area,
    String description,
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
    Map<String, String> images,
    String location_latlng,
    String location_address,
    int country,
  ) async {
    String? requestResult;
    Map<String, dynamic> adsVillaForRentModel = AdsVillaForRentModel(
            uid: uid,
            category_id: category_id,
            bedrooms: bedrooms,
            livingrooms: livingrooms,
            bathrooms: bathrooms,
            property_age: property_age,
            has_car_entrance: has_car_entrance,
            has_special_roof: has_special_roof,
            // is_apartment_in_a_villa: is_apartment_in_a_villa,
            has_double_entrances: has_double_entrances,
            has_special_entrance: has_special_entrance,
            price: price,
            area: area,
            description: description,
            location_address: location_address,
            location_latlng: location_latlng,
            is_furnished: is_furnished,
            country: country,
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
          .from('advertisements')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['ad_id'] != null) {
              adsVillaForRentModel['ad_id'] = val[0]['ad_id'];
              await supabase
                  .from('ads_villa_for_rent')
                  .insert(adsVillaForRentModel)
                  .select()
                  .then((value) async {
                if (value[0]['ad_id'] != null) {
                  for (var key in images.keys) {
                    await supabase.storage.from('properties_ads').upload(
                        'villas_for_rent/${value[0]['ad_id']}/${File(images[key]!).path.toString().split('/').last}',
                        File(images[key]!));
                  }
                  requestResult = 'Success';
                }
                // await supabase.storage.from('properties_ads').upload('villas_for_sale/${value[0]['id']}', file)
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
    }
    return requestResult;
  }

  Future<String?> postLandForSale(
      String uid,
      int category_id,
      String price,
      String area,
      String landType,
      String description,
      Map<String, String> images,
      String location_latlng,
      String location_address,
      int country,
      String street_width) async {
    String? requestResult;
    Map<String, dynamic> adsLandForSale = LandForSaleModel(
            uid: uid,
            category_id: category_id,
            price: price,
            area: area,
            landType: landType,
            description: description,
            location_address: location_address,
            location_latlng: location_latlng,
            country: country,
            street_width: street_width)
        .toJson();
    try {
      await supabase
          .from('advertisements')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['ad_id'] != null) {
              adsLandForSale['ad_id'] = val[0]['ad_id'];
              await supabase
                  .from('ads_lands_for_sale')
                  .insert(adsLandForSale)
                  .select()
                  .then((value) async {
                if (value[0]['ad_id'] != null) {
                  for (var key in images.keys) {
                    await supabase.storage.from('properties_ads').upload(
                        'lands_for_sale/${value[0]['ad_id']}/${File(images[key]!).path.toString().split('/').last}',
                        File(images[key]!));
                  }
                  requestResult = 'Success';
                }
                // await supabase.storage.from('properties_ads').upload('villas_for_sale/${value[0]['id']}', file)
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
    }
    return requestResult;
  }

  Future<String?> postLandForRent(
    String uid,
    int category_id,
    String price,
    String area,
    String landType,
    String description,
    Map<String, String> images,
    String location_latlng,
    String location_address,
    int country,
    String street_width,
  ) async {
    String? requestResult;
    Map<String, dynamic> adsLandForRent = LandForRentModel(
            uid: uid,
            category_id: category_id,
            price: price,
            area: area,
            landType: landType,
            description: description,
            location_address: location_address,
            location_latlng: location_latlng,
            country: country,
            street_width: street_width)
        .toJson();
    try {
      await supabase
          .from('advertisements')
          .insert({'category_id': category_id})
          .select()
          .then((val) async {
            if (val[0]['ad_id'] != null) {
              adsLandForRent['ad_id'] = val[0]['ad_id'];
              await supabase
                  .from('ads_lands_for_rent')
                  .insert(adsLandForRent)
                  .select()
                  .then((value) async {
                if (value[0]['ad_id'] != null) {
                  for (var key in images.keys) {
                    await supabase.storage.from('properties_ads').upload(
                        'lands_for_rent/${value[0]['ad_id']}/${File(images[key]!).path.toString().split('/').last}',
                        File(images[key]!));
                  }
                  requestResult = 'Success';
                }
                // await supabase.storage.from('properties_ads').upload('villas_for_sale/${value[0]['id']}', file)
              });
            }
          });
    } catch (e) {
      print(e);
      requestResult = 'Upload Failed';
    }
    return requestResult;
  }
}
