import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/foodie_model.dart';

class FoodieRepository {
  final database = Supabase.instance.client.from('foodie');

Future createFoodie(Foodie newFoodie) async {
  final response = await database.insert({
    'Email': newFoodie.email,
    'PhoneNumber': newFoodie.phoneNumber,
    'Password': newFoodie.password,
    'Birthday': newFoodie.birthday?.toIso8601String(),
    'Gender': newFoodie.gender,
    'Wilaya': newFoodie.wilaya,
    'Photo': newFoodie.photo,
    'FoodieCategories': newFoodie.foodieCategories,
    'FoodiePreferences': newFoodie.foodiePreferences,
    'FoodiePricing': newFoodie.foodiePricing,
    'full_name': newFoodie.fullname,
  });
  return response;
}

  Future<List<Foodie>> getFoodies() async {
    final response = await database.select();
    return (response as List)
        .map((data) => Foodie.fromJson(data))
        .toList();
  }

  Future<Foodie?> getOneFoodie(int foodieID) async {
    try {
      final response = await database.select().eq('FoodieID', foodieID).single();
      return Foodie.fromJson(response);
    } catch (e) {
      print('Error fetching foodie: $e');
      return null;  
    }
  }



  final stream = Supabase.instance.client.from('foodie').stream(
    primaryKey: ['foodieID'],
  );

  Future<void> updateFoodie(Foodie updatedFoodie) async {
  final response = await database
      .update(updatedFoodie.toJson())  
      .eq('FoodieID', updatedFoodie.foodieID!);  

  if (response.error != null) {
    throw Exception('Failed to update foodie: ${response.error!.message}');
    }
  }

  Future deleteFoodie(int foodieID) async {
  final response = await database.delete().eq('FoodieID', foodieID);
  if (response.error != null) {
    print('Error deleting foodie: ${response.error!.message}');
    return;
  }
  print('Successfully deleted foodie with ID: $foodieID');
}

  Future<bool> checkFoodieExists(String email) async {
    final response = await database.select().eq('Email', email);
    return response.isNotEmpty;
  }

  Future<void> saveVerificationCode(String email, String code) async {
  final supabase = Supabase.instance.client;
  await supabase.from('otp_codes').insert({
    'email': email,
    'code': code,
    'expires_at': DateTime.now().add(Duration(minutes: 10)).toIso8601String(),
  });
}
Future<bool> checkVerificationCode(String email, String code) async {
  final supabase = Supabase.instance.client;
  final result = await supabase
      .from('otp_codes')
      .select()
      .eq('email', email)
      .eq('code', code)
      .single();

  final expiresAt = DateTime.parse(result['expires_at']);
  if (DateTime.now().isAfter(expiresAt)) {
    return false;
  }

  return true;
}


}
