import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:userworkside/models/reviews_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewsCubit extends Cubit<List<Review>> {
  ReviewsCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000";
  Future<void> loadReviews(int restaurateurID) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/reviews/$restaurateurID"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final List<Review> reviews = data.map((json) => Review.fromJson(json)).toList();
        emit(reviews);
      } else {
        print("Failed to load reviews: ${response.body}");
        emit([]);
      }
    } catch (e) {
      print("Error fetching reviews: $e");
      emit([]);
    }
  }



    Future<void> addReview({
      required int restaurateurID,
      required String comment,
      required int rating,
    }) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('jwt_token');

        if (token == null) {
          print("Error: No authentication token found. Please log in.");
          return;
        }

        final response = await http.post(
          Uri.parse("$baseUrl/add/review/$restaurateurID"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode({
            "Comment": comment,
            "Rating": rating,
          }),
        );

        if (response.statusCode == 201) {
          final newReview = Review.fromJson(jsonDecode(response.body));
          emit([...state, newReview]); 
        } else {
          print("Failed to add review: ${response.body}");
        }
      } catch (e) {
        print("Error adding review: $e");
      }
    }

    Map<int, double> calculateRatingDistribution() {
    if (state.isEmpty) return {};

    final Map<int, int> ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var review in state) {
      if (review.rating != null && ratingCounts.containsKey(review.rating)) {
        ratingCounts[review.rating!] = ratingCounts[review.rating]! + 1;
      }
    }

    final totalReviews = state.length;
    return ratingCounts.map((key, value) => MapEntry(key, (value / totalReviews) * 100));
  }


  Future<void> loadReviewsRestaurant() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    emit([]);
    return;
  }

  final response = await http.get(
    Uri.parse('$baseUrl/reviews/onerestau/'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final reviews = data.map((review) => Review.fromJson(review)).toList();
    emit(reviews);
  } else {
    emit([]);
  }
}


}
