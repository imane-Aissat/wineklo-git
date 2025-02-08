import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  PhoneField({required this.controller});

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
            'Phone Number',
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: blackColor,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrayColor,
              hintText: 'Enter your phone number',
              hintStyle: TextStyle(
                fontFamily: 'Sen',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.035,
                color: darkGrayColor,
              ),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset(
                    'assets/icons/algeria.png',
                    width: screenWidth * 0.04,
                    height: screenHeight * 0.035,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    '+213',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.04,
                      color: darkGrayColor,
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: screenWidth * 0.04,
                    color: darkGrayColor,
                  ),
                ],
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
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
