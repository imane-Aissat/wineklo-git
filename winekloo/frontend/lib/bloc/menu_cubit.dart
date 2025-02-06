import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart'; // Adjust the import path

class MenuCubit extends Cubit<List<Menu>> {
  MenuCubit() : super([]);

  static const String baseUrl = "http://127.0.0.1:5000"; // Replace with your backend URL

  Future<void> loadMenus() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/menu"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final menus = data.map((e) => Menu.fromJson(e)).toList();
        emit(menus);
      } else {
        emit([]);
      }
    } catch (e) {
      print("Error fetching menus: $e");
      emit([]);
    }
  }
}