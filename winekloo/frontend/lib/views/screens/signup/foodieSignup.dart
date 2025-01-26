import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/usernavbar.dart';



class FoodieSignupPage extends StatefulWidget {
  const FoodieSignupPage({super.key});

  @override
  _FoodieSignupPageState createState() => _FoodieSignupPageState();
}

class _FoodieSignupPageState extends State<FoodieSignupPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  String? selectedGender;
  String? selectedWilaya;
    final TextEditingController verificationCodeController = TextEditingController();
      final TextEditingController otherCategoryController = TextEditingController();
  final TextEditingController otherDietaryController = TextEditingController();





  int _currentStep = 0;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;


  final List<String> _steps = [
    "Account\nInformation",
    "Personal\nInformation",
    "Cuisine\nPreferences",
    "Verification\nStep"
  ];

void _nextStep() {
  if (_validateCurrentStep()) {
    setState(() {
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
      }
    });
  }
}

bool _validateCurrentStep() {
  switch (_currentStep) {
    case 0:
      return emailController.text.isNotEmpty &&
             passwordController.text.isNotEmpty;
    default:
      return true;
  }
}


  void _previousStep() {
     if (_validateCurrentStep()) {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }
  }
// Helper to create section headers with a "Clear All" option
Widget _buildSectionHeader(BuildContext context, String title, VoidCallback onClear) {
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
                padding: EdgeInsets.all(screenWidth * 0.08),
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
                            if (_currentStep == 1) _personalInformationStep(),
                            if (_currentStep == 2) _cuisinePreferencesStep(context),
                            if (_currentStep == 3) _verificationStep(context),
                            const SizedBox(height: 20),

                            // Navigation Buttons
                      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Back Button
    if (_currentStep < 3)
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

                          // SizedBox(height: screenHeight * 0.02),
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
        _buildTextField("Full Name", "Enter your full name", fullNameController),
        _buildTextField("Email", "example@gmail.com", emailController),
        _buildPhoneField(phoneController),
        _buildPasswordField(context, "Password", _obscurePassword, () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        }, passwordController),
        _buildPasswordField(context,"Confirm Password", _obscureConfirmPassword, () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        } ,confirmPasswordController),
        
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

// Personal Information Step
Widget _personalInformationStep() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTextField("Date Of Birth", "DD/MM/YYYY",
                   dateOfBirthController,

          suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey)),

      _buildGenderDropdown(),
      _buildWilayaDropdown(),
    ],
  );
}

// Gender Dropdown
Widget _buildGenderDropdown() {
  String? selectedGender;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedGender,
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor,
            hintText: 'Select your gender',
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
          items: <String>['Male', 'Female', 'Other']
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

// Wilaya Dropdown
Widget _buildWilayaDropdown() {
  String? selectedWilaya;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wilaya',
          style: TextStyle(
            fontFamily: 'Sen',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedWilaya,
          onChanged: (String? newValue) {
            setState(() {
              selectedWilaya = newValue;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor,
            hintText: 'Select your Wilaya',
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
          items: <String>['Algiers', 'Oran', 'Constantine', 'Blida']  // Add your Wilaya options here
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

 Widget _cuisinePreferencesStep(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Categories options
  final categories = [
    'All', 'Turkish', 'Chinese', 'Italian', 'Japanese',
    'Syrian', 'Indian', 'Mexican', 'Other'
  ];

  // Dietary options
  final dietaryOptions = ['Any', 'Vegetarian', 'Vegan', 'Gluten-Free', 'Other'];

  // Pricing options
  final pricing = ['\$', '\$\$', '\$\$\$', '\$\$\$\$'];

  // State for selections
  final List<String> selectedCategories = [];
  final List<String> selectedDietaryOptions = [];
  final List<String> selectedPricing = [];
  String otherCategory = '';
  String otherDietary = '';

  return StatefulBuilder(
    builder: (context, setState) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        _buildSectionHeader(
          context,
          'Categories',
          () {
            setState(() {
              selectedCategories.clear();
              otherCategory = '';
            });
          },
        ),
        SizedBox(height: screenWidth * 0.025),
        Wrap(
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
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
                                horizontal: screenWidth * 0.03,
                                vertical: screenWidth * 0.02),
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
                        icon: const Icon(Icons.close, color: darkBlueColor),
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
                        fontSize: screenWidth * 0.035,
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

        SizedBox(height: screenWidth * 0.05),

        // Dietary Section
        _buildSectionHeader(
          context,
          'Dietary Preferences',
          () {
            setState(() {
              selectedDietaryOptions.clear();
              otherDietary = '';
            });
          },
        ),
        SizedBox(height: screenWidth * 0.025),
        Wrap(
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
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
                                horizontal: screenWidth * 0.03,
                                vertical: screenWidth * 0.02),
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
                        icon: const Icon(Icons.close, color: darkBlueColor),
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
                        fontSize: screenWidth * 0.035,
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

        SizedBox(height: screenWidth * 0.05),

        // Pricing Section
          _buildSectionHeader(
            context,
            'Pricing',
            () {
              setState(() {
                selectedPricing.clear();
              });
            },
          ),

        SizedBox(height: screenWidth * 0.025),
        Wrap(
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
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
                  fontSize: screenWidth * 0.035,
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
                    MaterialPageRoute(builder: (context) => const UserNavBar()),
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
}
