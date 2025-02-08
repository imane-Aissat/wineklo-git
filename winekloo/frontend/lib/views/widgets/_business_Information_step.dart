import 'package:flutter/material.dart';
import '/views/widgets/section_header.dart';
import '/bloc/restaurateur_signup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessInformationStep extends StatelessWidget {
  const BusinessInformationStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<RestaurateurSignupCubit, SignupState>(
      builder: (context, state) {
        final cubit = context.read<RestaurateurSignupCubit>();

        final categories = [
          'All',
          'Turkish',
          'Chinese',
          'Italian',
          'Japanese',
          'Syrian',
          'Indian',
          'Mexican',
          'Other'
        ];
        final dietaryOptions = ['Any', 'Vegetarian', 'Vegan', 'Gluten-Free', 'Other'];
        final specialFeatures = ['Family friendly', 'Takeout', 'Pet friendly', 'Accessible', 'Reservation', 'Delivery Available', 'Outdoor Seating', 'Other'];

        final pricing = ['\$', '\$\$', '\$\$\$', '\$\$\$\$'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Categories',
              onClear: cubit.clearCategories, // Clear categories via Cubit
            ),
            Wrap(
              spacing: screenWidth * 0.02,
              runSpacing: screenWidth * 0.02,
              children: categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: state.selectedCategories.contains(category),
                  onSelected: (isSelected) => cubit.toggleCategory(category),
                );
              }).toList(),
            ),
            if (state.selectedCategories.contains('Other'))
              TextField(
                onChanged: cubit.updateOtherCategory,
                decoration: const InputDecoration(labelText: 'Specify Other Category'),
              ),
            
            
            SectionHeader(
              title: 'Dietary Preferences',
              onClear: cubit.clearDietaryOptions,
            ),
            Wrap(
              spacing: screenWidth * 0.02,
              runSpacing: screenWidth * 0.02,
              children: dietaryOptions.map((option) {
                return ChoiceChip(
                  label: Text(option),
                  selected: state.selectedDietaryOptions.contains(option),
                  onSelected: (isSelected) => cubit.toggleDietaryOption(option),
                );
              }).toList(),
            ),
            if (state.selectedDietaryOptions.contains('Other'))
              TextField(
                onChanged: cubit.updateOtherDietary,
                decoration: const InputDecoration(labelText: 'Specify Other Dietary Preference'),
              ),


            SectionHeader(
              title: 'Special Features',
              onClear: cubit.clearSpecialFeatures,
            ),
            Wrap(
              spacing: screenWidth * 0.02,
              runSpacing: screenWidth * 0.02,
              children: specialFeatures.map((specialFeature) {
                return ChoiceChip(
                  label: Text(specialFeature),
                  selected: state.selectedSpecialFeatures.contains(specialFeature),
                  onSelected: (isSelected) => cubit.toggleSpecialFeature(specialFeature),
                );
              }).toList(),
            ),
            if (state.selectedSpecialFeatures.contains('Other'))
              TextField(
                onChanged: cubit.updateOtherSpecialFeature,
                decoration: const InputDecoration(labelText: 'Specify Other Special Feature'),
              ),


            SectionHeader(
              title: 'Pricing',
              onClear: cubit.clearPricing,
            ),
            Wrap(
              spacing: screenWidth * 0.02,
              runSpacing: screenWidth * 0.02,
              children: pricing.map((price) {
                return ChoiceChip(
                  label: Text(price),
                  selected: state.selectedPricing.contains(price),
                  onSelected: (isSelected) => cubit.togglePricing(price),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}