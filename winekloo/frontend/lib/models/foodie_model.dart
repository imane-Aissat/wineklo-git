class Foodie {
  final int? foodieID;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final DateTime? birthday;
  final String? gender;
  final String? wilaya;
  final String? photo;
  final int? foodieCategories;
  final int? foodiePreferences;
  final int? foodiePricing;
  final String? fullname;

  Foodie({
    this.foodieID,
    this.email,
    this.phoneNumber,
    this.password,
    this.birthday,
    this.gender,
    this.wilaya,
    this.photo,
    this.foodieCategories,
    this.foodiePreferences,
    this.foodiePricing,
    this.fullname,
  });

  factory Foodie.fromJson(Map<String, dynamic> json) {
    return Foodie(
      foodieID: json['FoodieID'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      password: json['Password'],
      birthday: json['Birthday'] != null ? DateTime.parse(json['Birthday']) : null,
      gender: json['Gender'],
      wilaya: json['Wilaya'],
      photo: json['Photo'],
      foodieCategories: json['FoodieCategories'],
      foodiePreferences: json['FoodiePreferences'],
      foodiePricing: json['FoodiePricing'],
      fullname: json['full_name']
    );
  }

  get fullName => null;

  Map<String, dynamic> toJson() {
    return {
      'FoodieID': foodieID,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
      'Birthday': birthday?.toIso8601String(),
      'Gender': gender,
      'Wilaya': wilaya,
      'Photo': photo,
      'FoodieCategories': foodieCategories,
      'FoodiePreferences': foodiePreferences,
      'FoodiePricing': foodiePricing,
      'full_name' : fullname,
    };
  }
}
