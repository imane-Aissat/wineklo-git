import 'package:flutter/material.dart';
import 'package:userworkside/views/screens/homescreen/menuUserView.dart';
import 'package:userworkside/views/screens/homescreen/reviewsUser.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart'; 



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

  const CategoryChip({super.key, required this.label});

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
  const ReviewCard({super.key});

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
                        builder: (context) => userReviewPage(),
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
                  '4.7',
                  style: bodyTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Total 20 reviews',
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





class RestaurantViewPage extends StatelessWidget {
  const RestaurantViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: whiteColor, 
          elevation: 0,
          leading: Container(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: blackColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            'Restaurant View',
            style: headlineStyle.copyWith(
              fontFamily: 'Sen', 
            ),
          ),
          actions: [
            Container(
              margin: smallPadding,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: lightGrayColor,
              ),
            ),
          ],
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
                    'assets/images/hichamcookpizza.jpg',
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
                'Hichem cook pizza',
                style: headlineStyle.copyWith(
                  fontSize: 24.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: horizontalPadding,
              child: Text(
                'Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.',
                style: bodyTextStyle.copyWith(
                  fontSize: 14.0,
                  color: darkGrayColor,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            
            Padding(
              padding: horizontalPadding,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  
                  bool isSmallScreen = constraints.maxWidth < 400;

                  return isSmallScreen
                      ? Column( 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Row(children: [
                            const Icon(Icons.star, color: darkOrangeColor, size: 20),
                            const SizedBox(width: 4),
                            Text(
                            '4.7',
                            style: headlineStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ],),
                          
                          ElevatedButton(
                            style: primaryButtonStyle,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to Favorites!'),
                                  ),
                                );
                              },
                              child: const Icon(Icons.favorite),
                        
                          
                          ),
                  
                        ],
                      ),
                      const SizedBox(height: 8), 
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: darkOrangeColor, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            'Cheraga',
                            style: bodyTextStyle.copyWith(
                              color: darkGrayColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$\$\$',
                            style: bodyTextStyle.copyWith(
                              color: darkOrangeColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Pricing',
                            style: bodyTextStyle.copyWith(
                              color: darkGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      : Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: darkOrangeColor, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '3.5',
                            style: headlineStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: darkOrangeColor, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            'Cheraga',
                            style: bodyTextStyle.copyWith(
                              color: darkGrayColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$\$\$',
                            style: bodyTextStyle.copyWith(
                              color: darkOrangeColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Pricing',
                            style: bodyTextStyle.copyWith(
                              color: darkGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16.0),
            Padding(
              padding: horizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: subheadingStyle.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 8.0),
                  const Wrap(
                    spacing: 10.0,
                    runSpacing: 8.0,
                    children: [
                      CategoryChip(label: 'Fast Food'),
                      CategoryChip(label: 'Vegetarian'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            Padding(
              padding: horizontalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu',
                    style: subheadingStyle.copyWith(
                      fontWeight: FontWeight.bold, color:Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuUserView(), 
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: bodyTextStyle.copyWith(
                            color: darkOrangeColor, 
                          ),
                        ),
                        const Icon(Icons.arrow_forward, color: darkOrangeColor, size: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MenuCard(
                    imagePath: 'assets/images/pizza.jpg',
                    itemName: 'Pizza',
                    price: '600',
                  ),
                  SizedBox(width: 16.0),
                  MenuCard(
                    imagePath: 'assets/images/pasta.jpg',
                    itemName: 'Pasta',
                    price: '1400',
                  ),
                  SizedBox(width: 16.0),
                  MenuCard(
                    imagePath: 'assets/images/caesarsalad.jpg',
                    itemName: 'Caesar Salad',
                    price: '750',
                  ),


                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: horizontalPadding,
              child: ReviewCard(),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: OpeningHoursCard(
                openingHours: {
                  'Sunday': '9:00 AM - 10:00 PM',
                  'Monday': '9:00 AM - 10:00 PM',
                  'Tuesday': '9:00 AM - 10:00 PM',
                  'Wednesday': '9:00 AM - 10:00 PM',
                  'Thursday': '9:00 AM - 10:00 PM',
                  'Friday': '9:00 AM - 11:00 PM',
                  'Saturday': '9:00 AM - 11:00 PM',
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

