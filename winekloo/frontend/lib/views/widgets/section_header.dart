import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final void Function() onClear;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045,
            color: blackColor,
          ),
        ),
        TextButton(
          onPressed: onClear,
          child: Text(
            'Clear All',
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.035,
              color: darkOrangeColor,
            ),
          ),
        ),
      ],
    );
  }
}
