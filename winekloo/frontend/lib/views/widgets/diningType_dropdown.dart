import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';

class DiningTypeDropdown extends StatelessWidget {
  final String? selectedDiningType;
  final ValueChanged<String?> onChanged;

  const DiningTypeDropdown({
    Key? key,
    required this.selectedDiningType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrayColor,
              hintText: 'Select your dining type',
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
}
