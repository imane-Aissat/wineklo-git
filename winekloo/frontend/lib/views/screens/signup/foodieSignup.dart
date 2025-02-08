import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/usernavbar.dart';
import '/views/widgets/tab_label.dart';
import '../../widgets/foodie_account_information_step.dart';
import '/views/widgets/personal_information_step.dart';
import '/views/widgets/cuisine_preferences_step.dart';
import '/views/widgets/verification_step.dart';
import '/bloc/foodie_signup_cubit.dart';
import '/repositories/foodie_repo.dart';

class FoodieSignupPage extends StatefulWidget {

    const FoodieSignupPage();

  @override
  _FoodieSignupPageState createState() => _FoodieSignupPageState();
}

class _FoodieSignupPageState extends State<FoodieSignupPage> {

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  String? selectedGender;
  String? selectedWilayaId;
  List<String> selectedCategories = [];
  List<String> selectedDietaryOptions = [];
  List<String> selectedPricing = [];
  String otherCategory = '';
  String otherDietary = '';

  final List<String> _steps = [
    "Account\nInformation",
    "Personal\nInformation",
    "Cuisine\nPreferences"
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        create: (_) => FoodieSignupCubit(),
        child: BlocConsumer<FoodieSignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
                print("Signup Success!");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UserNavBar()), // Navigate on success
              );
            } else if (state is SignupFailure) {
              print("Signup Failure: ${state.errorMessage}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
builder: (context, state) {
  final cubit = context.read<FoodieSignupCubit>();
  final currentStep = state.currentStep;

        
        return Stack(
              children: [
                Container(
                  color: darkBlueColor,
                ),
                Column(
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                      color: darkBlueColor,
                      child: const Center(
                        child: Text(
                          'Registration Form',
                          style: whiteHeadlineStyle,
                        ),
                      ),
                    ),
                    // Form content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.08),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: _steps.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  String step = entry.value;
                                  return TabLabel(
                                    title: step,
                                    isActive: currentStep == index,
                                  );
                                }).toList(),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  if (currentStep == 0) AccountInformationStep(
                                                                      fullNameController: cubit.state.fullNameController,
                                                                      emailController: cubit.state.emailController,
                                                                      phoneController: cubit.state.phoneController,
                                                                      passwordController: cubit.state.passwordController,
                                                                      confirmPasswordController: cubit.state.confirmPasswordController,
                                                                    ),

                                  if (currentStep == 1)
 PersonalInformationStep(
    dateOfBirthController: context.read<FoodieSignupCubit>().state.dateOfBirthController,
  ),
if (currentStep == 2) const CuisinePreferencesStep(),

                                    const SizedBox(height: 20),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (currentStep < 2)
                                          OutlinedButton.icon(
                                            onPressed: context.read<FoodieSignupCubit>().previousStep,
                                            style: razsecondaryButtonStyle.copyWith(
                                              padding: WidgetStateProperty.all(
                                                EdgeInsets.symmetric(
                                                  horizontal: screenWidth * 0.1,
                                                  vertical: screenHeight * 0.02,
                                                ),
                                              ),
                                            ),
                                            icon: const Icon(Icons.arrow_back, size: 24.0, color: blackColor),
                                            label: Text(
                                              'BACK',
                                              style: buttonTextStyle.copyWith(color: blackColor),
                                            ),
                                          )
                                        else
                                          const SizedBox(width: 150),
                                        
                                          ElevatedButton.icon(

                                            onPressed: () {
                                            
                                        if (currentStep == 2) {
                                                // Submit the form to cubit for signup
                                            context.read<FoodieSignupCubit>().signup(
  fullName: state.fullNameController.text,
  email: state.emailController.text,
  phone: state.phoneController.text,
  password: state.passwordController.text,
  confirmPassword: state.confirmPasswordController.text,
  gender: state.selectedGender ?? '',
  wilaya: state.selectedWilaya ?? '',
  categories: state.selectedCategories,
  dietaryOptions: state.selectedDietaryOptions,
  pricing: state.selectedPricing,
);


                                              } else {
                                                context.read<FoodieSignupCubit>().nextStep();
                                              }
                                            },
                                            style: razprimaryButtonStyle.copyWith(
                                              padding: WidgetStateProperty.all(
                                                EdgeInsets.symmetric(
                                                  horizontal: screenWidth * 0.1,
                                                  vertical: screenHeight * 0.02,
                                                ),
                                              ),
                                            ),
                                            icon: const Icon(Icons.arrow_forward, size: 24.0),
                                            label: const Text(
                                              'NEXT',
                                              style: buttonTextStyle,
                                            ),
                                          )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.04,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: lightGrayColor,
                      radius: 20.0,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: darkBlueColor,
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
