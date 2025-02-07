class Restaurateur {
  final int? restaurateurID;
  final String? diningType;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? location;
  final String? photo;
  final Map<String, dynamic>? workingHours;
  final List<String>? workingDays; 
  final String? description;
  final String? ratingValueAverage;
  final String? menuFilePDF;
  final int? categories;
  final int? dietaryPreferences;
  final int? specialFeatures;
  final int? pricing;
  final bool? verified;

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
    this.categories,
    this.dietaryPreferences,
    this.specialFeatures,
    this.pricing,
    this.verified,
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
      workingHours: json['WorkingHours'] != null 
          ? (json['WorkingHours'] is Map<String, dynamic>
              ? Map<String, dynamic>.from(json['WorkingHours']) 
              : null) 
          : null,
      workingDays: json['WorkingDays'] != null 
          ? List<String>.from(json['WorkingDays'] ?? []) 
          : null,
      description: json['Description'],
      ratingValueAverage: json['RatingValueAverage'],
      menuFilePDF: json['MenuFilePDF'],
      categories: json['Categories'],
      dietaryPreferences: json['DietaryPreferences'],
      specialFeatures: json['SpecialFeatures'],
      pricing: json['Pricing'],
      verified: json['verified'],
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
      'Categories': categories,
      'DietaryPreferences': dietaryPreferences,
      'SpecialFeatures': specialFeatures,
      'Pricing': pricing,
      'verified': verified,
    };
  }
}
