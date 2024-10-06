// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'favourites.g.dart';

@JsonSerializable()
class FavouritesModel {
  FavouritesModel({
    required this.uid,
    required this.ad_id
  });

  String uid;
  int ad_id;

    factory FavouritesModel.fromJson(var json) =>
      _$FavouritesModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavouritesModelToJson(this);
}

@JsonSerializable()
class FavouritesAdsModel {
  FavouritesAdsModel({
    required this.data
  });

  List data;

    factory FavouritesAdsModel.fromJson(var json) =>
      _$FavouritesAdsModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavouritesAdsModelToJson(this);
}