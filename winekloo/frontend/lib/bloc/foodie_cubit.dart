import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/foodie_model.dart';
import '../repositories/foodie_repo.dart';

class FoodieCubit extends Cubit<Foodie?> {
  final FoodieRepository _repository;

  
  FoodieCubit(this._repository) : super(null);

  
  Future<void> loadProfile(int foodieID) async {
    final foodie = await _repository.getOneFoodie(foodieID);
    emit(foodie); 
  }

  
  Future<void> updateFoodieDetails({String? fullname, String? email, String? phoneNumber}) async {
  final currentFoodie = state;
  if (currentFoodie == null) return;

  if (fullname == currentFoodie.fullname &&
      email == currentFoodie.email &&
      phoneNumber == currentFoodie.phoneNumber) {
    return;
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

  
  await _repository.updateFoodie(updatedFoodie);
  emit(updatedFoodie);
}


  Future<void> saveProfile() async {
    final currentFoodie = state;
    if (currentFoodie != null) {
      await _repository.updateFoodie(currentFoodie); 
    }
  }

 
  Future<void> deleteProfile(int foodieID) async { 
    if (foodieID != null) {
      await _repository.deleteFoodie(foodieID);  
      emit(null); 
    }
  }

  
  Future<void> logout() async {
    emit(null); 
  }
}
