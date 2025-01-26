import 'package:flutter/material.dart';

class Restaurateur {
  final int? restaurateurID;
  final String? diningType;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? location;
  final String? photo;
  final Map<String, Map<String, String>>? workingHours;
  final List<String>? workingDays;
  final String? description;
  final double? ratingValueAverage;
  final String? menuFilePDF;
  final int? restaurateurCategories;
  final int? restaurateurPreferences;
  final int? restaurateurSpecialFeatures;
  final int? restaurateurPricing;

  Restaurateur({
    this.restaurateurID,
    this.diningType,
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.location,
    this.photo,
    this.workingHours,
    this.workingDays,
    this.description,
    this.ratingValueAverage,
    this.menuFilePDF,
    this.restaurateurCategories,
    this.restaurateurPreferences,
    this.restaurateurSpecialFeatures,
    this.restaurateurPricing,
  });

  factory Restaurateur.fromJson(Map<String, dynamic> json) {
    return Restaurateur(
      restaurateurID: json['RestaurateurID'],
      diningType: json['DiningType'],
      name: json['Name'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      password: json['Password'],
      location: json['Location'],
      photo: json['Photo'],
      workingHours: (json['WorkingHours'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(
        key,
        (value as Map<String, dynamic>).map(
          (innerKey, innerValue) => MapEntry(innerKey, innerValue as String),
        ),
      ),
    ),
      workingDays: (json['WorkingDays'] as List<dynamic>?)?.cast<String>(),
      description: json['Description'],
      ratingValueAverage: json['RatingValueAverage']?.toDouble(),
      menuFilePDF: json['MenuFilePDF'],
      restaurateurCategories: json['Categories'],
      restaurateurPreferences: json['DietaryPreferences'],
      restaurateurSpecialFeatures: json['SpecialFeatures'],
      restaurateurPricing: json['Pricing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RestaurateurID': restaurateurID,
      'DiningType': diningType,
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
      'Location': location,
      'Photo': photo,
      'WorkingHours': workingHours,
      'WorkingDays': workingDays,
      'Description': description,
      'RatingValueAverage': ratingValueAverage,
      'MenuFilePDF': menuFilePDF,
      'Categories': restaurateurCategories,
      'DietaryPreferences': restaurateurPreferences,
      'SpecialFeatures': restaurateurSpecialFeatures,
      'Pricing': restaurateurPricing,
    };
  }

  static TimeOfDay _timeOfDayFromString(String timeString) {
    final timeParts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );
  }

  static String _timeOfDayToString(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
