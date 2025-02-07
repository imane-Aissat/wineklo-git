import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/reviews_cubit.dart';
import '../../../models/reviews_model.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';

class ReviewsPage extends StatelessWidget {

 ReviewsPage({super.key});

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
      body: BlocProvider(
        create: (context) => ReviewsCubit()..loadReviews(2), 
        child: BlocBuilder<ReviewsCubit, List<Review>>(
          builder: (context, reviews) {
            if (reviews.isEmpty) {
              return const Center(child: Text("No reviews available."));
            }
            return Padding(
              padding: defaultPadding,
              child: ListView.builder(
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
                                    : "U", // Example fallback
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
                                    ],
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(review.comment ?? "No comment", style: bodyTextStyle),
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
                                  const SizedBox(height: 8.0),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
  review.date != null
      ? review.date!
      : "Date unavailable",
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
              ),
            );
          },
        ),
      ),
    );
  }
}
