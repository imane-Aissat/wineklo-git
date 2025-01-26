import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/views/screens/food_managment/restaunavbar.dart';

import 'dart:io';


class RestauSignupPage extends StatefulWidget {
  const RestauSignupPage({super.key});

  @override
  _RestauSignupPageState createState() => _RestauSignupPageState();
}

class _RestauSignupPageState extends State<RestauSignupPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();

   final TextEditingController businessLocationController = TextEditingController();
  final Map<String, TextEditingController> workingHoursControllers = {};
  final TextEditingController descriptionController = TextEditingController();



  int _currentStep = 0;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  File? _restaurantImage;

  // For working days and hours
  final Map<String, String> _workingHours = {
    'Monday': '',
    'Tuesday': '',
    'Wednesday': '',
    'Thursday': '',
    'Friday': '',
    'Saturday': '',
    'Sunday': '',
  };



  final List<String> _steps = [
    "Account\nInformation",
    "place\nInformation",
    "Cuisine\nPreferences",
    "Verification\nStep"
  ];

  void _nextStep() {
    setState(() {
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

@override
Widget build(BuildContext context) {
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;

return Scaffold(
  body: Stack(
    children: [
      Container(
        color: darkBlueColor,
      ),
      Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
            color: darkBlueColor,
            child: const Center(
              child: Text(
                'Registration Form',
                style: whiteHeadlineStyle,
              ),
            ),
          ),

          // Form content
          Expanded(
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.08), // Adjust padding based on screen width
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              child: Column(
                children: [
                  // Step labels row (scrollable horizontally)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _steps.asMap().entries.map((entry) {
                        int index = entry.key;
                        String step = entry.value;
                        return _tabLabel(step, isActive: _currentStep == index);
                      }).toList(),
                    ),
                  ),

                  // Step Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_currentStep == 0) _accountInformationStep(),
                          if (_currentStep == 1) _placeInformationStep(),
                          if (_currentStep == 2) _businessInformationStep(),
                          if (_currentStep == 3) _verificationStep(context),
                          const SizedBox(height: 15),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Back Button
    if (_currentStep <3)
      OutlinedButton.icon(
        onPressed: _previousStep,
        style: razsecondaryButtonStyle.copyWith(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.02,
            ),
          ),
        ),
        icon: const Icon(Icons.arrow_back, size: 24.0, color: blackColor),
        label: Text(
          'BACK',
          style: buttonTextStyle.copyWith(color: blackColor),
        ),
      )
    else
      const SizedBox(width: 150), // Placeholder to align the "NEXT" button

    // Conditional rendering of Next/Verify Button
    if (_currentStep < 3)
      ElevatedButton.icon(
        onPressed: _nextStep,
        style: razprimaryButtonStyle.copyWith(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.02,
            ),
          ),
        ),
        icon: const Icon(Icons.arrow_forward, size: 24.0),
        label: const Text(
          'NEXT',
          style: buttonTextStyle,
        ),
      )

  ],
)

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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

  // Step Label Widget (Inside the white container)
Widget _tabLabel(String title, {bool isActive = false}) {
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

  // Account Information Step
  Widget _accountInformationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDiningTypeDropdown(),
        _buildTextField('Business Name', 'Enter your business name', fullNameController),
        _buildTextField("Email", "example@gmail.com", emailController),
        _buildPhoneField(phoneController),
        _buildPasswordField(context, "Password", _obscurePassword, () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },passwordController),
        _buildPasswordField(context, "Confirm Password", _obscureConfirmPassword, () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },confirmPasswordController),
        Row(
          children: [
            Checkbox(
              value: _agreeToTerms,
              activeColor: darkOrangeColor,
              onChanged: (bool? value) {
                setState(() {
                  _agreeToTerms = value ?? false;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _agreeToTerms = !_agreeToTerms;
                });
              },
              child: const Text(
                'I agree to the terms of service',
                style: blackBodyTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Dining Type Dropdown
  Widget _buildDiningTypeDropdown() {
    String? selectedDiningType;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dining Type',
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: blackColor,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedDiningType,
            onChanged: (String? newValue) {
              setState(() {
                selectedDiningType = newValue;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrayColor,
              hintText: 'Select dining type',
              hintStyle: const TextStyle(
                fontFamily: 'Sen',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: darkGrayColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            items: <String>['Coffee Shop', 'Fast Food', 'Restaurant', 'Cafe', 'Bar']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

Widget _buildTextField(String label, String hintText, TextEditingController controller, {Widget? suffixIcon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: blackColor, // Ensure this color is defined elsewhere
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor, // Ensure this color is defined elsewhere
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: darkGrayColor, // Ensure this color is defined elsewhere
            ),
            suffixIcon: suffixIcon, // Optional icon for the field
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none, // Removes the default border side
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ],
    ),
  );
}

Widget _businessInformationStep() {
  // Categories options
  final categories = [
    'All', 'Turkish', 'Chinese', 'Italian', 'Japanese',
    'Syrian', 'Indian', 'Mexican', 'Other'
  ];

  // Dietary options
  final dietaryOptions = ['Any', 'Vegetarian', 'Vegan', 'Gluten-Free', 'Other'];

  // Special features 
  final specialFeatures = ['Family friendly', 'Takeout', 'Pet friendly', 'Accessible', 'Reservation', 'Delivery Available', 'Outdoor Seating', 'Other'];

  // Pricing options
  final pricing = ['\$', '\$\$', '\$\$\$', '\$\$\$\$'];

  // State for selections
  final List<String> selectedCategories = [];
  final List<String> selectedDietaryOptions = [];
  final List<String> selectedSpecialFeatures = [];

  final List<String> selectedPricing = [];
  String otherCategory = '';
  String otherDietary = '';
  String otherSpecialFeature = '';

  // Fetch screen dimensions for responsive design
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return StatefulBuilder(
    builder: (context, setState) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories Section
        _buildSectionHeader(
          'Categories',
          onClear: () {
            setState(() {
              selectedCategories.clear();
              otherCategory = '';
            });
          },
        ),
        SizedBox(height: screenHeight * 0.02),  // Adjusted spacing based on screen height
        Wrap(
          spacing: screenWidth * 0.02,  // Adjusted spacing between items based on screen width
          runSpacing: screenHeight * 0.02,  // Adjusted vertical spacing based on screen height
          children: categories.map((category) {
            final isOther = category == 'Other';
            return isOther && selectedCategories.contains('Other')
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your preference',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03, vertical: screenHeight * 0.015),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => otherCategory = value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: darkGrayColor),
                        onPressed: () {
                          setState(() {
                            selectedCategories.remove('Other');
                            otherCategory = '';
                          });
                        },
                      )
                    ],
                  )
                : ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.04, // Adjusted font size based on screen width
                        color: selectedCategories.contains(category)
                            ? whiteColor
                            : darkGrayColor,
                      ),
                    ),
                    selected: selectedCategories.contains(category),
                    selectedColor: darkOrangeColor,
                    backgroundColor: lightGrayColor,
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                  );
          }).toList(),
        ),

        SizedBox(height: screenHeight * 0.03),  // Adjusted spacing

        // Dietary Section
        _buildSectionHeader(
          'Dietary Preferences',
          onClear: () {
            setState(() {
              selectedDietaryOptions.clear();
              otherDietary = '';
            });
          },
        ),
        SizedBox(height: screenHeight * 0.02),  // Adjusted spacing
        Wrap(
          spacing: screenWidth * 0.02,  // Adjusted spacing
          runSpacing: screenHeight * 0.02,  // Adjusted vertical spacing
          children: dietaryOptions.map((option) {
            final isOther = option == 'Other';
            return isOther && selectedDietaryOptions.contains('Other')
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your preference',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03, vertical: screenHeight * 0.015),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => otherDietary = value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: darkGrayColor),
                        onPressed: () {
                          setState(() {
                            selectedDietaryOptions.remove('Other');
                            otherDietary = '';
                          });
                        },
                      )
                    ],
                  )
                : ChoiceChip(
                    label: Text(
                      option,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.04,  // Adjusted font size
                        color: selectedDietaryOptions.contains(option)
                            ? whiteColor
                            : darkGrayColor,
                      ),
                    ),
                    selected: selectedDietaryOptions.contains(option),
                    selectedColor: darkOrangeColor,
                    backgroundColor: lightGrayColor,
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDietaryOptions.add(option);
                        } else {
                          selectedDietaryOptions.remove(option);
                        }
                      });
                    },
                  );
          }).toList(),
        ),

        SizedBox(height: screenHeight * 0.03),  // Adjusted spacing

        // Special Features Section 
        _buildSectionHeader(
          'Special Features',
          onClear: () {
            setState(() {
              selectedSpecialFeatures.clear();
              otherSpecialFeature = '';
            });
          },
        ),
        SizedBox(height: screenHeight * 0.02),  // Adjusted spacing
        Wrap(
          spacing: screenWidth * 0.02,  // Adjusted spacing
          runSpacing: screenHeight * 0.02,  // Adjusted vertical spacing
          children: specialFeatures.map((option) {
            final isOther = option == 'Other';
            return isOther && selectedSpecialFeatures.contains('Other')
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your preference',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03, vertical: screenHeight * 0.015),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => otherSpecialFeature = value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: darkGrayColor),
                        onPressed: () {
                          setState(() {
                            selectedSpecialFeatures.remove('Other');
                            otherSpecialFeature = '';
                          });
                        },
                      )
                    ],
                  )
                : ChoiceChip(
                    label: Text(
                      option,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.04,  // Adjusted font size
                        color: selectedSpecialFeatures.contains(option)
                            ? whiteColor
                            : darkGrayColor,
                      ),
                    ),
                    selected: selectedSpecialFeatures.contains(option),
                    selectedColor: darkOrangeColor,
                    backgroundColor: lightGrayColor,
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedSpecialFeatures.add(option);
                        } else {
                          selectedSpecialFeatures.remove(option);
                        }
                      });
                    },
                  );
          }).toList(),
        ),

        SizedBox(height: screenHeight * 0.03),  // Adjusted spacing

        // Pricing Section
        _buildSectionHeader(
          'Pricing',
          onClear: () {
            setState(() => selectedPricing.clear());
          },
        ),
        SizedBox(height: screenHeight * 0.02),  // Adjusted spacing
        Wrap(
          spacing: screenWidth * 0.02,  // Adjusted spacing
          runSpacing: screenHeight * 0.02,  // Adjusted vertical spacing
          children: pricing.map((price) {
            return ChoiceChip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              label: Text(
                price,
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.04,  // Adjusted font size
                  color: selectedPricing.contains(price)
                      ? whiteColor
                      : darkGrayColor,
                ),
              ),
              selected: selectedPricing.contains(price),
              selectedColor: darkOrangeColor,
              backgroundColor: lightGrayColor,
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedPricing.add(price);
                  } else {
                    selectedPricing.remove(price);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    ),
  );
}


Widget _buildPasswordField(BuildContext context, String label, bool obscureText, VoidCallback toggleObscure, TextEditingController controller) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.045,
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



Widget _buildSectionHeader(String title, {required VoidCallback onClear}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'Sen',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: blackColor,
        ),
      ),
      TextButton(
        onPressed: onClear,
        child: const Text(
          'Clear All',
          style: TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: darkOrangeColor,
          ),
        ),
      ),
    ],
  );
}

Widget _verificationStep(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
        child: Center(
          child: Text(
            'A code has been sent to +213 70******54',
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.045,
              color: blackColor,
            ),
            textAlign: TextAlign.center, // Ensure it's centered
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // Add logic to resend the code if needed
        },
        child: Center(
          child: Text(
            'Resend code',
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.04,
              color: darkOrangeColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
        child: TextField(
          controller: verificationCodeController, // Use controller for input

          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Enter verification code',
            labelStyle: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.045,
              color: blackColor,
            ),
            filled: true,
            fillColor: lightGrayColor,
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
      ),
      SizedBox(height: screenHeight * 0.03), // Add some space before the button

      // Verify Button
    Center(
        child: SizedBox(
          width: screenWidth * 0.8, // Set button width proportional to screen
          height: screenHeight * 0.07, // Fixed height for the button
          child: ElevatedButton(
           onPressed: () async {
                if (verificationCodeController.text == '1234') {  // Basic validation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const restoNavBar()),
                  );
                } else {
                  // Show an error message if verification fails
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Invalid Code'),
                        content: const Text('The code you entered is incorrect.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            style: razprimaryButtonStyle.copyWith(
              minimumSize: WidgetStateProperty.all(Size(screenWidth * 0.8, screenHeight * 0.07)), // Ensure responsive size
              padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: screenHeight * 0.015)), // Responsive padding
            ),
            child: Text(
              'VERIFY',
              style: TextStyle(
                fontFamily: 'Sen',
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.05,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


Widget _buildPhoneField(TextEditingController controller) {
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
          controller: controller,
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
                SizedBox(width: screenWidth * 0.02),
                Image.asset(
                  'assets/icons/algeria.png',
                  width: screenWidth * 0.04, 
                  height: screenHeight * 0.035, 
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

Widget _placeInformationStep() {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Business Location
              Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
          child: _buildTextField(
            'Business Location',
            'Enter business location',
             businessLocationController,
            suffixIcon: const Icon(Icons.location_on, color: darkGrayColor),
          ),
        ),

        // Working Days and Hours
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: Text(
            'Working Days & Hours',
            style: TextStyle(
              fontSize: screenWidth * 0.045, // Adjust font size based on screen width
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ..._workingHours.keys.map((day) {
          // Initialize the controller for each day if not already done
          if (!workingHoursControllers.containsKey(day)) {
            workingHoursControllers[day] = TextEditingController();
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Row(
              children: [
                // Day Label (Bold & Larger)
                Expanded(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,  // Adjust font size based on screen width
                      fontWeight: FontWeight.bold,
                      color: darkGrayColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),

                // Working Hours Input (With Hint)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
                    child: _buildTextField(
                      'Working Hours for $day',
                      'e.g., 9 AM - 5 PM',
                      workingHoursControllers[day]!,
                      suffixIcon: const Icon(Icons.access_time, color: darkGrayColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 16),

        // Restaurant Description
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
          child: _buildTextField(
            'Restaurant Description',
            'Write a brief description about your restaurant',
             descriptionController,
            suffixIcon: const Icon(Icons.description, color: darkGrayColor),
          ),
        ),
      ],
    );
  }


}
