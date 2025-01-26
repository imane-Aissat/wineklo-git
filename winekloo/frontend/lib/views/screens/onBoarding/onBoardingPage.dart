import 'package:flutter/material.dart';
import 'onBoardingData.dart';
import '/views/widgets/onBoarding.dart';
import '/views/themes/styles/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;

  void _onNext() {
    if (_currentIndex < onboardingItems.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // Onboarding content
            Expanded(
              child: OnboardingWidget(item: onboardingItems[_currentIndex]),
            ),
            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingItems.length, (index) {
                return Container(
                  margin: const EdgeInsets.all(7.0),
                  width: _currentIndex == index ? screenWidth * 0.03 : screenWidth * 0.02,
                  height: _currentIndex == index ? screenWidth * 0.03 : screenWidth * 0.02,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? darkOrangeColor : veryLightOrangeColor,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: screenHeight * 0.03),
            // "Next" button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: ElevatedButton(
                onPressed: _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightOrangeColor,
                  foregroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.15,
                  ),
                ),
                child: Text(
                  _currentIndex == onboardingItems.length - 1 ? 'GET STARTED' : 'NEXT',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            // "Skip" button
            if (_currentIndex < onboardingItems.length - 1)
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth * 0.04,
                    color: darkGrayColor,
                  ),
                ),
              ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}
