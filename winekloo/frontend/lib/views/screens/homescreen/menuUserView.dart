import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart'; 

class FoodItem {
  final String name;
  final String details;
  final String price;
  final String category; 

  FoodItem({
    required this.name,
    required this.details,
    required this.price,
    required this.category, 
  });
}

class MenuUserView extends StatefulWidget {
  const MenuUserView({super.key});

  @override
  State<MenuUserView> createState() => _MenuUserViewState();
}


class _MenuUserViewState extends State<MenuUserView> {
  List<FoodItem> foodItems = [
    FoodItem(
      name: "Pizza",
      details: "tomato base, cheese and olives",
      price: "600",
      category:"Main Course"
    ),
    FoodItem(
      name: "Chicken pasta",
      details: "Chicken, cheese",
      price: "1400",
      category:"Main Course"
    ),
    FoodItem(
      name: "Caesar salad",
      details: "Lettuce, tomatoes, bread and chicken",
      price: "750",
      category:"Appetizers"
    ),
  ];

  void addFoodItem(FoodItem newItem) {
    setState(() {
      foodItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7, 
      child: Scaffold(
        backgroundColor: whiteColor, 
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: lightGrayColor, 
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: blackColor),
            ),
          ),
          title: const Text(
            "My Food List",
            style: blackHeadlineStyle, 
          ),
          centerTitle: true,
         bottom: const TabBar(
  isScrollable: true,
  labelColor: darkOrangeColor,
  unselectedLabelColor: darkGrayColor,
  indicatorColor: darkOrangeColor,
  labelStyle: orangeSubheadingStyle,
  tabs: [
    Tab(text: "All"),
    Tab(text: "Specials"),
    Tab(text: "Appetizers"),
    Tab(text: "Main Course"),
    Tab(text: "Desserts"),
    Tab(text: "Drinks"),
    Tab(text: "Kids’ Menu"),
  ],
),

        ),
       body: TabBarView(
  children: [
    _buildFoodList(), 
    _buildFoodList(category: "Specials"), 
    _buildFoodList(category: "Appetizers"), 
    _buildFoodList(category: "Main Course"), 
    _buildFoodList(category: "Desserts"), 
    _buildFoodList(category: "Drinks"), 
    _buildFoodList(category: "Vegetarian"), 
    _buildFoodList(category: "Kids' Menu"), 
  ],
),

        
      ),
    );
  }

 Widget _buildFoodList({String? category}) {
  final filteredItems = category == null
      ? foodItems 
      : foodItems.where((item) => item.category == category).toList();

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Total ${filteredItems.length} items", 
            style: placeholderTextStyle,
          ),
        ),
        ListView.builder(
          itemCount: filteredItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                color: whiteColor,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12.0),
                  leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: lightGrayColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      
                    ),
                  title: Text(item.name, style: blackBodyTextStyle),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.details, style: grayBodyTextStyle),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                           Text(" ${item.price}  DZD", style: orangeBodyTextStyle),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.more_vert, color: darkGrayColor),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    ),
  );
}

}
