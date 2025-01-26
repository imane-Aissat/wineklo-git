import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart'; 





class CategoriesSelection extends StatefulWidget {
  const CategoriesSelection({super.key});

  @override
  _CategoriesSelectionState createState() => _CategoriesSelectionState();
}

class _CategoriesSelectionState extends State<CategoriesSelection> {
  String? selectedCategory;

  final List<String> categories = [
    'ALL',
    'TURKISH',
    'CHINESE',
    'ITALIAN',
    'JAPANESE',
    'SYRIAN',
    'INDIAN',
    'MEXICAN',
    'OTHER',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'CATEGORIES',
              style: subheadingStyle,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedCategory = null; 
                });
              },
              child: const Text(
                'CLEAR ALL',
                style: TextStyle(color: blackColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0, 
          runSpacing: 12.0, 
          children: categories.map((category) {
            final isSelected = selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category; 
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: isSelected ? darkOrangeColor : lightGrayColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? whiteColor : blackColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class RestaurantEditPage extends StatelessWidget {
  const RestaurantEditPage({super.key});

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
            margin: smallPadding,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: blackColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            'Edit page',
            style: blackHeadlineStyle.copyWith(
              fontFamily: 'Sen',
            ),
          ),
          actions: [
            Container(
              margin: smallPadding,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
              child: IconButton(
                icon: const Icon(Icons.more_horiz, color: blackColor),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'RESTAURANT NAME',
                style: placeholderTextStyle,
              ),
              const SizedBox(height: 8.0),
              
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGrayColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: lightGrayColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: darkOrangeColor),
                  ),
                ),
                items: ['Hichem cook']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: bodyTextStyle),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  
                },
              ),
              const SizedBox(height: 16.0),
              
              const Text(
                'LOCATION',
                style: placeholderTextStyle,
              ),
              const SizedBox(height: 8.0),
              
              TextFormField(
                initialValue: 'Zeralda',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGrayColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: lightGrayColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: darkOrangeColor),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
             
              const Text(
                'OPENING HOURS',
                style: headlineStyle,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: lightGrayColor,
                        ),
                        child: const Text(
                          'DAYS',
                          style: bodyTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: lightGrayColor,
                        ),
                        child: const Text(
                          'OPENING-CLOSING',
                          style: bodyTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: const BoxDecoration(
                              color: lightGrayColor,
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Day ${index + 1}',
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: const BoxDecoration(
                              color: lightGrayColor,
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Open-Close',
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const CategoriesSelection(),
              const SizedBox(height: 16.0),
              const Text(
                'UPLOAD PHOTO/VIDEO',
                style: headlineStyle,
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                 //adding the upload laterr
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: lightGrayColor, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: lightGrayColor,
                        child: Icon(Icons.cloud_upload, color: darkOrangeColor),
                      ),
                      SizedBox(height: 8.0),
                      Text('Add', style: TextStyle(color: darkGrayColor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'DETAILS',
                style: headlineStyle,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: lightGrayColor,
                  border: OutlineInputBorder(),
                  hintText: 'Enter your details',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32.0),

             
              Center(
                child: ElevatedButton(
                  onPressed: () {
                   
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, 
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
    );
  }
}
