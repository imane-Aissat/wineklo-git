import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/views/screens/food_managment/add_new_item.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '../../../bloc/menu_cubit.dart';
import 'dart:io';
import '/models/menu_model.dart';



class FoodMenuPage extends StatelessWidget {
  const FoodMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<MenuCubit>()..fetchMenusByRestaurantId(2),
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            title: const Text(
              "My Food List",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            centerTitle: true,
            bottom: const TabBar(
              isScrollable: true,
              labelColor: darkOrangeColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: darkOrangeColor,
              labelStyle: TextStyle(fontSize: 18, color: darkOrangeColor),
              tabs: [
                Tab(text: "All"),
                Tab(text: "Favorites"),
                Tab(text: "Specials"),
                Tab(text: "Appetizers"),
                Tab(text: "Main Course"),
                Tab(text: "Desserts"),
                Tab(text: "Drinks"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildFoodList(),
              _buildFoodList(category: "Favorites"),
              _buildFoodList(category: "Specials"),
              _buildFoodList(category: "Appetizers"),
              _buildFoodList(category: "Main Course"),
              _buildFoodList(category: "Desserts"),
              _buildFoodList(category: "Drinks"),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              try {
                final newItem = await Navigator.push<Menu>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewItemsPage(),
                  ),
                );
                if (newItem != null) {
                  context.read<MenuCubit>().createMenu(newItem);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              }
            },
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(color: darkOrangeColor, width: 2.0),
            ),
            child: const Icon(Icons.add, color: darkOrangeColor),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

Widget _buildFoodList({String? category}) {
  return BlocBuilder<MenuCubit, List<Menu>>(
    builder: (context, menus) {
      if (menus == null || menus.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }else {
         // Ensure category names are trimmed and compared correctly
      final filteredItems = category != null
          ? menus.where((item) => item.category?.trim().toLowerCase() == category.trim().toLowerCase()).toList()
          : menus;

        if (filteredItems.isEmpty) {
          return const Center(child: Text("No items found"));
        }

        return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];


              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  color: Colors.white,
                  
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                     leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(Icons.image, color: Colors.grey),
      ),
title: Text(item.name ?? "Unknown Name"),  // <-- Safe default
subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(item.details ?? "No details available"),  // <-- Safe default
    const SizedBox(height: 4),
    Text("${item.price ?? "0"} DZD", style: TextStyle(color: darkOrangeColor)),
  ],
),
                    trailing: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.black),
                      onSelected: (value) async {
                        }
                    ,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),

                    ),
                 
                ),
              );
            },
          );
        
      }
    },
  );
}

}
