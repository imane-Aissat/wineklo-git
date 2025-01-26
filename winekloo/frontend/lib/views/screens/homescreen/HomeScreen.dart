
import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/views/screens/homescreen/restau%20profile.dart';
import '../../../bloc/foodie_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/models/foodie_model.dart';

class homeScreen extends StatefulWidget {
  const homeScreen ({super.key});
  @override
  State<homeScreen> createState() => _homeScreenState();
}


class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    super.initState();
    final foodieCubit = context.read<FoodieCubit>();
    foodieCubit.loadProfile(1);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Padding(padding: EdgeInsets.only(top: screenHeight * 0.05)),
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 0),
              child: const Text("Good morning,", style: grayBodyTextStyle),
            ),
            BlocBuilder<FoodieCubit, Foodie?>(
              builder: (context, foodieProfile) {
                if (foodieProfile == null) {
                  return const CircularProgressIndicator();
                }
                return Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    foodieProfile.fullname ?? "Unnamed User",
                    style: blackHeadlineStyle,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
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
            const SizedBox(height: 5.0),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Categories", style: blackHeadlineStyle),
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                cuisineCard("Italian", "assets/images/italianfood.jpg"),
                cuisineCard("Indian", "assets/images/indianfood.jpg"),
                cuisineCard("Mexican", "assets/images/mexicanfood.jpg"),
                cuisineCard("Traditional", "assets/images/traditional.jpg"),
                cuisineCard("Asian", "assets/images/asian.jpg"),
                cuisineCard("Sea food", "assets/images/seafood.jpg"),
                cuisineCard("Healthy", "assets/images/healthyfood.jpg"),
                cuisineCard("Fast food", "assets/images/fastfood.jpg"),
                cuisineCard("Vegetarian", "assets/images/vegetarian.jpg"),
              ]),
            ),
            const SizedBox(height: 25.0),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Popular", style: blackHeadlineStyle),
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                restaurantCard("assets/images/hichamcookpizza.jpg", "Hicham cook pizza", "Cheraga", "3.5", context),
                restaurantCard("assets/images/hichamcookgrill.jpg", "Hicham cook grill", "Ouled fayet", "3.8", context),
                restaurantCard("assets/images/citeasiatique.jpg", "la cité Asiatique", "Val d'Hydra", "4.1", context),
              ]),
            ),
            const SizedBox(height: 25.0),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Asian", style: blackHeadlineStyle),
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                restaurantCard("assets/images/citeasiatique.jpg", "la cité Asiatique", "Val d'Hydra", "4.1", context),
                restaurantCard("assets/images/sushiball.png", "sushi ball", "Dely brahim", "3.8", context),
                restaurantCard("assets/images/citeasiatique.jpg", "DreamRoll", "Ain Allah", "3.5", context),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget cuisineCard(String cuisineName, String picture) {
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        border: Border.all(color: darkGrayColor),
        borderRadius: BorderRadius.circular(40.0),
        color: whiteColor,
        boxShadow: const [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            blurRadius: 2,
            color: darkGrayColor,
          ),
        ],
      ),
      width: 160,
      height: 55,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(picture),
              ),
            ),
            const SizedBox(width: 12),
            Text(cuisineName, style: blackBodyTextStyle),
          ],
        ),
      ),
    );
  }
}


Widget restaurantCard(String picture, String restauName, String location, String rating, context) {

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const RestaurantViewPage())
      );
    },
    child: Container(
      padding: const EdgeInsets.only(left: 10),
      height: 215,
      width: 230,
      child: Material(
        color: whiteColor,
        shadowColor: darkGrayColor,
        borderRadius: BorderRadius.circular(10),
        elevation: 4.0,
        child: Column(
          children: [
            Container(
              height: 150,
              width: 230,
              decoration: BoxDecoration(
                border: Border.all(
                  color: lightGrayColor,
                  width: 1,         
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.5), 
                child: Image.asset(
                  picture,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(restauName, style: blackBodyTextStyle),
                        Text(location, style: grayBodyTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        Text(rating),
                        const Icon(Icons.star_rate, color: darkOrangeColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}