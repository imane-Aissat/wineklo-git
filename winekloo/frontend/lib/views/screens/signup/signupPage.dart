import 'package:flutter/material.dart';
import '/views/themes/styles/styles.dart';
import '/views/themes/styles/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedRole = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: darkBlueColor,
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1), // Adjust height with MediaQuery

                // Title Centered at the Top
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Sign Up',
                        style: whiteHeadlineStyle.copyWith(
                          fontSize: screenWidth * 0.06, // Adjust font size with screen width
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Who Are You?',
                        style: whiteSubheadingStyle.copyWith(
                          fontSize: screenWidth * 0.04, // Adjust font size with screen width
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.08), // Adjust height with MediaQuery

                // Role Selection - Centered
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Foodie Option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRole = "foodie";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedRole == "foodie"
                                ? darkOrangeColor
                                : Colors.transparent,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02, // Adjust vertical padding
                          horizontal: screenWidth * 0.05, // Adjust horizontal padding
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.12, // Adjust circle size with screen width
                              backgroundImage: const AssetImage('assets/images/foodie.png'), // Replace with Foodie image URL
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(height: screenHeight * 0.01), // Adjust space
                            Text(
                              'Foodie',
                              style: whiteSubheadingStyle.copyWith(
                                fontSize: screenWidth * 0.04, // Adjust font size with screen width
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.08), // Adjust space between options
                    // Restaurateur Option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRole = "restaurateur";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedRole == "restaurateur"
                                ? darkOrangeColor
                                : Colors.transparent,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02, // Adjust vertical padding
                          horizontal: screenWidth * 0.05, // Adjust horizontal padding
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.12, // Adjust circle size with screen width
                              backgroundImage: const AssetImage(
                                 'assets/images/restaurateur.png'), // Replace with Restaurateur image URL
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(height: screenHeight * 0.01), // Adjust space
                            Text(
                              'Restaurateur',
                              style: whiteSubheadingStyle.copyWith(
                                fontSize: screenWidth * 0.04, // Adjust font size with screen width
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.05), // Adjust space

             // Bottom Section - Next Button and Login Link
Padding(
  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08), // Adjust horizontal padding dynamically
  child: Column(
    children: [
      ElevatedButton(
        style: razprimaryButtonStyle.copyWith(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              vertical: screenHeight * 0.015, // Adjust vertical padding dynamically
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(screenWidth * 0.8, screenHeight * 0.08), // Button width and height responsive
          ),
        ),
        onPressed: _selectedRole.isEmpty
            ? null
            : () {
                if (_selectedRole == "foodie") {
                  Navigator.pushNamed(context, '/FoodieSignupPage');
                } else if (_selectedRole == "restaurateur") {
                  Navigator.pushNamed(context, '/RestauSignupPage');
                }
              },
        child: Text(
          'NEXT',
          style: TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.05, // Dynamically adjusts font size based on screen width
            color: _selectedRole.isEmpty ? Colors.transparent : whiteColor, // Disable color when no role is selected
          ),
        ),
      ),
    
                      SizedBox(height: screenHeight * 0.02), // Adjust space
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: whiteSubheadingStyle.copyWith(
                              fontSize: screenWidth * 0.04, // Adjust font size
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
                                fontSize: screenWidth * 0.04, // Adjust font size
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Adjust space
              ],
            ),
          ),

          // Back Arrow Button
          Positioned(
            top: screenHeight * 0.05, // Adjust position
            left: screenWidth * 0.04, // Adjust position
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
    );
  }
}
