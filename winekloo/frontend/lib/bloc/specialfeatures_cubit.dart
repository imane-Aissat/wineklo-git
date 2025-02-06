import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/specialfeatures_model.dart'; // Adjust the import path

class SpecialFeaturesCubit extends Cubit<List<SpecialFeatures>> {
  SpecialFeaturesCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; // Replace with your backend URL

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
}