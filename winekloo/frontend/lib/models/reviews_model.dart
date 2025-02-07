class Review {
  final int reviewID;
  final int? restaurateurID;
  final int? foodieID;
  final String? foodieName;
  final int? rating;
  final String? comment;
  final String? date;

  Review({
    required this.reviewID,
    this.restaurateurID,
    this.foodieID,
    this.foodieName,
    this.rating,
    this.comment,
    this.date, 
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewID: json['ReviewID'],
      restaurateurID: json['RestaurateurID'],
      foodieID: json['FoodieID'],
      foodieName: json['full_name'],
      rating: json['Rating'],
      comment: json['Comment'],
      date: json['Date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReviewID': reviewID,
      'RestaurateurID': restaurateurID,
      'FoodieID': foodieID,
      'full_name': foodieName,
      'Rating': rating,
      'Comment': comment,
      'Date': date, 
    };
  }
}
