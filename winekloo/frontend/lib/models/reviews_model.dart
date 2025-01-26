class Review {
  final int reviewID;
  final int? restaurateurID;
  final int? foodieID;
  final String? comment;

  Review({
    required this.reviewID,
    this.restaurateurID,
    this.foodieID,
    this.comment,
    
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewID: json['ReviewID'],
      restaurateurID: json['RestaurateurID'],
      foodieID: json['FoodieID'],
      comment: json['Comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReviewID': reviewID,
      'RestaurateurID': restaurateurID,
      'FoodieID': foodieID,
      'Comment': comment,
    };
  }
}