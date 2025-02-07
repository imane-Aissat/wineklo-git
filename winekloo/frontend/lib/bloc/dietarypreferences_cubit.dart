import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/dietarypreferences_model.dart';

class DietaryPreferencesCubit extends Cubit<List<DietaryPreferences>> {
  DietaryPreferencesCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; // Adjust based on your backend

  // Load all dietary preferences
  Future<void> loadDietaryPreferences() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/dietary_preferences"));

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

  // Load dietary preference by ID
  Future<void> loadDietaryPreferenceById(int dietaryPreferenceId) async {
  if (dietaryPreferenceId == 0) {
    emit([]);
    return;
  }

  try {
    final response = await http.get(Uri.parse("$baseUrl/dietarypreferences/$dietaryPreferenceId"));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      
      // ✅ Convert single object to a list
      final dietaryPreference = DietaryPreferences.fromJson(data);
      emit([dietaryPreference]);  
      
    } else {
      emit([]);
    }
  } catch (e) {
    print("Error fetching dietary preference by ID: $e");
    emit([]);
  }
}

}
