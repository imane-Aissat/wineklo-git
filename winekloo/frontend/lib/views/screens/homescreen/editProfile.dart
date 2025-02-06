import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/bloc/foodie_cubit.dart';
import '/models/foodie_model.dart';

class EditProfile extends StatefulWidget {
  final int foodieID;

  const EditProfile({super.key, required this.foodieID});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  Foodie? currentFoodie; 

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    
    Future.microtask(() {
      context.read<FoodieCubit>().loadProfile(1);
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile Settings',
          style: blackSubHeadlineStyle.copyWith(fontSize: screenWidth * 0.05),
        ),
        backgroundColor: whiteColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<FoodieCubit, Foodie?>(
                listener: (context, foodie) {
                  if (foodie != null) {
                    setState(() {
                      currentFoodie = foodie;
                      usernameController.text = foodie.fullname ?? '';
                      emailController.text = foodie.email ?? '';
                      phoneController.text = foodie.phoneNumber ?? '';
                    });
                  }
                },
                builder: (context, foodie) {
                  if (foodie == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.12,
                            backgroundColor: lightGrayColor,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {}, 
                              child: Container(
                                height: screenWidth * 0.08,
                                width: screenWidth * 0.08,
                                decoration: const BoxDecoration(
                                  color: darkOrangeColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      textField(context, "USERNAME", usernameController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      textField(context, "EMAIL", emailController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      textField(context, "PHONE NUMBER", phoneController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      SizedBox(
                        width: screenWidth * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                          style: primaryButtonStyle,
                          onPressed: () async {
                            context.read<FoodieCubit>().updateFoodieDetails(
                              fullname: usernameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                            );

                            Navigator.pop(context);
                          },
                          child: Text(
                            "Save changes",
                            style: whiteSubheadingStyle.copyWith(
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(BuildContext context, String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            label,
            style: blackBodyTextStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrayColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
