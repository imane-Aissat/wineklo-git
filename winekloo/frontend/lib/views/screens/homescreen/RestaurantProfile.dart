import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/views/screens/homescreen/RestaurantMenu.dart';
import 'package:userworkside/views/screens/homescreen/reviewsUser.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '../../../bloc/foodie_cubit.dart';
import '../../../bloc/restaurateur_cubit.dart'; 
import '../../../models/restaurateur.dart'; 
import '../../../bloc/categories_cubit.dart';
import '../../../models/categories_model.dart';
import '../../../bloc/specialfeatures_cubit.dart';
import '../../../models/specialfeatures_model.dart';

class RestaurantViewPage extends StatelessWidget {
  final int restaurateurID; 

  const RestaurantViewPage({super.key, required this.restaurateurID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurateurCubit()..loadRestaurateur(restaurateurID), 
      child: Scaffold(
        body: BlocBuilder<RestaurateurCubit, Restaurateur?>(
          builder: (context, restaurateur) {
            if (restaurateur == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final categoriesCubit = context.read<CategoriesCubit>();
            categoriesCubit.loadCategoryById(restaurateur.categories ?? 0);
           
            final specialfeatures = context.read<SpecialFeaturesCubit>();
            specialfeatures.loadSpecialFeaturesById(restaurateur.specialFeatures ?? 0);
    
            return BlocBuilder<CategoriesCubit, List<Categories>>(
  builder: (context, categories) {
    return BlocBuilder<SpecialFeaturesCubit, List<SpecialFeatures>>(
      builder: (context, specialFeatures) {
            return buildRestaurantView(
              restaurateurID: restaurateur.restaurateurID ?? 0,
              context: context,
              restaurantName: restaurateur.name ?? 'Unknown',
              description: restaurateur.description ?? 'No description available',
              imagePath: restaurateur.photo ?? 'assets/images/default.jpg',
              rating: double.tryParse(restaurateur.ratingValueAverage ?? '0') ?? 0.0,
              location: restaurateur.location ?? 'Unknown location',
              pricing: getPricingSymbol(restaurateur.pricing),
              categories: getCategoryList(categories),
              specialFeatures: getSpecialFeaturesList(specialFeatures),
              dietaryOptions: getDietaryList(restaurateur.dietaryPreferences),
           
              menuItems: [
                {'imagePath': 'assets/images/pizza.jpg', 'itemName': 'Pizza', 'price': '600'},
                {'imagePath': 'assets/images/pasta.jpg', 'itemName': 'Pasta', 'price': '1400'},
              ],
               openingHours: convertWorkingHours(restaurateur.workingHours),
        );
      },
    );
  },
);

          },
        ),
      ),
    );
  }

  Map<String, String> convertWorkingHours(Map<String, dynamic>? workingHours) {
  if (workingHours == null) return {};
  return workingHours.map((key, value) => MapEntry(key, value.toString()));
}


  String getPricingSymbol(int? pricing) {
    if (pricing == null) return '\$';
    return '\$' * pricing;
  }
  
   List<String> getCategoryList(List<Categories> categories) {
    return categories.isNotEmpty ? categories.map((c) => c.categoryName ?? 'Unknown').toList() : ['Unknown Category'];
  }



  List<String> getSpecialFeaturesList(List<SpecialFeatures> specialfeatures) {
    return specialfeatures.isNotEmpty ? specialfeatures.map((c) => c.feature ?? 'Unknown').toList() : ['Unknown specialfeatures'];
  }

  List<String> getDietaryList(int? dietaryPreferences) {
    return dietaryPreferences != null ? ['Dietary $dietaryPreferences'] : ['All'];
  }

 
}



class OpeningHoursCard extends StatelessWidget {
  final Map<String, String> openingHours;

  const OpeningHoursCard({
    super.key,
    required this.openingHours,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenWidth * 0.02, 
      ),
      padding: EdgeInsets.all(screenWidth * 0.04), 
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Opening Hours',
            style: headlineStyle.copyWith(
              fontSize: screenWidth * 0.05, 
            ),
          ),
          const SizedBox(height: 12.0),
          ...openingHours.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.01, 
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      entry.key,
                      style: bodyTextStyle.copyWith(
                        fontSize: screenWidth * 0.04, 
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      entry.value,
                      style: placeholderTextStyle.copyWith(
                        fontSize: screenWidth * 0.04,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}




class CategoryChip extends StatelessWidget {
  final String label; 

  const CategoryChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.02,
      ),
      decoration: BoxDecoration(
        color: textLightGrayColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: lightGrayColor,
            offset: Offset(2, 2),
            blurRadius: 4.0,
          ),
          BoxShadow(
            color: whiteColor,
            offset: Offset(-2, -2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: FittedBox(
        child: Text(
          label,
          style: placeholderTextStyle.copyWith(
            color: darkGrayColor,
            fontSize: screenWidth * 0.035,
          ),
        ),
      ),
    );
  }
}









class ReviewCard extends StatelessWidget {
  final String rating;
  final int totalReviews; 
  final int restaurateurID;

  const ReviewCard({
    super.key,
    required this.rating,
    required this.totalReviews,
    required this.restaurateurID,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(screenWidth * 0.02),
      decoration: cardDecoration,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviews',
                  style: bodyTextStyle.copyWith(
                    color: darkOrangeColor,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserReviewPage(restaurateurID: restaurateurID),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'See All',
                        style: bodyTextStyle.copyWith(
                          color: darkOrangeColor,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: darkOrangeColor,
                        size: screenWidth * 0.04,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: darkOrangeColor,
                  size: screenWidth * 0.05,
                ),
                const SizedBox(width: 4.0),
                Text(
                  rating, 
                  style: bodyTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Total $totalReviews reviews',
                  style: placeholderTextStyle.copyWith(
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}








class MenuCard extends StatelessWidget {
  final String imagePath;
  final String itemName;
  final String price;

  const MenuCard({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.4, 
      height: screenWidth * 0.5, 
      margin: EdgeInsets.all(screenWidth * 0.02), 
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(screenWidth * 0.02),
            ), 
            child: Image.asset(
              imagePath,
              height: screenWidth * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 8.0),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Text(
              itemName,
              style: bodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04, 
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Starting',
                  style: placeholderTextStyle.copyWith(
                    fontSize: screenWidth * 0.035, 
                  ),
                ),
                Text(
                  '$price DZD',
                  style: bodyTextStyle.copyWith(
                    color: darkOrangeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04, 
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



Widget buildRestaurantView({
  required int restaurateurID,
  required BuildContext context,
  required String restaurantName,
  required String description,
  required String imagePath,
  required double rating,
  required String location,
  required String pricing,
  required List<String> categories,
  required List<String> dietaryOptions,
  required List<String> specialFeatures,
  required List<Map<String, String>> menuItems,
  required Map<String, String> openingHours,
}) {
  return Scaffold(
    backgroundColor: whiteColor,
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: blackColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Restaurant View',
          style: headlineStyle.copyWith(fontFamily: 'Sen'),
        ),
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: horizontalPadding.copyWith(top: 16.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.asset(
                  imagePath,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: horizontalPadding,
            child: Text(
              restaurantName,
              style: headlineStyle.copyWith(fontSize: 24.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: horizontalPadding,
            child: Text(
              description,
              style: bodyTextStyle.copyWith(fontSize: 14.0, color: darkGrayColor),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: horizontalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: darkOrangeColor, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: headlineStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: darkOrangeColor, size: 20),
                    const SizedBox(width: 4),
                    Text(location, style: bodyTextStyle.copyWith(color: darkGrayColor)),
                  ],
                ),
                Row(
                  children: [
                    Text(pricing, style: bodyTextStyle.copyWith(color: darkOrangeColor)),
                    const SizedBox(width: 4),
                    Text('Pricing', style: bodyTextStyle.copyWith(color: darkGrayColor)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<FoodieCubit>().addToFavorites(restaurateurID);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Successfully added to favorites!", style: orangeBodyTextStyle),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.white,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightOrangeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: const Text("Add to favorites", style: buttonTextStyle),
            ),
          ),
          const SizedBox(height: 16.0),
          _buildChipsSection('Category', categories),
          const SizedBox(height: 16.0),
          _buildChipsSection('DIETARY', dietaryOptions),
          const SizedBox(height: 16.0),
          _buildChipsSection('SPECIAL FEATURES', specialFeatures),
          const SizedBox(height: 16.0),
          Padding(
            padding: horizontalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Menu', style: subheadingStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
                GestureDetector(
                  child: Row(
                    children: [
                      Text('See All', style: bodyTextStyle.copyWith(color: darkOrangeColor)),
                      const Icon(Icons.arrow_forward, color: darkOrangeColor, size: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton.icon(
              icon: const  Icon(Icons.arrow_right, color: Colors.white),
              label: const Text(
                'Check Our Menu!',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                backgroundColor: lightOrangeColor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                shadowColor: darkOrangeColor,
                elevation: 4.0,
              ), onPressed: () {
                Navigator.push(
                  context , MaterialPageRoute(builder: (context)=> MenuRestaurant(restaurateurID: restaurateurID)));
              },
            ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: horizontalPadding,
            child: ReviewCard(rating: rating.toString(), totalReviews: 20, restaurateurID: restaurateurID),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OpeningHoursCard(openingHours: openingHours),
          ),
        ],
      ),
    ),
  );
}



Widget _buildChipsSection(String title, List<String> chips) {
  return Padding(
    padding: horizontalPadding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: subheadingStyle.copyWith(color: Colors.black)),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: chips.map((label) => CategoryChip(label: label)).toList(),
        ),
      ],
    ),
  );
}



