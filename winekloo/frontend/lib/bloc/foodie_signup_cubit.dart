import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/foodie_model.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupState {
  final int currentStep;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeToTerms;
  final String? selectedGender;
  final String? selectedWilaya;
  final List<String> selectedCategories;
  final List<String> selectedDietaryOptions;
  final List<String> selectedPricing;
  final String otherCategory;
  final String otherDietary;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController dateOfBirthController;
  final TextEditingController verificationCodeController;

  SignupState({
    required this.currentStep,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.agreeToTerms,
    required this.selectedGender,
    required this.selectedWilaya,
    required this.selectedCategories,
    required this.selectedDietaryOptions,
    required this.selectedPricing,
    required this.otherCategory,
    required this.otherDietary,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.dateOfBirthController,
    required this.verificationCodeController,
  });

  SignupState copyWith({
    int? currentStep,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? agreeToTerms,
    String? selectedGender,
    String? selectedWilaya,
    List<String>? selectedCategories,
    List<String>? selectedDietaryOptions,
    List<String>? selectedPricing,
    String? otherCategory,
    String? otherDietary,
    TextEditingController? fullNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? dateOfBirthController,
    TextEditingController? verificationCodeController,
  }) {
    return SignupState(
      currentStep: currentStep ?? this.currentStep,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedWilaya: selectedWilaya ?? this.selectedWilaya,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedDietaryOptions: selectedDietaryOptions ?? this.selectedDietaryOptions,
      selectedPricing: selectedPricing ?? this.selectedPricing,
      otherCategory: otherCategory ?? this.otherCategory,
      otherDietary: otherDietary ?? this.otherDietary,
      fullNameController: fullNameController ?? this.fullNameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      dateOfBirthController: dateOfBirthController ?? this.dateOfBirthController,
      verificationCodeController: verificationCodeController ?? this.verificationCodeController,
    );
  }
}

class SignupInitial extends SignupState {
  SignupInitial({int currentStep = 0})
      : super(
          currentStep: currentStep,
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedGender: null,
          selectedWilaya: null,
          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          dateOfBirthController: TextEditingController(),
          verificationCodeController: TextEditingController(),
        );
}
class SignupStepChanged extends SignupState {
  SignupStepChanged({required int currentStep})
      : super(
          currentStep: currentStep,
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedGender: null,
          selectedWilaya: null,
          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          dateOfBirthController: TextEditingController(),
          verificationCodeController: TextEditingController(),
        );
}
class SignupSuccess extends SignupState {
  SignupSuccess()
      : super(
          currentStep: 0,
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedGender: null,
          selectedWilaya: null,
          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          dateOfBirthController: TextEditingController(),
          verificationCodeController: TextEditingController(),
        );
}
class SignupFailure extends SignupState {
  final String errorMessage;

  SignupFailure(this.errorMessage)
      : super(
          currentStep: 0,
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedGender: null,
          selectedWilaya: null,
          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          dateOfBirthController: TextEditingController(),
          verificationCodeController: TextEditingController(),
        );
}
class SignupLoading extends SignupState {
  SignupLoading()
      : super(
          currentStep: 0,
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedGender: null,
          selectedWilaya: null,
          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          dateOfBirthController: TextEditingController(),
          verificationCodeController: TextEditingController(),
        );
}

class FoodieSignupCubit extends Cubit<SignupState> {
  FoodieSignupCubit() : super(SignupInitial());

  static const String baseUrl = "http://127.0.0.1:5000";  

  void nextStep() {
    final currentStep = state.currentStep;
    if (currentStep < 2) {
      emit(state.copyWith(currentStep: currentStep + 1));
      print("Moved to next step: ${currentStep + 1}");
    }
  }

  void previousStep() {
    final currentStep = state.currentStep;
    if (currentStep > 0) {
      emit(state.copyWith(currentStep: currentStep - 1));
      print("Moved to previous step: ${currentStep - 1}");
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void updateAgreeToTerms(bool value) {
    emit(state.copyWith(agreeToTerms: value));
  }

  void updateGender(String? value) {
    emit(state.copyWith(selectedGender: value));
  }

  void updateWilaya(String? value) {
    emit(state.copyWith(selectedWilaya: value));
  }

  void toggleCategory(String category) {
    final updatedCategories = List<String>.from(state.selectedCategories);
    if (updatedCategories.contains(category)) {
      updatedCategories.remove(category);
    } else {
      updatedCategories.add(category);
    }
    emit(state.copyWith(selectedCategories: updatedCategories));
  }

  void updateOtherCategory(String value) {
    emit(state.copyWith(otherCategory: value));
  }

  void clearCategories() {
    emit(state.copyWith(selectedCategories: []));
  }

  void toggleDietaryOption(String option) {
    final updatedDietaryOptions = List<String>.from(state.selectedDietaryOptions);
    if (updatedDietaryOptions.contains(option)) {
      updatedDietaryOptions.remove(option);
    } else {
      updatedDietaryOptions.add(option);
    }
    emit(state.copyWith(selectedDietaryOptions: updatedDietaryOptions));
  }

  void updateOtherDietary(String value) {
    emit(state.copyWith(otherDietary: value));
  }

  void clearDietaryOptions() {
    emit(state.copyWith(selectedDietaryOptions: []));
  }

  void togglePricing(String price) {
    final updatedPricing = List<String>.from(state.selectedPricing);
    if (updatedPricing.contains(price)) {
      updatedPricing.remove(price);
    } else {
      updatedPricing.add(price);
    }
    emit(state.copyWith(selectedPricing: updatedPricing));
  }

  void clearPricing() {
    emit(state.copyWith(selectedPricing: []));
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // Function to handle sign-up via HTTP
  Future<void> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String gender,
    required String wilaya,
    required List<String> categories,
    required List<String> dietaryOptions,
    required List<String> pricing, 
  }) async {
    try {
      emit(SignupLoading());

      // Check if foodie exists via HTTP request
      final existsResponse = await http.get(Uri.parse('$baseUrl/foodie/check/$email'));
      if (existsResponse.statusCode == 200 && existsResponse.body == 'true') {
        throw Exception('An account with this email already exists');
      }

      // Validate fields
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email or password cannot be empty');
      }
      if (password != confirmPassword) {
        throw Exception('Passwords do not match');
      }



      // Prepare the foodie data
      final foodie = {
        "full_name ": fullName,
        "email": email,
        "phone": phone,
        "password": hashPassword(password),
        "gender": gender,
        "wilaya": wilaya,
        "categories": categories,
        "dietaryOptions": dietaryOptions,
        "pricing": pricing
      };

      // Send the sign-up request
      final signUpResponse = await http.post(
        Uri.parse('$baseUrl/foodie/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(foodie),
      );

      if (signUpResponse.statusCode == 201) {
        emit(SignupSuccess());
      } else {
        print('Response body: ${signUpResponse.body}');
        print('Foodie data: $foodie');

        throw Exception('Failed to create foodie');
      }
    } catch (error) {
      emit(SignupFailure(error.toString()));
    }
  }
}





