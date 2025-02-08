import 'package:flutter/material.dart';
import '/views/themes/styles/styles.dart';
import '/views/themes/styles/colors.dart';
import '/views/screens/onBoarding/onBoardingData.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            item.imagePath,
            width: 240,
            height: 292,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          item.title,
          style: blackHeadlineStyle.copyWith(color: blackColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            item.subtitle,
            style: grayBodyTextStyle.copyWith(color: darkGrayColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
