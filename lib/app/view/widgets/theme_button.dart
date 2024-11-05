import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/core/constants/fonts.dart';

class BusyButton extends StatelessWidget {
  const BusyButton({
    required this.title,
    required this.onTap,
    this.disabled = false,
    this.textColor,
    this.color = AppColors.primaryColor,
    this.borderRadius,
    this.height,
    super.key,
  });
  final String title;
  final Color? color;
  final VoidCallback onTap;
  final bool disabled;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        height: height ?? 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(100.r),
          color: disabled ? AppColors.disabledButton : color,
        ),
        child: Center(
          child: TextSemiBold(
            title,
            color: textColor ?? AppColors.white,
            style:  TextStyle(
              fontSize: 14.sp,
              fontFamily: AppFonts.inter,
              //decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
