import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/dietarypreferences_model.dart'; // Adjust the import path

class DietaryPreferencesCubit extends Cubit<List<DietaryPreferences>> {
  DietaryPreferencesCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; // Replace with your backend URL

  Future<void> loadDietaryPreferences() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/dietarypreferences"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final preferences = data.map((e) => DietaryPreferences.fromJson(e)).toList();
        emit(preferences);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching dietary preferences: $e");
      emit([]);
    }
  }
}