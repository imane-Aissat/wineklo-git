class DietaryPreferences {
  final int? preferenceID;
  final String? preferenceName;

  DietaryPreferences({
    this.preferenceID,
    this.preferenceName,
  });

  factory DietaryPreferences.fromJson(Map<String, dynamic> json) {
    return DietaryPreferences(
      preferenceID: json['PreferenceID'],
      preferenceName: json['PreferenceName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PreferenceID': preferenceID,
      'PreferenceName': preferenceName,
    };
  }
}
