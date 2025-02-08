import 'package:flutter/material.dart';
import 'package:userworkside/views/themes/styles/colors.dart';

class PasswordField extends StatelessWidget {
  final BuildContext context;
  final String label;
  final bool obscureText;
  final VoidCallback toggleObscure;
  final TextEditingController controller;

  PasswordField({
    required this.context,
    required this.label,
    required this.obscureText,
    required this.toggleObscure,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              label,
            style: const TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: blackColor,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrayColor,
              hintText: 'Enter your $label',
              hintStyle: TextStyle(
                fontFamily: 'Sen',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.04,
                color: darkGrayColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: toggleObscure,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
            ),
          ),
        ],
      ),
    );
  }
}