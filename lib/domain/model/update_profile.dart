// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'update_profile.g.dart';

@JsonSerializable()
class UpdateProfileModel {
  UpdateProfileModel(
      {required this.uid,
      required this.full_name,
      required this.email,
      required this.phone_number,
      required this.brief,
      required this.membership_type});

  String uid;
  String full_name;
  String email;
  String phone_number;
  String brief;
  String membership_type;

  factory UpdateProfileModel.fromJson(var json) =>
      _$UpdateProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileModelToJson(this);
}
