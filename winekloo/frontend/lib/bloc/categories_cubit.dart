import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';

class CategoriesCubit extends Cubit<List<Categories>> {
  CategoriesCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; 

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

 
  Future<void> loadCategoryById(int categoryId) async {
    if (categoryId == 0) {
      emit([]);
      return;
    }

    try {
      final response = await http.get(Uri.parse("$baseUrl/categories/$categoryId"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final category = Categories.fromJson(data);
        emit([category]);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching category by ID: $e");
      emit([]);
    }
  }
}
