import 'package:flutter/material.dart';
import 'package:userworkside/themes/styles/colors.dart';
import 'package:userworkside/themes/styles/styles.dart';
import '/views/screens/homescreen/restau%20profile.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favorites', style: blackSubHeadlineStyle.copyWith(fontSize: screenWidth * 0.05,)),
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            /*Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: screenWidth * 0.08,
                    ),
                  ),
                  Text(
                    "Favorites",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                ],
              ),
            ), */
            SizedBox(height: screenHeight * 0.03),

            
            Expanded(
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: screenWidth > 600 ? 3 : 2,
      crossAxisSpacing: screenWidth * 0.04,
      mainAxisSpacing: screenHeight * 0.03,
      childAspectRatio: screenWidth > 600 ? 0.8 : 0.75,
    ),
    itemCount: 3,
    itemBuilder: (context, index) {
      final restaurants = [
        {
          "image": "assets/images/hichamcookpizza.jpg",
          "name": "Hicham Cook Pizza",
          "location": "Cheraga",
          "rating": "3.5"
        },
        {
          "image": "assets/images/hichamcookgrill.jpg",
          "name": "Hicham Cook Grill",
          "location": "Ouled Fayet",
          "rating": "3.8"
        },
        {
          "image": "assets/images/citeasiatique.jpg",
          "name": "La Cité Asiatique",
          "location": "Val d'Hydra",
          "rating": "4.1"
        },
       
      ];

      
      final restaurant = restaurants[index % restaurants.length];

      return restaurantCardFav(
        restaurant["image"]!,
        restaurant["name"]!,
        restaurant["location"]!,
        restaurant["rating"]!,
        context,
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


Widget restaurantCardFav(String picture, String restauName, String location, String rating, BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const RestaurantViewPage())
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: screenWidth * 0.02,
            offset: Offset(0, screenWidth * 0.002),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(screenWidth * 0.03),
            ),
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.asset(
                picture,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restauName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rating,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.star_rate,
                      color: Colors.orange,
                      size: screenWidth * 0.05,
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
