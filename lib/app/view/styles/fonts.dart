import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/core/constants/fonts.dart';


/// Base text with black color and letter spacing set
class OccupyTextBase extends StatelessWidget {
  OccupyTextBase(
      this.text, {
        this.style,
        this.textAlign = TextAlign.left,
        this.overflow = TextOverflow.visible,
        this.maxLines = 1,
        Key? key,
      }) : super(key: key);
  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    assert(text != null, 'test can not be null');
    return Text(
      text ?? '',
      style: TextStyle(
        fontSize: 15.sp,
        fontFamily: AppFonts.inter,
      ).merge(style),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class TextBody extends OccupyTextBase {
  TextBody(
      String text, {
        Key? key,
        TextStyle? style,
        Color? color,
        double? fontSize,
        TextAlign textAlign = TextAlign.left,
        FontWeight fontWeight = FontWeight.w500,
        TextOverflow overflow = TextOverflow.visible,
        int maxLines = 2,
        double? height,
      }) : super(
    text,
    key: key,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      fontSize: fontSize ?? 14.sp,
      color: color ?? AppColors.textColor,
      fontWeight: fontWeight,
      height: height,
    ).merge(style),
    textAlign: textAlign,
  );
}

class TextBold extends OccupyTextBase {
  TextBold(
      String text, {
        Key? key,
        TextStyle? style,
        double? fontSize,
        FontWeight fontWeight = FontWeight.w800,
        Color? color,
        TextAlign textAlign = TextAlign.left,
        TextOverflow overflow = TextOverflow.visible,
        int maxLines = 2,
      }) : super(
    text,
    key: key,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      fontSize: fontSize ?? 25.sp,
      fontWeight: fontWeight,
      color: color ?? AppColors.textColor,
    ).merge(style),
    textAlign: textAlign,
  );
}

class TextSemiBold extends OccupyTextBase {
  TextSemiBold(
      String text, {
        Key? key,
        TextStyle? style,
        double? fontSize,
        Color? color,
        FontWeight fontWeight = FontWeight.w600,
        TextAlign textAlign = TextAlign.left,
        TextOverflow overflow = TextOverflow.visible,
        int maxLines = 2,
      }) : super(
    text,
    key: key,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      fontSize: fontSize ?? 16.sp,
      color: color ?? AppColors.textColor,
      fontWeight: fontWeight,
    ).merge(style),
    textAlign: textAlign,
  );
}

class TextSmall extends OccupyTextBase {
  TextSmall(
      String text, {
        double? fontSize,
        Key? key,
        TextStyle? style,
        Color? color,
        TextAlign textAlign = TextAlign.left,
        TextOverflow overflow = TextOverflow.visible,
        int maxLines = 2,
        FontStyle? fontStyle,
        FontWeight fontWeight = FontWeight.w400,
      }) : super(
    text,
    key: key,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      fontSize: fontSize??14.sp,
      fontWeight: fontWeight,
      color: color,
      fontFamily: AppFonts.inter,
      fontStyle: fontStyle,
    ).merge(style),
    textAlign: textAlign,
  );
}