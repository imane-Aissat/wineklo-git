import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../bloc/reviews_cubit.dart';
import '../../../models/reviews_model.dart';
import '/views/screens/food_managment/resto_profile.dart';
import '/views/screens/food_managment/edit_resto_profile.dart';
import '/views/screens/food_managment/my_food_list.dart';
import '/views/screens/food_managment/add_new_item.dart';
import '/views/screens/food_managment/my_reviews.dart'; 
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';

class RestaurantDashboardPage extends StatelessWidget {
  //final int restaurateurID;
  const RestaurantDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsCubit()..loadReviewsRestaurant(),
      child: Scaffold(
        backgroundColor: whiteColor, 
        appBar: AppBar(
          title: const Text('Restaurant Home', style: headlineStyle),
          centerTitle: true,
          backgroundColor: whiteColor,
        ),
        body: SingleChildScrollView(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: subheadingStyle.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 16.0),

              _buildQuickAccessSection(context),

              const SizedBox(height: 24.0),

              _buildReviewStatisticsSection(),

              const SizedBox(height: 24.0),

              _buildReviewCommentsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessSection(BuildContext context) {
    return Container(
      decoration: cardDecoration,
      padding: defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Access', style: subheadingStyle),
          const SizedBox(height: 16.0),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildQuickAccessButton(context, 'Profile', Icons.person, darkOrangeColor, const RestaurantViewPage()),
              _buildQuickAccessButton(context, 'Edit Profile', Icons.edit, lightOrangeColor, const RestaurantEditPage()),
              _buildQuickAccessButton(context, 'Food List', Icons.fastfood, darkBlueColor, const FoodMenuPage()),
              _buildQuickAccessButton(context, 'Add New Item', Icons.add, darkGrayColor, const AddNewItemsPage()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStatisticsSection() {
    return Container(
      decoration: cardDecoration,
      padding: defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Review Statistics', style: subheadingStyle),
          const SizedBox(height: 8.0),
          BlocBuilder<ReviewsCubit, List<Review>>(
            builder: (context, reviews) {
              if (reviews.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final distribution = context.read<ReviewsCubit>().calculateRatingDistribution();
              final averageRating = reviews.map((e) => e.rating ?? 0).reduce((a, b) => a + b) / reviews.length;

              return Column(
                children: [
                  Text('Average rating: ${averageRating.toStringAsFixed(1)}/5', style: bodyTextStyle),
                  const SizedBox(height: 16.0),
                 SizedBox(
  height: 200,
  child: PieChart(
    PieChartData(
      sections: distribution.entries.map((entry) {
        final colorsMap = {
          1: lightGrayColor,
          2: Colors.blue,
          3: Colors.green,
          4: lightOrangeColor,
          5: darkOrangeColor
        };

        final color = colorsMap[entry.key] ?? Colors.black; // Ensure no null color

        return PieChartSectionData(
          color: color,
          value: entry.value > 0 ? entry.value : 0.1, // Ensure it's not zero
          title: entry.value > 0 ? '${entry.value.toStringAsFixed(1)}%' : '',
          titleStyle: buttonTextStyle,
        );
      }).toList(),
    ),
  ),
),

                ],
              );
            },
          ),
        ],
      ),
    );
  }

  
  Widget _buildReviewCommentsSection(BuildContext context) {
    return BlocBuilder<ReviewsCubit, List<Review>>(
      builder: (context, reviews) {
        if (reviews.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Review Comments', style: subheadingStyle),
            const SizedBox(height: 16.0),
            ...reviews.take(3).map((review) => ListTile(
                  title:  Text(
                    '${review.foodieName} - ${(review.date != null ? DateTime.parse(review.date!).toLocal().toString().split(' ')[0] : '')}',
                    style: subheadingStyle,
                  ),
                  subtitle: Text(review.comment ?? 'No comment'),
                )),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage())),
                child: const Text('See All', style: TextStyle(color: darkOrangeColor, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      },
    );
  }

  
 Widget _buildQuickAccessButton(BuildContext context, String label, IconData icon, Color color, Widget targetPage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => targetPage, 
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32.0),
          const SizedBox(height: 8.0),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
}
