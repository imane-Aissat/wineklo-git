import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/views/themes/styles/styles.dart';


class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true, 
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: screenWidth * 0.06,
                    ),
                  ),
                  Text(
                    "Help & Support",
                    style: blackSubHeadlineStyle.copyWith(
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: screenWidth * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Contact us,', style: blackHeadlineStyle.copyWith(color: darkOrangeColor)),
                    const Text('we would love to hear from you', style: blackBodyTextStyle, textAlign: TextAlign.center,),
                    SizedBox(height: screenHeight*0.03),
                    Text('On social media', style: blackSubHeadlineStyle.copyWith(color: darkOrangeColor)),
                    SizedBox(height: screenHeight*0.02),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: screenHeight*0.06,
                        width: screenWidth * 0.4,
                        decoration: cardDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.instagram, size: screenWidth*0.06,),
                            SizedBox(width: screenWidth*0.008),
                            SizedBox(
                              width: screenWidth* 0.25,
                              child: Text('Instagram', style: blackBodyTextStyle.copyWith(fontWeight: FontWeight.bold))
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: screenHeight*0.06,
                        width: screenWidth * 0.4,
                        decoration: cardDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.facebook, size: screenWidth*0.06,),
                            SizedBox(width: screenWidth*0.008),
                            SizedBox(
                              width: screenWidth* 0.25,
                              child: Text('Facebook', style: blackBodyTextStyle.copyWith(fontWeight: FontWeight.bold))
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: screenHeight*0.06,
                        width: screenWidth * 0.4,
                        decoration: cardDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.linkedinIn, size: screenWidth*0.06,),
                            SizedBox(width: screenWidth*0.008),
                            SizedBox(
                              width: screenWidth* 0.25,
                              child: Text('Linkedin', style: blackBodyTextStyle.copyWith(fontWeight: FontWeight.bold))
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.03),
                    SizedBox(
                      height: screenHeight*0.05,
                      child: Text("Or, directly from here" , style: blackSubHeadlineStyle.copyWith(color: darkOrangeColor)),
                    ),
                    SizedBox(height: screenHeight*0.02),
                    Container(
                      height: screenHeight*0.1,
                      decoration: cardDecoration,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 25.0,
                            horizontal: 10.0,
                          ),
                          filled: true,
                          fillColor: lightGrayColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Send us a message!", hintStyle: grayBodyTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02),
                    SizedBox(
                      height: screenHeight*0.05,
                      child: SizedBox(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            //lazm i add navigator.push l tae raz login
                          }, 
                          style: primaryButtonStyle,
                          child: const Text('Send', style: buttonTextStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
