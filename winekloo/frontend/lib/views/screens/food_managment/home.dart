import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; 
import '/views/screens/food_managment/add_new_item.dart';
import '/views/screens/food_managment/edit_resto_profile.dart';
import '/views/screens/food_managment/my_food_list.dart';
import '/views/screens/food_managment/resto_profile.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/views/screens/food_managment/my_reviews.dart'; 




class RestaurantDashboardApp extends StatelessWidget {
  const RestaurantDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: RestaurantDashboardPage(), 
    );
  }
}

class RestaurantDashboardPage extends StatelessWidget {
  const RestaurantDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor, 
      appBar: AppBar(
        title: const Text(
          'Restaurant Home',
          style: headlineStyle,
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
      ),
      body:
       
      SingleChildScrollView(
        
        padding: defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'Welcome Back salahs restau!',
              style: subheadingStyle.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 16.0),

            
            Container(
              decoration: cardDecoration,
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Access',
                    style: subheadingStyle,
                  ),
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
            ),

            const SizedBox(height: 24.0),

            // Card for Review Statistics
            Container(
              decoration: cardDecoration,
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Review Statistics',
                    style: subheadingStyle,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Average rating: 4.5/5',
                    style: bodyTextStyle,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: lightOrangeColor,
                            value: 60,
                            title: '60%',
                            titleStyle: buttonTextStyle,
                          ),
                          PieChartSectionData(
                            color: darkOrangeColor,
                            value: 30,
                            title: '30%',
                            titleStyle: buttonTextStyle,
                          ),
                          PieChartSectionData(
                            color: lightGrayColor,
                            value: 10,
                            title: '10%',
                            titleStyle: buttonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24.0),

            
            Container(
              decoration: cardDecoration,
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Review Comments',
                    style: subheadingStyle,
                  ),
                  const SizedBox(height: 16.0),
                  ListView.builder(
                    itemCount: 3, 
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: defaultPadding,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: lightGrayColor,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'khadidjalastar - 12/01/2024',
                              style: subheadingStyle.copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              'Great service and delicious food!',
                              style: bodyTextStyle,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
  onTap: () {
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewsPage(), 
      ),
    );
  },
  child: Row(
    mainAxisSize: MainAxisSize.min, 
    children: [
      Text(
        'See All',
        style: bodyTextStyle.copyWith(
          color: darkOrangeColor,
          fontWeight: FontWeight.bold, 
        ),
      ),
      const SizedBox(width: 4.0), 
      const Icon(
        Icons.arrow_forward,
        color: darkOrangeColor,
        size: 16.0,
      ),
    ],
  ),
),


                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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