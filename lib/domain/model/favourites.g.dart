// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritesModel _$FavouritesModelFromJson(Map<String, dynamic> json) =>
    FavouritesModel(
      uid: json['uid'] as String,
      ad_id: (json['ad_id'] as num).toInt(),
    );

Map<String, dynamic> _$FavouritesModelToJson(FavouritesModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'ad_id': instance.ad_id,
    };

FavouritesAdsModel _$FavouritesAdsModelFromJson(Map<String, dynamic> json) =>
    FavouritesAdsModel(
      data: json['data'] as List<dynamic>,
    );

Map<String, dynamic> _$FavouritesAdsModelToJson(FavouritesAdsModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
