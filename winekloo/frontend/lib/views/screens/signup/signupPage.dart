import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/views/themes/styles/styles.dart';
import '/views/themes/styles/colors.dart';
import '/bloc/role_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => RoleCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: darkBlueColor,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Sign Up',
                          style: whiteHeadlineStyle.copyWith(
                            fontSize: screenWidth * 0.06,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Who Are You?',
                          style: whiteSubheadingStyle.copyWith(
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.08),

                  BlocBuilder<RoleCubit, String>(
                    builder: (context, selectedRole) {
                      print("Rebuilding with selected role: $selectedRole");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Foodie Option
                          GestureDetector(
                            onTap: () {
                              context.read<RoleCubit>().updateRole('Foodie');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedRole == 'Foodie'
                                      ? darkOrangeColor
                                      : Colors.transparent,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.05,
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: screenWidth * 0.12,
                                    backgroundImage: const AssetImage('assets/images/foodie.png'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    'Foodie',
                                    style: whiteSubheadingStyle.copyWith(
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.08),
                          GestureDetector(
                            onTap: () {
                              context.read<RoleCubit>().updateRole('Restaurateur');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedRole == 'Restaurateur'
                                      ? darkOrangeColor
                                      : Colors.transparent,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.05,
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: screenWidth * 0.12,
                                    backgroundImage: const AssetImage('assets/images/restaurateur.png'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    'Restaurateur',
                                    style: whiteSubheadingStyle.copyWith(
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      children: [
                        BlocBuilder<RoleCubit, String>(
  builder: (context, selectedRole) {
    
                       return ElevatedButton(
                          style: razprimaryButtonStyle.copyWith(
                            padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(
                                vertical: screenHeight * 0.015,
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all(
                              Size(screenWidth * 0.8, screenHeight * 0.08),
                            ),
                          ),
                          onPressed: () {
        if (selectedRole == 'Foodie') {
          Navigator.pushNamed(context, '/FoodieSignupPage');
        } else if (selectedRole == 'Restaurateur') {
          Navigator.pushNamed(context, '/RestauSignupPage');
        }
      },
                          child: Text(
                            'NEXT',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.05,
                               color: (selectedRole == 'Foodie' || selectedRole == 'Restaurateur')
              ? whiteColor  // If a role is selected, set the color to white.
              : Colors.transparent, 
                            ),
                          ),
                        );
  }
  ),
                        SizedBox(height: screenHeight * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: whiteSubheadingStyle.copyWith(
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                'LOG IN',
                                style: TextStyle(
                                  color: darkOrangeColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sen',
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),

            // Back Arrow Button
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
        ),
      ),
    );
  }
}

