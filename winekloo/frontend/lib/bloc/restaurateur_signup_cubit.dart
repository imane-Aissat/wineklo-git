import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/restaurateur_model.dart';

class SignupState {
  final int currentStep;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeToTerms;
  final String? selectedDiningType;
  final String restaurantName;
  final String address;
  final String phone;
  final String email;
final Map<String, Map<String, String>> workingHours;
  final List<String>? selectedWorkingDays;
  final List<String> selectedCategories;
  final List<String> selectedDietaryOptions;
  final List<String> selectedSpecialFeatures;
  final List<String> selectedPricing;
  final String otherCategory;
  final String otherDietary;
  final String updateOtherSpecialFeature;
  final double? ratingValueAverage;
  final String? menuFilePDF;
   final   String? description;

  final TextEditingController businessNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController verificationCodeController;
  final TextEditingController businessLocationController;
  final Map<String, Map<String, TextEditingController>> workingHoursControllers ;
  final TextEditingController descriptionController;

  
  SignupState({
    required this.currentStep,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.agreeToTerms,
    required this.selectedDiningType,
    required this.restaurantName,
    required this.address,
    required this.phone,
    required this.ratingValueAverage,
    required this.menuFilePDF,
    required this.workingHours,
    required this.selectedWorkingDays,
    required this.email,
    required this.description,
    required this.selectedCategories,
    required this.selectedDietaryOptions,
    required this.selectedSpecialFeatures,
    required this.selectedPricing,
    required this.otherCategory,
    required this.otherDietary,
    required this.updateOtherSpecialFeature,
    required this.businessNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.verificationCodeController,
    required this.businessLocationController,
    required this.workingHoursControllers,
    required this.descriptionController,

  });

  SignupState copyWith({
    int? currentStep,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? agreeToTerms,
    String? selectedDiningType,
    String? restaurantName,
    String? address,
    String? phone,
    String? email,
    double? ratingValueAverage,
    String? menuFilePDF,
    String? description,
    List<String>? selectedCategories,
    List<String>? selectedDietaryOptions,
    List<String>? selectedSpecialFeatures,
    List<String>? selectedPricing,
    List<String>? selectedWorkingDays,
    String? otherCategory,
    String? otherDietary,
    String? updateOtherSpecialFeature,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? verificationCodeController,
    TextEditingController? businessLocationController,
    Map<String, Map<String, TextEditingController>>? workingHoursControllers,
    TextEditingController? descriptionController, 
    Map<String, Map<String, String>>? workingHours,
  }) {
    return SignupState(
      currentStep: currentStep ?? this.currentStep,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      selectedDiningType: selectedDiningType ?? this.selectedDiningType,
      restaurantName: restaurantName ?? this.restaurantName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      description: description ?? this.description,

      ratingValueAverage: ratingValueAverage ?? this.ratingValueAverage,
      menuFilePDF: menuFilePDF ?? this.menuFilePDF,
      workingHours: workingHours ?? this.workingHours,
      selectedWorkingDays: selectedWorkingDays ?? this.selectedWorkingDays,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedDietaryOptions: selectedDietaryOptions ?? this.selectedDietaryOptions,
      selectedSpecialFeatures: selectedSpecialFeatures ?? this.selectedSpecialFeatures,
      selectedPricing: selectedPricing ?? this.selectedPricing,
      otherCategory: otherCategory ?? this.otherCategory,
      otherDietary: otherDietary ?? this.otherDietary,
      updateOtherSpecialFeature: updateOtherSpecialFeature ?? this.updateOtherSpecialFeature,
      businessNameController: businessNameController ?? businessNameController,
      emailController: emailController ?? emailController,
      phoneController: phoneController ?? phoneController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      verificationCodeController: verificationCodeController ?? this.verificationCodeController,
      businessLocationController: businessLocationController ?? this.businessLocationController,
      workingHoursControllers: workingHoursControllers ?? this.workingHoursControllers,
      descriptionController: descriptionController ?? this.descriptionController,
    );
  }
}

class SignupInitial extends SignupState {
  SignupInitial({super.currentStep = 0})
      : super(
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedDiningType: null,
          restaurantName: '',
          address: '',
          phone: '',
          email: '',
          description: '',
          workingHours: {
  'Monday': {'opening': '', 'closing': ''},
  'Tuesday': {'opening': '', 'closing': ''},
  'Wednesday': {'opening': '', 'closing': ''},
  'Thursday': {'opening': '', 'closing': ''},
  'Friday': {'opening': '', 'closing': ''},
  'Saturday': {'opening': '', 'closing': ''},
  'Sunday': {'opening': '', 'closing': ''},
},

          selectedWorkingDays: [],
          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedSpecialFeatures: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          updateOtherSpecialFeature:'',
          businessNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          verificationCodeController: TextEditingController(),
          businessLocationController: TextEditingController(),
          workingHoursControllers: {
  'Monday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Tuesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Wednesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Thursday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Friday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Saturday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Sunday': {'opening': TextEditingController(), 'closing': TextEditingController()},
},
          descriptionController: TextEditingController(),
          ratingValueAverage: 0.0,
          menuFilePDF: '',
        );
}

class SignupStepChanged extends SignupState {
  SignupStepChanged({required super.currentStep})
      : super(
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedDiningType: null,
          restaurantName: '',
          address: '',
          phone: '',
          email: '',
          description: '',
          workingHours: {
  'Monday': {'opening': '', 'closing': ''},
  'Tuesday': {'opening': '', 'closing': ''},
  'Wednesday': {'opening': '', 'closing': ''},
  'Thursday': {'opening': '', 'closing': ''},
  'Friday': {'opening': '', 'closing': ''},
  'Saturday': {'opening': '', 'closing': ''},
  'Sunday': {'opening': '', 'closing': ''},
},

                      selectedWorkingDays: [],

          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedSpecialFeatures: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          updateOtherSpecialFeature:'',
          businessNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          verificationCodeController: TextEditingController(),
          businessLocationController: TextEditingController(),
         workingHoursControllers: {
  'Monday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Tuesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Wednesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Thursday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Friday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Saturday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Sunday': {'opening': TextEditingController(), 'closing': TextEditingController()},
},
          descriptionController: TextEditingController(),
                    ratingValueAverage: 0.0,
          menuFilePDF: '',
        );
}

class SignupSuccess extends SignupState {
  SignupSuccess()
      : super(
          currentStep: 0,
          obscurePassword: true,
          obscureConfirmPassword: true,
          agreeToTerms: false,
          selectedDiningType: null,
          restaurantName: '',
          address: '',
          phone: '',
          email: '',
          description: '',
         workingHours: {
  'Monday': {'opening': '', 'closing': ''},
  'Tuesday': {'opening': '', 'closing': ''},
  'Wednesday': {'opening': '', 'closing': ''},
  'Thursday': {'opening': '', 'closing': ''},
  'Friday': {'opening': '', 'closing': ''},
  'Saturday': {'opening': '', 'closing': ''},
  'Sunday': {'opening': '', 'closing': ''},
},

          selectedWorkingDays: [],
          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedSpecialFeatures: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          updateOtherSpecialFeature:'',
          businessNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          verificationCodeController: TextEditingController(),
          businessLocationController: TextEditingController(),
         workingHoursControllers: {
  'Monday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Tuesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Wednesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Thursday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Friday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Saturday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Sunday': {'opening': TextEditingController(), 'closing': TextEditingController()},
},
          descriptionController: TextEditingController(),
          ratingValueAverage: 0.0,
          menuFilePDF: '',
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
          selectedDiningType: null,
          restaurantName: '',
          address: '',
          phone: '',
          email: '',
          description: '',
        workingHours: {
  'Monday': {'opening': '', 'closing': ''},
  'Tuesday': {'opening': '', 'closing': ''},
  'Wednesday': {'opening': '', 'closing': ''},
  'Thursday': {'opening': '', 'closing': ''},
  'Friday': {'opening': '', 'closing': ''},
  'Saturday': {'opening': '', 'closing': ''},
  'Sunday': {'opening': '', 'closing': ''},
},

                      selectedWorkingDays: [],

          selectedCategories: [],
          selectedDietaryOptions: [],
          selectedSpecialFeatures: [],
          selectedPricing: [],
          otherCategory: '',
          otherDietary: '',
          updateOtherSpecialFeature:'',
          businessNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          verificationCodeController: TextEditingController(),
          businessLocationController: TextEditingController(),
         workingHoursControllers: {
  'Monday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Tuesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Wednesday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Thursday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Friday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Saturday': {'opening': TextEditingController(), 'closing': TextEditingController()},
  'Sunday': {'opening': TextEditingController(), 'closing': TextEditingController()},
},
          descriptionController: TextEditingController(),
          ratingValueAverage: 0.0,
          menuFilePDF: '',
        );
}

class RestaurateurSignupCubit extends Cubit<SignupState> {
  final RestaurateurRepository restaurateurRepository;

  RestaurateurSignupCubit({required this.restaurateurRepository}) : super(SignupInitial());

  void nextStep() {
    final currentStep = state.currentStep;
    if (currentStep < 3) {
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

  void updateDiningType(String? value) {
    emit(state.copyWith(selectedDiningType: value));
  }

  void updateRestaurantName(String value) {
    emit(state.copyWith(restaurantName: value));
  }

  void updateRestaurantAddress(String value) {
    emit(state.copyWith(address: value));
  }

  void updateRestaurantPhone(String value) {
    emit(state.copyWith(phone: value));
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

  void toggleSpecialFeature(String specialFeature) {
    final updatedSpecialFeatures = List<String>.from(state.selectedSpecialFeatures);
    if (updatedSpecialFeatures.contains(specialFeature)) {
      updatedSpecialFeatures.remove(specialFeature);
    } else {
      updatedSpecialFeatures.add(specialFeature);
    }
    emit(state.copyWith(selectedSpecialFeatures: updatedSpecialFeatures));
  }

  void updateOtherSpecialFeature(String value) {
    emit(state.copyWith(otherCategory: value));
  }

  void clearSpecialFeatures() {
    emit(state.copyWith(selectedSpecialFeatures: []));
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

void onWorkingDaysChanged(List<String> workingDays) {
  emit(state.copyWith(selectedWorkingDays: workingDays));
  
}
void onRatingChanged(double rating) {
  emit(state.copyWith(ratingValueAverage: rating));
}

void onMenuFileSelected(String filePath) {
  emit(state.copyWith(menuFilePDF: filePath));
}
  void toggleWorkingDay(String day) {
    final updatedWorkingDays = List<String>.from(state.selectedWorkingDays as Iterable);
    if (updatedWorkingDays.contains(day)) {
      updatedWorkingDays.remove(day);
    } else {
      updatedWorkingDays.add(day);
    }
    emit(state.copyWith(selectedWorkingDays: updatedWorkingDays));
  }

  void updateWorkingHours(String day, String openingTime, String closingTime) {
    final updatedWorkingHours = Map<String, Map<String, String>>.from(state.workingHours);
    updatedWorkingHours[day] = {'opening': openingTime, 'closing': closingTime};
    emit(state.copyWith(workingHours: updatedWorkingHours));
  }
void updateRestaurantDescription(String value) {
  emit(state.copyWith(description: value));
}

  void signup({
    required String diningType,
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String location,
    required String? photo,
    required Map<String, Map<String, String>> workingHours,
    required List<String>? workingDays,
    required String description,
    required double ratingValueAverage,
    required String menuFilePDF,
    required List<String> categories,
    required List<String> dietaryOptions,
    required List<String> specialFeatures,
    required List<String> pricing,
    
    

  }) async {
    try {


      final restaurant = Restaurateur(
        restaurateurID: null,
        diningType: diningType,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        location: location,
        photo: photo,
        workingHours: workingHours,
        workingDays: workingDays,
        description: description,
        ratingValueAverage: ratingValueAverage,
        menuFilePDF: menuFilePDF,
        restaurateurCategories: categories.length,
        restaurateurPreferences: dietaryOptions.length, 
        restaurateurSpecialFeatures: specialFeatures.length,
        restaurateurPricing: pricing.length,

      );

      await restaurateurRepository.createRestaurateur(restaurant);

      emit(SignupSuccess());
    } catch (error) {
      emit(SignupFailure(error.toString()));
    }
  }
}

