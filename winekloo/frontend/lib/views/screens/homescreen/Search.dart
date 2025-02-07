import 'package:flutter/material.dart';
import 'package:userworkside/views/screens/homescreen/restau%20profile.dart';
import 'package:userworkside/views/themes/styles/styles.dart';

import '/views/themes/styles/colors.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedCategory = 'Category';
  String selectedplace = 'Place';
  String selectedRating = 'Rating';

  final List<String> categories = ['Italian', 'Mexican', 'Traditional', 'Asian'];
  final List<String> places = ['sidi yahia', 'Zeralda', 'Mahelma', 'Alger Centre'];
  final List<String> ratings = ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search', style: blackSubHeadlineStyle.copyWith(fontSize: screenWidth * 0.05,)),
        backgroundColor: whiteColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightGrayColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search for restaurants',
                    hintStyle: const TextStyle(fontFamily: 'Sen'),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              
              // Filter Row (Clickable)
              const Text(
                'Filter By:',
                style: TextStyle(fontFamily: 'Sen', fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.01),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterButton(
                      label: selectedCategory,
                      onTap: () => showCategoryDialog(),
                    ),
                    FilterButton(
                      label: selectedplace,
                      onTap: () => showplaceDialog(),
                    ),
                    FilterButton(
                      label: selectedRating,
                      onTap: () => showRatingDialog(),
                    ),
                  ],
                ),
              ),
              
              
              const SizedBox(height: 20),
              const Text(
                'Results',
                style: TextStyle(fontFamily: 'Sen', fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1, 
                itemBuilder: (context, index) {
                  return RestaurantCard(
                    image: 'assets/images/sushiball.png', 
                    name: 'Sushi ball ${index + 1}',
                    location: 'Dely brahim ${index + 1}',
                    rating: '3.8',
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> showCategoryDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: SingleChildScrollView(
            child: Column(
              children: categories.map((category) {
                return ListTile(
                  title: Text(category),
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Future<void> showplaceDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select place'),
          content: SingleChildScrollView(
            child: Column(
              children: places.map((place) {
                return ListTile(
                  title: Text(place),
                  onTap: () {
                    setState(() {
                      selectedplace = place;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  
  Future<void> showRatingDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Rating'),
          content: SingleChildScrollView(
            child: Column(
              children: ratings.map((rating) {
                return ListTile(
                  title: Text(rating),
                  onTap: () {
                    setState(() {
                      selectedRating = rating;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String rating;
  final BuildContext context;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const RestaurantViewPage(restaurateurID: 1,))
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(location, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(rating, style: const TextStyle(fontFamily: 'Sen', fontSize: 16, fontWeight: FontWeight.bold)),
                      const Icon(Icons.star_rate, color: Colors.orange),
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


class FilterButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Sen',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: whiteColor, 
            ),
          ),
          backgroundColor: lightOrangeColor, 
          side: const BorderSide(color: lightOrangeColor),
        ),
      ),
    );
  }
}
