import 'package:flutter/material.dart';
import 'package:oneman/features/food_details/models/food_review_model.dart';

Widget reviewCard({
  required BuildContext context,
  required FoodReviewModel review,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.grey.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User + rating
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(review.author[0].toUpperCase()),
                ),
                SizedBox(width: 10),

                Text(
                  review.author,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange),
                  SizedBox(width: 5),
                  Text(review.rating.toString()),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        Text(review.comment, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 8),

        Text(review.date, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ),
  );
}
