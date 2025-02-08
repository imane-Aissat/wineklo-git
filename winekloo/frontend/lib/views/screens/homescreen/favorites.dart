import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/bloc/restaurateurs_cubit.dart';
import 'package:userworkside/themes/styles/colors.dart';
import 'package:userworkside/themes/styles/styles.dart';
import '/views/screens/homescreen/Restaurantprofile.dart';
import '/models/restaurateur.dart';

class FavoritesPage extends StatefulWidget {
  final int foodieID; 

  const FavoritesPage({super.key, required this.foodieID});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurateursCubit>().loadAllFavorites(widget.foodieID);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorites',
          style: blackSubHeadlineStyle.copyWith(fontSize: screenWidth * 0.05),
        ),
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            Expanded(
              child: BlocBuilder<RestaurateursCubit, List<Restaurateur>?>(
                builder: (context, restaurateurs) {
                  if (restaurateurs == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (restaurateurs.isEmpty) {
                    return const Center(child: Text("No favorite restaurants yet."));
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 600 ? 3 : 2,
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenHeight * 0.03,
                      childAspectRatio: screenWidth > 600 ? 0.8 : 0.75,
                    ),
                    itemCount: restaurateurs.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurateurs[index];
                      return restaurantCardFav(
                        restaurant.photo ?? "assets/images/defaultprofilepic.jpg",
                        restaurant.name ?? "Unnamed restau",
                        restaurant.location ?? "Unnamed Location",
                        restaurant.ratingValueAverage.toString(),
                        context,
                        restaurant.restaurateurID ?? 0,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget restaurantCardFav(
    String picture, String restauName, String location, String rating, BuildContext context, int restauID) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RestaurantViewPage(restaurateurID: restauID)),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
      elevation: 3,
      child: Column(
        children: [
          // Image section with proper height and rounded corners
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.03)),
              child: Image.network(
                picture,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(picture, width: double.infinity, fit: BoxFit.cover);
                },
              ),
            ),
          ),
          // Content section
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restauName,
                  style: blackBodyTextStyle.copyWith(fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  location,
                  style: grayBodyTextStyle.copyWith(fontSize: screenHeight * 0.018, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
                    Icon(Icons.star_rate, color: Colors.orange, size: screenWidth * 0.04),
                    Text(
                      rating,
                      style: blackHeadlineStyle.copyWith(fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
