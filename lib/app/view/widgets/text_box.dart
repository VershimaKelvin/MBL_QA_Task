import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/core/constants/app_assets.dart';
import 'package:mbl/core/constants/fonts.dart';


class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.placeholder,
    this.enterPressed,
    this.fieldFocusNode,
    this.nextFocusNode,
    this.additionalNote,
    this.formatter,
    this.onChanged,
    this.maxLines = 1,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.isReadOnly = false,
    this.smallVersion = true,
    this.backgroundColor =  AppColors.white, //AppColors.textFieldBackground,
    this.suffix,
    this.onTap,
    this.prefix,
    this.validationColor = Colors.transparent,
    //this.height = 50,
    this.label,
    this.showLabel = false,
    this.borderColor,
    this.placeholderColor = AppColors.textfieldPlaceColor, //AppColors.personalProfileHint,
    this.labelTextColor = Colors.purple, // AppColors.personalProfileHint,
    super.key,});

  final Color labelTextColor;
  final Color placeholderColor;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool password;
  final bool isReadOnly;
  final String placeholder;
  final String? validationMessage;
  final Function? enterPressed;
  final bool smallVersion;
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String? additionalNote;
  final Function? onTap;
  final Function(String)? onChanged;
  final Color backgroundColor;
  final String? label;
  final bool showLabel;
  final int maxLines;
  final Widget? suffix;
  final Widget? prefix;
  final Color validationColor;
  final Color? borderColor;
  final List<TextInputFormatter>? formatter;

  //final double height;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  late bool isPassword;
  double fieldHeight = 70;
  late bool isLabel;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
    isLabel = widget.showLabel;
  }

  bool activateLabel = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: GestureDetector(
                  onTap: widget.showLabel
                      ? () {
                    setState(() {
                      activateLabel = true;
                    });
                  }
                      : null,
                  child: Container(
                   // height: widget.height,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      border: Border.all(
                          color: widget.borderColor
                              ?? AppColors.formfieldColor,
                      ), // Green border
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: <Widget>[
                        widget.prefix ?? const SizedBox(),
                        const Gap(10),
                        Expanded(
                          child: TextField(
                            onTap: widget.showLabel
                                ? () {
                              setState(() {
                                activateLabel = true;
                              });
                              if (widget.enterPressed != null) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // ignore: avoid_dynamic_calls
                                widget.enterPressed!();
                              }
                            }
                                : null,
                                
                            controller: widget.controller,
                            cursorColor: AppColors.primaryColor,
                            keyboardType: widget.textInputType,
                            inputFormatters: widget.formatter ?? [],
                            focusNode: widget.fieldFocusNode,
                            textInputAction: widget.textInputAction,
                            onChanged: widget.onChanged,
                            onEditingComplete: () {},
                            obscureText: isPassword,
                            readOnly: widget.isReadOnly,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                             // contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                              hintText: widget.placeholder,
                              border: InputBorder.none,
                              isDense:true,
                              contentPadding: EdgeInsets.only(top: 18.h,bottom: 18.h),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: activateLabel || widget.controller!.text.isNotEmpty
                                    ? AppColors.primaryColor // Change color when active or has text
                                    : widget.placeholderColor,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: widget.placeholderColor,
                                fontFamily: AppFonts.inter, //AppFonts.dmsans,
                              ),
                            ),
                          ),
                        ),
                        widget.suffix ??
                            GestureDetector(
                              onTap: () => setState(() {
                                isPassword = !isPassword;
                              }),
                              child: widget.password
                                  ? Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                child: isPassword
                                    ?  SvgPicture.asset(
                                  width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.scaleDown,
                                    AppAssets.invisible)
                                // SvgPicture.asset(
                                // AppAssets.invisible,


                                // )
                                    : const Icon(
                                  Icons.visibility_rounded,
                                  color: Color(0xff71759D),
                                  size: 20,
                                ),
                              )
                                  : Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.showLabel)
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18,top: 4.h),
                      child: activateLabel && widget.controller!.text.isNotEmpty // Check if field is not empty
                          ? Column(
                        children: [
                          ColoredBox(
                            color: Colors.grey.shade400, //AppColors.textFieldBackground,
                            child: SizedBox(
                              child: TextBody(
                                ' ${widget.label} ',
                                fontSize: 10.sp,
                                color: widget.fieldFocusNode!.hasFocus
                                    ? Colors.green //AppColors.personalProfileHint
                                    : Colors.indigoAccent, ),),),

                        ],
                      )
                          : const SizedBox(),
                    ),
                    Gap(6.h),
                  ],
                )
              else
                const SizedBox(),
            ],
          ),
        ),
        if (widget.validationMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: TextBody(
              widget.validationMessage!,
              color: Colors.red,
              fontSize: 10,
            ),
          )
        else
          const SizedBox(),
        if (widget.additionalNote != null) const Gap(5) else const SizedBox(),
        if (widget.additionalNote != null)
          TextBody(widget.additionalNote!)
        else
          const SizedBox(),
      ],
    );
  }
}
