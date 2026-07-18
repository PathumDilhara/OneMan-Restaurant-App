import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/svg_icon.dart';

Widget customButtonWidget({
  required BuildContext context,
  required String title,
  String? leadingIcon,
  String? trailingIcon,
  double? width,
  double? height,
  required VoidCallback onTap,
  Color bgColor = AppColors.primWhite,
  Color iconColor = AppColors.primDark,
  Color titleColor = AppColors.primDark,
  Color borderColor = AppColors.primGrey,
  Color tappingColor = AppColors.primGrey,
}) {
  return Material(
    borderRadius: BorderRadius.circular(100),
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(100),
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
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (leadingIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: SVGIcon(icon: leadingIcon, color: iconColor),
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
                padding: const EdgeInsets.only(left: 3.0),
                child: SVGIcon(icon: trailingIcon, color: iconColor),
              ),
          ],
        ),
      ),
    ),
  );
}
