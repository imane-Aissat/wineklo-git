import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:userworkside/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:userworkside/themes/styles/colors.dart';

class EditItemPage extends StatefulWidget {
  final Menu existingItem;

  const EditItemPage({super.key, required this.existingItem});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController detailsController;
  late TextEditingController categoryController;
  String? selectedCategory;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final List<String> categories = [
    "Favorites", "Specials", "Appetizers", "Main Course", "Desserts", "Drinks", "Vegetarian", "Kids' Menu",
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the existing item's data
    nameController = TextEditingController(text: widget.existingItem.name);
priceController = TextEditingController(
  text: widget.existingItem.price?.toString() ?? '',
);
    detailsController = TextEditingController(text: widget.existingItem.details);
    selectedCategory = widget.existingItem.category;
    _selectedImage = widget.existingItem.picture != null ? File(widget.existingItem.picture!) : null;
     
  }

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
        title: const Text("Edit Item"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Item Name"),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter item name",
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Upload Photo/Video"),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: _selectedImage == null
                          ? const Icon(Icons.cloud_upload_outlined, size: 40)
                          : Image.file(
                              _selectedImage!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Category"),
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
                const Text("Item Price"),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "300 da",
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Details"),
                const SizedBox(height: 10),
                TextFormField(
                  controller: detailsController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Item details...",
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                       if (_formKey.currentState!.validate()) {
    widget.existingItem.name = nameController.text;
widget.existingItem.price = int.tryParse(priceController.text);
    widget.existingItem.details = detailsController.text;
    widget.existingItem.category = selectedCategory!;
    widget.existingItem.picture = _selectedImage?.path; 
    Navigator.pop(context, widget.existingItem);
  }

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkOrangeColor,

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
