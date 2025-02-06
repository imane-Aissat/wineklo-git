class Pricing {
  final int? pricingID;
  final double? priceValue;

  Pricing({
    this.pricingID,
    this.priceValue,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      pricingID: json['PricingID'],
      priceValue: json['PriceValue']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PricingID': pricingID,
      'PriceValue': priceValue,
    };
  }
}