import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';

class TabLabel extends StatelessWidget {
  final String title;
  final bool isActive;

  const TabLabel({
    Key? key,
    required this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isActive ? darkOrangeColor : Colors.grey,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          height: screenHeight * 0.005,
          width: screenWidth * 0.25,
          color: isActive ? darkOrangeColor : Colors.transparent,
        ),
      ],
    );
  }
}
