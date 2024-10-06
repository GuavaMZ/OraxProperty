// ignore_for_file: non_constant_identifier_names

class PropertyOrderModel {
  PropertyOrderModel(
      {required this.category_id,
      required this.country,
      required this.price_range,
      required this.area_range,
      required this.description,
      required this.phoneNumber,
      required this.email});

  int category_id;
  int country;
  String price_range;
  String area_range;
  String description;
  String phoneNumber;
  String email;

  factory PropertyOrderModel.fromJson(Map<String, dynamic> json) {
    return PropertyOrderModel(
        category_id: json['category_id'],
        country: json['country'],
        price_range: json['price_range'],
        area_range: json['area_range'],
        description: json['description'],
        phoneNumber: json['phone_number'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() => {
        "category_id": category_id,
        "country": country,
        "price_range": price_range,
        "area_range": area_range,
        "description": description,
        "phone_number": phoneNumber,
        "email": email
      };
}
