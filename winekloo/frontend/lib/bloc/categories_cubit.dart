import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart'; // Adjust the import path

class CategoriesCubit extends Cubit<List<Categories>> {
  CategoriesCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; // Replace with your backend URL

  Future<void> loadCategories() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/categories"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final categories = data.map((e) => Categories.fromJson(e)).toList();
        emit(categories);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching categories: $e");
      emit([]);
    }
  }

  Future<Categories?> loadCategoryById(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/categories/$id"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Categories.fromJson(data);
      } else {
        print("Category not found.");
        return null;
      }
    } catch (e) {
      print("Error fetching category by ID: $e");
      return null;
    }
  }
}
