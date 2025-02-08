class SpecialFeatures {
  final int? featureID;
  final String? feature;

  SpecialFeatures({
    this.featureID,
    this.feature,
  });

  factory SpecialFeatures.fromJson(Map<String, dynamic> json) {
    return SpecialFeatures(
      featureID: json['FeatureID'],
      feature: json['Feature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FeatureID': featureID,
      'Feature': feature,
    };
  }
}