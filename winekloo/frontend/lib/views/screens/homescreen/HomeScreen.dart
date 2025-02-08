import 'package:flutter/material.dart';
import 'package:userworkside/views/screens/Homescreen/Search.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/views/screens/Homescreen/restau%20profile.dart';
import '../../../bloc/foodie_cubit.dart';
import '../../../bloc/restaurateurs_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/models/foodie_model.dart';
import 'package:userworkside/models/restaurateur.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int? _selectedCategoryId;

  final Map<int, String> categoryMap = {
    1: "Italian",
    2: "Indian",
    3: "FastFood",
    4: "Traditional",
    5: "Asian",
    6: "Seafood",
    7: "Healthy",
    8: "Mexican",
    9: "Vegetarian",
  };

  @override
  void initState() {
    super.initState();
    context.read<FoodieCubit>().loadProfile();
    context.read<RestaurateursCubit>().loadAllRestaurateurs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: Text("Good morning,", style: grayBodyTextStyle),
            ),
            BlocBuilder<FoodieCubit, Foodie?>(
              builder: (context, foodieProfile) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    foodieProfile?.fullname ?? "Unnamed User",
                    style: blackHeadlineStyle,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(initialQuery: query),
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGrayColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Lookup a place to test",
                  hintStyle: grayBodyTextStyle,
                  suffixIcon: const Icon(Icons.search, color: darkGrayColor),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Categories", style: blackHeadlineStyle),
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  cuisineCard("All", null),
                  ...categoryMap.entries.map((entry) => cuisineCard(entry.value, entry.key)),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Popular", style: blackHeadlineStyle),
            ),
            BlocBuilder<RestaurateursCubit, List<Restaurateur>?>(
              builder: (context, restaurateursList) {
                if (restaurateursList == null || restaurateursList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<Restaurateur> filteredList = _selectedCategoryId == null
                    ? restaurateursList
                    : restaurateursList.where((restau) => restau.categories == _selectedCategoryId).toList();

                if (filteredList.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Oh! Oh! We will be adding restaurants soon!!"),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final restau = filteredList[index];
                      return restaurantCard(
                        restau.photo ?? "no photo",
                        restau.name ?? "no name",
                        restau.location ?? "no location",
                        restau.ratingValueAverage.toString(),
                        context,
                        restau.restaurateurID ?? 0,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cuisineCard(String cuisineName, int? categoryId) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryId = categoryId;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8, top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: _selectedCategoryId == categoryId ? darkOrangeColor : darkGrayColor),
          borderRadius: BorderRadius.circular(40.0),
          color: whiteColor,
        ),
        child: Text(cuisineName, style: blackBodyTextStyle),
      ),
    );
  }

  Widget restaurantCard(String picture, String restauName, String location, String rating, context, int restauID) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantViewPage(restaurateurID: restauID),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(picture, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restauName, style: blackBodyTextStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text(location, style: grayBodyTextStyle),
                  Row(
                    children: [
                      Icon(Icons.star_rate, color: darkOrangeColor, size: 16),
                      Text(rating),
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
}
