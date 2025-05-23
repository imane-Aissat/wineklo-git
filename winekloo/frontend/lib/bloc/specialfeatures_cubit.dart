import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/specialfeatures_model.dart'; 

class SpecialFeaturesCubit extends Cubit<List<SpecialFeatures>> {
  SpecialFeaturesCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; 

  Future<void> loadSpecialFeatures() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/specialfeatures"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final features = data.map((e) => SpecialFeatures.fromJson(e)).toList();
        emit(features);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching special features: $e");
      emit([]);
    }
  }
   // New: Load SpecialFeatures by ID
  Future<void> loadSpecialFeaturesById(int specialfeaturesId) async {
    if (specialfeaturesId == 0) {
      emit([]);
      return;
    }

    try {
      final response = await http.get(Uri.parse("$baseUrl/specialfeatures/$specialfeaturesId"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final features = SpecialFeatures.fromJson(data);
        emit([features]);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching SpecialFeatures by ID: $e");
      emit([]);
    }
  }
}