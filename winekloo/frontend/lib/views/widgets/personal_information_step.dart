import 'package:flutter/material.dart';
import '/views/widgets/gender_dropdown.dart';
import '/views/widgets/wilaya_dropdown.dart';
import '/views/widgets/textField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/foodie_signup_cubit.dart';

class PersonalInformationStep extends StatelessWidget {
  final TextEditingController dateOfBirthController;

  const PersonalInformationStep({
    required this.dateOfBirthController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodieSignupCubit, SignupState>(
      builder: (context, state) {
        final cubit = context.read<FoodieSignupCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: "Date Of Birth",
              hintText: "DD/MM/YYYY",
              controller: dateOfBirthController,
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
            ),
            GenderDropdown(
              selectedGender: state.selectedGender,
              onChanged: (value) {
                cubit.updateGender(value);
              },
            ),
            WilayaDropdown(
              selectedWilayaId: state.selectedWilaya,
              onChanged: (value) {
                cubit.updateWilaya(value.toString());
              },
            ),
          ],
        );
      },
    );
  }
}
