// lib/widgets/widgets.dart
import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';

List<bool> _selectedPriceRange = [false, false, false, false];
List<String> selectedCategories = [];
List<String> selectedDietary = [];

// Step Label Widget
Widget tabLabel(String title, {bool isActive = false}) {
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
      const SizedBox(height: 4),
      Container(
        height: 2,
        width: 60,
        color: isActive ? darkOrangeColor : Colors.transparent,
      ),
    ],
  );
}

// Account Information Step Widget
Widget accountInformationStep(Function setState, bool obscurePassword, bool obscureConfirmPassword) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTextField("Full Name", "Enter your full name"),
      buildTextField("Email", "example@gmail.com"),
      buildPhoneField(),
      buildPasswordField("Password", obscurePassword, () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      }),
      buildPasswordField("Confirm Password", obscureConfirmPassword, () {
        setState(() {
          obscureConfirmPassword = !obscureConfirmPassword;
        });
      }),
      Row(
        children: [
          Checkbox(
            value: false, // Change this to your actual state
            activeColor: darkOrangeColor,
            onChanged: (bool? value) {
              // Handle change
            },
          ),
          GestureDetector(
            onTap: () {
              // Handle terms of service toggle
            },
            child: const Text('I agree to the terms of service', style: blackBodyTextStyle),
          ),
        ],
      ),
    ],
  );
}

// Personal Information Step Widget
Widget personalInformationStep() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTextField("Date Of Birth", "DD/MM/YYYY", suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey)),
      buildGenderDropdown(),
      buildWilayaDropdown(),
    ],
  );
}

// Gender Dropdown Widget
Widget buildGenderDropdown() {
  String? selectedGender;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender', style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 18, color: blackColor)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedGender,
          onChanged: (String? newValue) {
            // Handle gender change
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor,
            hintText: 'Select your gender',
            hintStyle: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 14, color: darkGrayColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          items: <String>['Male', 'Female', 'Other'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 14, color: blackColor)));
          }).toList(),
        ),
      ],
    ),
  );
}

// Wilaya Dropdown Widget
Widget buildWilayaDropdown() {
  String? selectedWilaya;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Wilaya', style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 18, color: blackColor)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedWilaya,
          onChanged: (String? newValue) {
            // Handle wilaya change
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor,
            hintText: 'Select your Wilaya',
            hintStyle: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 14, color: darkGrayColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          items: <String>['Algiers', 'Oran', 'Constantine', 'Blida'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 14, color: blackColor)));
          }).toList(),
        ),
      ],
    ),
  );
}

// Phone Number Field Widget
Widget buildPhoneField() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Phone Number', style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 18, color: blackColor)),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 100.0,
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              decoration: BoxDecoration(color: lightGrayColor, borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                children: [
                  Image.asset('icons/algeria.png', width: 25, height: 25),
                  const SizedBox(width: 8),
                  const Text('+213', style: TextStyle(color: darkGrayColor, fontSize: 16.0)),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGrayColor,
                  hintText: 'Enter your phone number',
                  hintStyle: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 14, color: darkGrayColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// TextField Helper
Widget buildTextField(String label, String hintText, {Widget? suffixIcon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 18, color: blackColor)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor,
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 14, color: darkGrayColor),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ],
    ),
  );
}

// Password Field Helper
Widget buildPasswordField(String label, bool obscureText, VoidCallback toggleObscure) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 18, color: blackColor)),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGrayColor,
            hintText: 'Enter your $label',
            hintStyle: const TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 14, color: darkGrayColor),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
              onPressed: toggleObscure,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title, {VoidCallback? onClear}) {
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
        child: const Text('CLEAR ALL', style: TextStyle(color: Colors.red)),
      ),
    ],
  );
}

Widget _buildPriceRange(List<bool> selectedPriceRange, Function setState) {
  final List<String> priceLabels = ['\$', '\$\$', '\$\$\$', '\$\$\$\$'];

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(priceLabels.length, (index) {
      return ChoiceChip(
        label: Text(
          priceLabels[index],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: selectedPriceRange[index] ? Colors.white : darkGrayColor,
          ),
        ),
        shape: const CircleBorder(),
        selected: selectedPriceRange[index],
        onSelected: (bool isSelected) {
          setState(() {
            selectedPriceRange = [false, false, false, false];
            selectedPriceRange[index] = isSelected;
          });
        },
        selectedColor: Colors.orange,
        backgroundColor: Colors.grey.shade200,
        padding: const EdgeInsets.all(16), // Adjust for a larger circular design
      );
    }),
  );
}

Widget _buildCategoryTags(List<String> tags, List<bool> selectedStates, Function setState) {
  return Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: List.generate(tags.length, (index) {
      return ChoiceChip(
        label: Text(
          tags[index],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selectedStates[index] ? Colors.white : darkGrayColor,
          ),
        ),
        selected: selectedStates[index],
        onSelected: (bool isSelected) {
          setState(() {
            selectedStates[index] = isSelected;
          });
        },
        selectedColor: Colors.orange,
        backgroundColor: Colors.grey.shade300,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
    }),
  );
}


