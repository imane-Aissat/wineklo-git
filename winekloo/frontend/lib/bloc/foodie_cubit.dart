import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/foodie_model.dart';

class FoodieCubit extends Cubit<Foodie?> {
  FoodieCubit() : super(null);

  static const String baseUrl = "http://127.0.0.1:5000";  

  Future<void> loadProfile(int foodieID) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/foodie/$foodieID"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final foodie = Foodie.fromJson(data); 
        emit(foodie); 
      } else {
        emit(null);  
      }
    } catch (e) {
      print("Error fetching profile: $e");
      emit(null);
    }
  }

  Future<void> updateFoodieDetails({String? fullname, String? email, String? phoneNumber}) async {
  final currentFoodie = state;
  if (currentFoodie == null) return;
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
    headers: {"Content-Type": "application/json"},
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
    if (currentFoodie != null) {

      final response = await http.put(
        Uri.parse("$baseUrl/foodie/update/${currentFoodie.foodieID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(currentFoodie.toJson()),  
      );

      if (response.statusCode == 200) {
        emit(currentFoodie);  
      } else {
        print("Error saving profile");
      }
    }
  }

  Future<void> deleteProfile(int foodieID) async {
    final response = await http.delete(Uri.parse("$baseUrl/foodie/delete/$foodieID"));

    if (response.statusCode == 200) {
      emit(null);  
    } else {
      print("Error deleting profile");
    }
  }

  Future<void> logout() async {
    emit(null);
  }
}
