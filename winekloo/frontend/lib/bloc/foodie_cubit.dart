import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/foodie_model.dart';

class FoodieCubit extends Cubit<Foodie?> {
  FoodieCubit() : super(null);

  // The base URL for your Flask API
  static const String baseUrl = "http://127.0.0.1:5000";  // Change this URL based on where your Flask app is hosted

  // Method to fetch foodie profile from backend
  Future<void> loadProfile(int foodieID) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/foodie/$foodieID"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final foodie = Foodie.fromJson(data);  // Assuming your Foodie model has a fromJson constructor
        emit(foodie);  // Update the state with the fetched foodie profile
      } else {
        emit(null);  // Handle error, no data found
      }
    } catch (e) {
      print("Error fetching profile: $e");
      emit(null);  // Handle connection or other errors
    }
  }

  // Method to update foodie profile, for instance after editing details
  Future<void> updateFoodieDetails({String? fullname, String? email, String? phoneNumber}) async {
    final currentFoodie = state;
    if (currentFoodie == null) return;

    if (fullname == currentFoodie.fullname &&
        email == currentFoodie.email &&
        phoneNumber == currentFoodie.phoneNumber) {
      return;  // No changes to save
    }

    final updatedFoodie = Foodie(
      foodieID: currentFoodie.foodieID,
      email: email ?? currentFoodie.email,
      phoneNumber: phoneNumber ?? currentFoodie.phoneNumber,
      password: currentFoodie.password,
      birthday: currentFoodie.birthday,
      gender: currentFoodie.gender,
      wilaya: currentFoodie.wilaya,
      photo: currentFoodie.photo,
      foodieCategories: currentFoodie.foodieCategories,
      foodiePreferences: currentFoodie.foodiePreferences,
      foodiePricing: currentFoodie.foodiePricing,
      fullname: fullname ?? currentFoodie.fullname,
    );

    // You would call an API endpoint here to update the foodie in the database
    // Example:
    final response = await http.put(
      Uri.parse("$baseUrl/foodie/update/${updatedFoodie.foodieID}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updatedFoodie.toJson()),  // Assuming you have a toJson() method
    );

    if (response.statusCode == 200) {
      emit(updatedFoodie);  // Update state with the new foodie data
    } else {
      print("Error updating profile");
    }
  }

  // Method to save profile (for example after editing)
  Future<void> saveProfile() async {
    final currentFoodie = state;
    if (currentFoodie != null) {
      // Assuming you want to save the profile after editing
      final response = await http.put(
        Uri.parse("$baseUrl/foodie/update/${currentFoodie.foodieID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(currentFoodie.toJson()),  // Send current foodie data
      );

      if (response.statusCode == 200) {
        emit(currentFoodie);  // Update state if the update was successful
      } else {
        print("Error saving profile");
      }
    }
  }

  // Method to delete profile
  Future<void> deleteProfile(int foodieID) async {
    final response = await http.delete(Uri.parse("$baseUrl/foodie/delete/$foodieID"));

    if (response.statusCode == 200) {
      emit(null);  // Clear the current foodie profile from state
    } else {
      print("Error deleting profile");
    }
  }

  // Method for logging out (just clears state)
  Future<void> logout() async {
    emit(null);
  }
}
