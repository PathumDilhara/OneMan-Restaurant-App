import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/svg_icon.dart';

Widget customButtonWidget({
  required BuildContext context,
  required String title,
  String? leadingIconPath,
  String? leadingImageUrl,
  String? trailingIcon,
  double? width,
  double? height,
  double br = 100,
  required VoidCallback onTap,
  Color bgColor = AppColors.primWhite,
  Color iconColor = AppColors.primDark,
  Color titleColor = AppColors.primDark,
  Color borderColor = AppColors.primGrey,
  Color tappingColor = AppColors.primGrey,
}) {
  return Material(
    borderRadius: BorderRadius.circular(br),
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(br),
      overlayColor: WidgetStatePropertyAll(
        tappingColor..withValues(alpha: 0.3),
      ),
      onTap: onTap,
      child: Ink(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(br),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingImageUrl != null)
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: CachedNetworkImage(
                    imageUrl: leadingImageUrl,
                    fit: BoxFit.cover,
                    width: 25,
                      height: 25,
                  ),
                ),
              ),
            if (leadingIconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: SVGIcon(icon: leadingIconPath, color: iconColor),
              ),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: titleColor),
              overflow: TextOverflow.ellipsis,
            ),
            if (trailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SVGIcon(icon: trailingIcon, color: iconColor),
              ),
          ],
        ),
      ),
    ),
  );
}
