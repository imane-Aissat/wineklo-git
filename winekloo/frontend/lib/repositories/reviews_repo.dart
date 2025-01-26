import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reviews_model.dart';

class ReviewRepository {
  final database = Supabase.instance.client.from('reviews');

  Future createReview (Review newReview) async {
    await database.insert(newReview.toJson());
  }

  Future<List<Review>> getAllReviews() async {
    final response = await database.select();
    return (response as List)
        .map((data) => Review.fromJson(data))
        .toList();
  }

  Future deleteReview(int reviewID) async {
    final response = await database.delete().eq('ReviewID', reviewID);
  }
}
