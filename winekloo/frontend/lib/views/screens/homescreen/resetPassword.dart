import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController verificationController = TextEditingController();

  String? passwordError;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      size: screenWidth * 0.06,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Reset Password",
                    style: blackSubHeadlineStyle.copyWith(
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            textField(context, "NEW PASSWORD", screenWidth, screenHeight, newPasswordController),
            SizedBox(height: screenHeight * 0.03),
            textField(context, "VERIFICATION", screenWidth, screenHeight, verificationController),
            if (passwordError != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Text(
                  passwordError!,
                  style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.04),
                ),
              ),
            SizedBox(height: screenHeight * 0.05),
            SizedBox(
              width: screenWidth * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MAKE SURE THAT YOUR PASSWORD IS VALID:",
                    style: grayBodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  RichText(
                    text: const TextSpan(
                      style: grayBodyTextStyle,
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.brightness_1, size: 8.0, color: Colors.black),
                          ),
                        ),
                        TextSpan(text: "minimum of 8 characters\n"),
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.brightness_1, size: 8.0, color: Colors.black),
                          ),
                        ),
                        TextSpan(text: "contains a number\n"),
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.brightness_1, size: 8.0, color: Colors.black),
                          ),
                        ),
                        TextSpan(text: "contains a symbol"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight*0.08),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                style: primaryButtonStyle,
                onPressed: validatePassword,
                child: Text(
                  "Save changes",
                  style: whiteSubheadingStyle.copyWith(
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(BuildContext context, String label, double screenWidth, double screenHeight, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05),
          child: Text(
            label,
            style: blackBodyTextStyle.copyWith(
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          width: screenWidth * 0.8,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrayColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void validatePassword() {
    final newPassword = newPasswordController.text;
    final verification = verificationController.text;

    setState(() {
      if (newPassword.isEmpty || verification.isEmpty) {
        passwordError = "All fields are required.";
      } else if (newPassword != verification) {
        passwordError = "Passwords do not match.";
      } else if (newPassword.length < 8) {
        passwordError = "Password must be at least 8 characters long.";
      } else if (!RegExp(r'\d').hasMatch(newPassword)) {
        passwordError = "Password must contain at least one number.";
      } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(newPassword)) {
        passwordError = "Password must contain at least one symbol.";
      } else {
        passwordError = null;
        Navigator.pop(context);
      }
    });
  }
}
