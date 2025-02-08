import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/foodie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FoodieCubit extends Cubit<Foodie?> {

  static const String baseUrl = "http://127.0.0.1:5000";

  FoodieCubit() : super(null);

    Future<void> loadProfile() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        emit(null);
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/foodie/logged'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final foodie = Foodie.fromJson(data);
        emit(foodie);
      } else {
        emit(null);
      }
    }

    Future<void> updateFoodieDetails({String? fullname, String? email, String? phoneNumber}) async {
      final currentFoodie = state;
      if (currentFoodie == null) return;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        print("Error: No authentication token found. Please log in.");
        return;
      }

      final updatedFoodie = {
        "FoodieID": currentFoodie.foodieID,
        "Email": email ?? currentFoodie.email,
        "PhoneNumber": phoneNumber ?? currentFoodie.phoneNumber,
        "Password": currentFoodie.password,
        "Birthday": null,
        "Gender": currentFoodie.gender,
        "Wilaya": currentFoodie.wilaya,
        "Photo": currentFoodie.photo,
        "FoodieCategories": currentFoodie.foodieCategories,
        "FoodiePreferences": currentFoodie.foodiePreferences,
        "FoodiePricing": currentFoodie.foodiePricing,
        "full_name": fullname ?? currentFoodie.fullname,
      };

      print(updatedFoodie);

      final response = await http.post(
        Uri.parse("$baseUrl/foodie/updateprofile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(updatedFoodie),
      );

      if (response.statusCode == 200) {
        emit(Foodie.fromJson(updatedFoodie));  
      } else {
        print("Error updating profile: ${response.body}");
      }
    }



    Future<void> saveProfile() async {
      final currentFoodie = state;
      if (currentFoodie == null) return;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        print("Error: No authentication token found. Please log in.");
        return;
      }

      final response = await http.put(
        Uri.parse("$baseUrl/foodie/update/${currentFoodie.foodieID}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(currentFoodie.toJson()),
      );

      if (response.statusCode == 200) {
        emit(currentFoodie);  
      } else {
        print("Error saving profile: ${response.body}");
      }
    }


    Future<void> deleteProfile() async {
      final currentFoodie = state;
      if (currentFoodie == null) {
        print("Error: No logged-in foodie found.");
        return;
      }

      final response = await http.delete(
        Uri.parse("$baseUrl/foodie/delete/${currentFoodie.foodieID}"),
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('jwt_token');
        emit(null);  
      } else {
        print("Error deleting profile: ${response.body}");
      }
    }

    Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
      emit(null);
    }

}
