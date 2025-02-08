import 'package:flutter/material.dart';
import 'package:userworkside/views/widgets/_business_Information_step.dart';
import '/views/widgets/place_information_step.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/views/screens/food_managment/restaunavbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/views/widgets/tab_label.dart';
import '/views/widgets/verification_step.dart';

import '../../widgets/restau_account_information_step.dart';
import '/repositories/restaurateur_repo.dart';
import '/bloc/restaurateur_signup_cubit.dart';


class RestauSignupPage extends StatefulWidget {
  final RestaurateurRepository restaurateurRepository;

  const RestauSignupPage({Key? key, required this.restaurateurRepository}) : super(key: key);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
  @override
  _RestauSignupPageState createState() => _RestauSignupPageState();
}

class _RestauSignupPageState extends State<RestauSignupPage> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();
  final TextEditingController businessLocationController = TextEditingController();
  final Map<String, TextEditingController> workingHoursControllers = {};
  final TextEditingController descriptionController = TextEditingController();

  final List<String> _steps = [
    "Account\nInformation",
    "place\nInformation",
    "Cuisine\nPreferences",
    "Verification\nStep"
  ];


@override
Widget build(BuildContext context) {
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;

return Scaffold(
  body: BlocProvider(
    create: (_) => RestaurateurSignupCubit(restaurateurRepository: widget.restaurateurRepository),
        child: BlocConsumer<RestaurateurSignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
                print("Signup Success!");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => restoNavBar()), // Navigate on success
              );
            } else if (state is SignupFailure) {
              print("Signup Failure: ${state.errorMessage}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
builder: (context, state) {
  final cubit = context.read<RestaurateurSignupCubit>();
  final currentStep = state.currentStep;
        
    return Stack(
    children: [
      Container(
        color: darkBlueColor,
      ),
      Column(
        children: [
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
                        return TabLabel(title: step, isActive: currentStep == index,);
                      }).toList(),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (currentStep == 0) AccountInformationStep(
                                                                      businessNameController: cubit.state.businessNameController,
                                                                      emailController: cubit.state.emailController,
                                                                      phoneController: cubit.state.phoneController,
                                                                      passwordController: cubit.state.passwordController,
                                                                      confirmPasswordController: cubit.state.confirmPasswordController,
                                                                    ),
                          if (currentStep == 1)  PlaceInformationStep(businessLocationController: cubit.state.businessLocationController,
                                                                            workingHoursControllers: cubit.state.workingHoursControllers,
                                                                            workingHours: cubit.state.workingHours,
                                                                            descriptionController: cubit.state.descriptionController,),
                          if (currentStep == 2)  BusinessInformationStep(),
                          if (currentStep == 3)  VerificationStep(email: cubit.state.emailController.text,),
                          const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (currentStep <3)
                                    OutlinedButton.icon(
                                      onPressed: context.read<RestaurateurSignupCubit>().previousStep,
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
                                  if (currentStep == 3){
                                    cubit.signup(
                                    diningType: state.selectedDiningType ?? '',
                                    name: state.businessNameController.text,
                                    email: state.emailController.text,
                                    phoneNumber: state.phoneController.text,
                                    password: state.passwordController.text,
                                    confirmPassword: state.confirmPasswordController.text,
                                    location: state.businessLocationController.text,
                                    photo: state.phoneController.text ?? '',
                                    workingHours: state.workingHours,
                                    workingDays: state.selectedWorkingDays ?? [] ,
                                    description: state.descriptionController.text,
                                    ratingValueAverage: state.ratingValueAverage ?? 0.0,
                                    menuFilePDF: state.menuFilePDF ?? '',
                                    categories: state.selectedCategories,
                                    dietaryOptions: state.selectedDietaryOptions,
                                    specialFeatures: state.selectedSpecialFeatures,
                                    pricing: state.selectedPricing,
                                  );


                                  } else {
                                    cubit.nextStep();
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
