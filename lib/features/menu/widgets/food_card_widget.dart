import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';

Widget foodCardWidget({
  required BuildContext context,
  required String url,
  required String title,
  required String description,
  required double price,
  required double rating,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.primWhite,
      borderRadius: BorderRadius.circular(20),
    ),
    clipBehavior: Clip.hardEdge,
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder:
                (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget:
                (context, url, error) => Icon(Icons.error, color: Colors.red),
            fit: BoxFit.cover,
            // height: 30,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.greenAccent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.star, color: Colors.green.shade800),
                        // SizedBox(width: 3),
                        Text(
                          rating.toString(),
                          style: TextStyle(color: Colors.green.shade800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "RS. $price",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primRed3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Flexible(
                    child: customButtonWidget(
                      context: context,
                      title: "Add",
                      onTap: () {},
                      trailingIcon: "assets/icons/add.svg",
                      bgColor: AppColors.primRed1,
                      titleColor: AppColors.primWhite,
                      iconColor: AppColors.primWhite,
                      borderColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
