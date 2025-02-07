import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/reviews_model.dart';

class ReviewsCubit extends Cubit<List<Review>> {
  ReviewsCubit() : super([]); // Initial state is an empty list

  static const String baseUrl = "http://127.0.0.1:5000"; // Change if needed

 
  // ✅ Fetch reviews by Restaurant ID
  Future<void> fetchReviewsByRestaurant(int restaurateurId) async {
    try {
      emit([]); // Show loading state
      final response = await http.get(Uri.parse("$baseUrl/reviews/restaurant/$restaurateurId"));

      print("API Response: ${response.body}"); // Debugging

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Review> reviews = data.map((json) => Review.fromJson(json)).toList();
        emit(reviews);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching reviews by restaurant ID: $e");
      emit([]);
    }
  }

 
}