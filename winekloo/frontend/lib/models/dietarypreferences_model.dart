class DietaryPreferences {
  final int? preferenceID;
  final String? preference;

  DietaryPreferences({
    this.preferenceID,
    this.preference,
  });

  factory DietaryPreferences.fromJson(Map<String, dynamic> json) {
    return DietaryPreferences(
      preferenceID: json['PreferenceID'],
      preference: json['Preference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PreferenceID': preferenceID,
      'Preference': preference,
    };
  }
}