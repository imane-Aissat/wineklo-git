import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/models/reviews_model.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '/bloc/reviews_cubit.dart'; 

class UserReviewPage extends StatefulWidget {
  final int restaurateurID;

  const UserReviewPage({super.key, required this.restaurateurID});

  @override
  _UserReviewPageState createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
  final TextEditingController commentController = TextEditingController();
  int selectedRating = 0;

  @override
  void initState() {
    super.initState();
    context.read<ReviewsCubit>().loadReviews(widget.restaurateurID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews', style: blackHeadlineStyle),
        backgroundColor: whiteColor,
        centerTitle: true,
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
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: defaultPadding,
              child: BlocBuilder<ReviewsCubit, List<Review>>(
                builder: (context, reviews) {
                  if (reviews.isEmpty) {
                    return const Center(child: Text("No reviews available."));
                  }
                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: cardDecoration,
                          child: Padding(
                            padding: smallPadding,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: lightGrayColor,
                                  child: Text(
                                    review.foodieName != null
                                        ? review.foodieName![0]
                                        : "?", 
                                    style: whiteHeadlineStyle.copyWith(fontSize: 24),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            review.foodieName ?? "Anonymous",
                                            style: blackSubHeadlineStyle,
                                          ),
                                          PopupMenuButton<String>(
                                            onSelected: (value) {
                                              
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: 'edit',
                                                child: Text('Edit'),
                                              ),
                                              const PopupMenuItem(
                                                value: 'delete',
                                                child: Text('Delete'),
                                              ),
                                            ],
                                            icon: const Icon(Icons.more_vert, color: darkGrayColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4.0),
                                      Row(
                                        children: List.generate(5, (starIndex) {
                                          return Icon(
                                            starIndex < (review.rating ?? 0)  
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: darkOrangeColor,
                                            size: 20.0,
                                          );
                                        }),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(review.comment ?? "No comment", style: bodyTextStyle),
                                      const SizedBox(height: 8.0),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          review.date ?? "",
                                          style: placeholderTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: lightGrayColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: placeholderTextStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      style: primaryButtonStyle,
                      onPressed: () {
                        if (commentController.text.isNotEmpty && selectedRating > 0) {
                          context.read<ReviewsCubit>().addReview(
                            restaurateurID: widget.restaurateurID,
                            comment: commentController.text,
                            rating: selectedRating,
                          );

                          commentController.clear();
                          setState(() {
                            selectedRating = 0;
                          });
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (starIndex) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRating = starIndex + 1;
                        });
                      },
                      child: Icon(
                        starIndex < selectedRating ? Icons.star : Icons.star_border,
                        color: darkOrangeColor,
                        size: 30.0,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
