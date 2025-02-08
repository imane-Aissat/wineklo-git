import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:userworkside/models/menu_model.dart';
import '../../../bloc/menu_cubit.dart';

import 'package:flutter/material.dart';
import '/views/screens/food_managment/my_food_list.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart'; 

class AddNewItemsPage extends StatefulWidget {
  const AddNewItemsPage({super.key});

  @override
  State<AddNewItemsPage> createState() => _AddNewItemsPageState();
}

class _AddNewItemsPageState extends State<AddNewItemsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  String? selectedCategory; 
  File? _selectedImage; 
  final ImagePicker _picker = ImagePicker();
  final List<String> categories = [ 
    "Favorites", "Specials", "Appetizers", "Main Course", "Desserts", "Drinks", "Vegetarian", "Kids' Menu",
  ];
 

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text("Add New Item",
        style:blackHeadlineStyle ,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6), 
            decoration: BoxDecoration(
              color: Colors.grey[300], 
              shape: BoxShape.circle, 
            ),
            child: const Icon(
              Icons.arrow_back,
              color: darkBlueColor, 
            ),
          ),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                nameController.clear();
                priceController.clear();
                detailsController.clear();
                categoryController.clear();
                _selectedImage = null;
              });
            },
            child: const Text(
              "Reset",
              style: TextStyle(
                color: darkOrangeColor, 
                fontWeight: FontWeight.w600,
              
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: defaultPadding, 
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const Text(
                  "Item Name",
                  style: blackBodyTextStyle, 
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter item name",
                    hintStyle: grayBodyTextStyle, 
                  ),
                ),
                const SizedBox(height: 20),

                
                const Text(
                  "Upload Photo/Video",
                  style: blackBodyTextStyle, 
                ),
                const SizedBox(height: 10),
                     GestureDetector(
                 onTap:  _pickImage,
    
  
  child: Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            color: darkOrangeColor, 
            size: 40,
          ),
          SizedBox(height: 8),
          Text(
            "Add",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  ),
),

                
                const SizedBox(height: 20),
                  
                const Text("Category", style: blackBodyTextStyle),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Select category",
                  ),
                ),
                
                const SizedBox(height: 20),

               
                const Text(
                  "Item Price",
                  style: blackBodyTextStyle, 
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "300 da",
                    hintStyle: grayBodyTextStyle, 
                  ),
                ),
                const SizedBox(height: 20),

                
                const Text(
                  "Details",
                  style: blackBodyTextStyle, 
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: detailsController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Lorem ipsum dolor sit amet, consectetur adips cing elit. Bibendum in vel, mattis et amet dui mauris turpis.",
                    hintStyle: grayBodyTextStyle, 
                  ),
                ),
                const SizedBox(height: 20),

                
                
                Center(
                child: ElevatedButton(
                  onPressed: ()  async {
                  if (_formKey.currentState!.validate()) {
                    
                    final newItem = Menu(
                     
                      name: nameController.text,
                      price: int.tryParse(priceController.text) ?? 0,  // Converts to double, defaults to 0.0 if invalid
                      details: detailsController.text,
                      category: selectedCategory!,
                      picture: _selectedImage?.path,
                      restaurateurID: 2, 

                    ); 
               

        
// Return the new item to the previous screen
    Navigator.pop(context, newItem);
    
                  }
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:darkOrangeColor, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 112.0),
                  ),
                  child: const Text(
                    'SAVE CHANGES',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
