import 'package:brainsherpa/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String fontFamily = 'Poppins';
final textMedium = TextStyle(
  fontFamily: fontFamily,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  color: Colors.black,
);

poppinsTextStyle(
    {double size = 16,
    Color color = AppColors.textColor,
    double lineHeight = 1.2,
    double letterSpacing = 0,
    bool lineThrough = false,
    bool underline = false,
    FontWeight? fontWeight}) {
  return TextStyle(
      fontFamilyFallback: const ['AppleColorEmoji'],
      fontWeight: fontWeight ?? FontWeight.w400,
      fontFamily: 'Poppins',
      fontSize: size,
      letterSpacing: letterSpacing,
      height: lineHeight,
      color: color,
      decorationColor: Colors.white,
      decoration: lineThrough
          ? TextDecoration.lineThrough
          : underline
              ? TextDecoration.underline
              : TextDecoration.none);
}
