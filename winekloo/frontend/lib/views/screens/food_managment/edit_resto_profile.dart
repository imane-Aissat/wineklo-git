import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart'; 







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
                'Name',
                style: placeholderTextStyle,
              ),
              const SizedBox(height: 8.0),
              
              TextFormField(
                initialValue: 'Default name',
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
