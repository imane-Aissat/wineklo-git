import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/widgets/textField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/restaurateur_signup_cubit.dart';

class PlaceInformationStep extends StatefulWidget {
  final TextEditingController businessLocationController;
  final Map<String, Map<String, TextEditingController>> workingHoursControllers;
  final Map<String, dynamic> workingHours;
  final TextEditingController descriptionController;

  const PlaceInformationStep({
    Key? key,
    required this.businessLocationController,
    required this.workingHoursControllers,
    required this.workingHours,
    required this.descriptionController,
  }) : super(key: key);

  @override
  _PlaceInformationStepState createState() => _PlaceInformationStepState();
}

class _PlaceInformationStepState extends State<PlaceInformationStep> {
  final Map<String, bool> selectedDays = {};
  final Map<String, String> openingHours = {};
  final Map<String, String> closingHours = {};

  @override
  void initState() {
    super.initState();
    widget.workingHours.forEach((day, hours) {
      selectedDays[day] = false;
      openingHours[day] = '';
      closingHours[day] = '';
    });

    // Listen to changes in the text fields
    widget.businessLocationController.addListener(_updateLocation);
    widget.descriptionController.addListener(_updateDescription);
  }

  @override
  void dispose() {
    // Don't forget to remove listeners to avoid memory leaks
    widget.businessLocationController.removeListener(_updateLocation);
    widget.descriptionController.removeListener(_updateDescription);
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, String day, bool isOpening) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );
    if (time != null) {
      String timeStr = time.format(context);

      if (isOpening) {
context.read<RestaurateurSignupCubit>().updateWorkingHours(day, timeStr, closingHours[day]!);
      } else {
context.read<RestaurateurSignupCubit>().updateWorkingHours(day, timeStr, openingHours[day]!);
      }
    }
  }

  void _updateLocation() {
    context.read<RestaurateurSignupCubit>().updateRestaurantAddress(widget.businessLocationController.text);
  }

  void _updateDescription() {
    context.read<RestaurateurSignupCubit>().updateRestaurantDescription(widget.descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.05,
          ),
          child: CustomTextField(
            label: 'Business Location',
            hintText: 'Enter business location',
            controller: widget.businessLocationController,
            suffixIcon: const Icon(Icons.location_on, color: darkGrayColor),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: Text(
            'Working Days & Hours',
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...widget.workingHours.keys.map((day) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text(
                      day,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: darkGrayColor,
                      ),
                    ),
                    value: selectedDays[day],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedDays[day] = value!;
                      });
                      context.read<RestaurateurSignupCubit>().toggleWorkingDay(day);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                if (selectedDays[day] == true)
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => _selectTime(context, day, true),
                            child: Text(
                              openingHours[day] == '' ? 'Select Opening Time' : openingHours[day]!,
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextButton(
                            onPressed: () => _selectTime(context, day, false),
                            child: Text(
                              closingHours[day] == '' ? 'Select Closing Time' : closingHours[day]!,
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }),

        const SizedBox(height: 16),

        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.05,
          ),
          child: CustomTextField(
            label: 'Restaurant Description',
            hintText: 'Write a brief description about your restaurant',
            controller: widget.descriptionController,
            suffixIcon: const Icon(Icons.description, color: darkGrayColor),
          ),
        ),
      ],
    );
  }
}
