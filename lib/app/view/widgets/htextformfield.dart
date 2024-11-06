import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/core/constants/fonts.dart';



class HTextFormField extends StatelessWidget {
  HTextFormField({
    this.labeltext,
    required this.hinttext,
    this.error,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.formController,
    this.prefixIcon,
    this.suffixIcon,

    this.height,
    this.rowWidget,
    this.onFieldSubmitted,
    this.onchanged,
    this.onEditingComplete,
    this.fillcolor,
    this.inputFormatters,
    this.ontap,
    super.key,
  });

  final String hinttext;
  final String? labeltext;
  final bool? obscureText;
  final Color? fillcolor;
  final TextInputType? keyboardType;
  final double? height;
  final TextEditingController? formController;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? rowWidget;
  final bool? error;
  final void Function(String)? onFieldSubmitted;
  final ValueChanged<String>? onchanged;
  final void Function()? ontap;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>?  inputFormatters;

  bool filled = false;

  bool isThereSpecialCharacters(String value) {
    // Regular expression to allow letters, numbers, underscores, and spaces
    final regex = RegExp(r'^[a-zA-Z0-9_ ]+$');
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labeltext != null) Padding(
          padding: const EdgeInsets.only(left: 4),
          child: TextSmall(
            labeltext!,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color:  AppColors.textColor,  //  AppColors.labeltextColor,
            ),
          ),
        ) else Container(),

        Gap(2.h),
        TextFormField(
          onTap: ontap,
          inputFormatters: inputFormatters ?? [],
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onchanged,
          onEditingComplete: onEditingComplete,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: obscureText ?? false,
          controller: formController,
          style: TextStyle(
            color:    AppColors.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,

          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontSize: 10.sp,
              color: AppColors.primaryColor,
            ),
            filled: error,
            fillColor: fillcolor ?? Colors.transparent,
            contentPadding:
                EdgeInsets.only(
                 left: 12.w,
                  top: 21.h, bottom: 19.h),
            isDense: true,
            hintText: hinttext,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.formfieldColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              //gapPadding: 8,
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),

            errorBorder: OutlineInputBorder(
              // gapPadding: 8,
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color:  AppColors.textColor, //  AppColors.formfieldColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.textColor, //   AppColors.formfieldfocusedColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),
            // contentPadding: EdgeInsets.fromLTRB(18.w, 21.h, 0, 16.h),
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color:  AppColors.textColor, //  AppColors.hinttextColor,
              fontFamily: AppFonts.inter,
            ),
          ),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return '$hinttext is required';
                } else if (!isThereSpecialCharacters(value)) {
                  return '$hinttext cannot contain special characters';
                }
                return null;
              },
        ),
      ],
    );
  }
}
