import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';

Widget _buildPhoneField(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015), // Adjust vertical padding
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.045, // Responsive font size
            color: blackColor,
          ),
        ),
        SizedBox(height: screenHeight * 0.01), // Adjust spacing
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor,
            hintText: 'Enter your phone number',
            hintStyle: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.035, // Responsive font size
              color: darkGrayColor,
            ),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: screenWidth * 0.02), // Adjust spacing before the flag
                Image.asset(
                  'assets/icons/algeria.png', // Correct asset path
                  width: screenWidth * 0.04, // Responsive width
                  height: screenHeight * 0.035, // Responsive height
                  fit: BoxFit.contain,
                ),
                SizedBox(width: screenWidth * 0.02), // Adjust spacing between flag and text
                Text(
                  '+213',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.04, // Responsive font size
                    color: darkGrayColor,
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  width: screenWidth * 0.04, // Adjust divider spacing
                  color: darkGrayColor,
                ),
              ],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsive border radius
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, // Adjust horizontal padding
              vertical: screenHeight * 0.015, // Adjust vertical padding
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    ),
  );
}
