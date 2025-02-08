import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';


class LoginWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool rememberMe;
  final Function(bool) onPasswordVisibilityChange;
  final Function(bool) onRememberMeChange;
  final Function(String, String) onLogin;
  final VoidCallback onForgotPassword;
  final double screenWidth;
  final double screenHeight;

  LoginWidget({
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.rememberMe,
    required this.onPasswordVisibilityChange,
    required this.onRememberMeChange,
    required this.onLogin,
    required this.onForgotPassword,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email Input Field
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email Address',
                                  style: blackBodyTextStyle,

              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
          fillColor: lightGrayColor,
                    hintText: 'example@gmail.com',
                    hintStyle: grayBodyTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                ),
                                  style: grayBodyTextStyle,

              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),

        // Password Input Field
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Password',
                style:blackBodyTextStyle,

              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                    fillColor: lightGrayColor,
                  hintText: 'Enter your password',
                    hintStyle: grayBodyTextStyle,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                        color: darkGrayColor,
                    ),
                    onPressed: () =>
                        onPasswordVisibilityChange(!isPasswordVisible),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                ),
                                  style: grayBodyTextStyle,

              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),

        // Forgot Password and Remember Me Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (bool? value) {
                    onRememberMeChange(value ?? false);
                  },
          activeColor: darkOrangeColor,
                ),
                Text(
                  'Remember me',
                  style: TextStyle(
 fontFamily: 'Sen',
            fontSize: screenWidth * 0.035, // Reduced font size
            color: darkGrayColor,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: onForgotPassword,
              child:  Text(
        'Forgot Password',
        style: TextStyle(
          fontFamily: 'Sen',
          fontSize: screenWidth * 0.035,  // Reduced font size for better spacing
          color: darkOrangeColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),

        // Login Button
       SizedBox(
  width: screenWidth * 0.8,  // Make the button width responsive
  child: ElevatedButton(
    style: razprimaryButtonStyle.copyWith(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          vertical: screenHeight * 0.015, // Dynamic vertical padding
        ),
      ),
      minimumSize: WidgetStateProperty.all(
        Size(screenWidth * 0.8, screenHeight * 0.08),  // Fixed button height with responsive width
      ),
    ),
            onPressed: () =>
                onLogin(emailController.text, passwordController.text),
            child: Text(
              'LOG IN',
              style: TextStyle(
                  fontFamily: 'Sen',
        fontWeight: FontWeight.w600,
        fontSize: screenWidth * 0.045,  // Responsive text size based on screen width
        color: whiteColor,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),

        // Signup Link
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Are you new here?',
                style:grayBodyTextStyle,

              ),
              TextButton(
               onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: darkOrangeColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sen',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
