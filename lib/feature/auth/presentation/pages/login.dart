import 'dart:async';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/app/view/widgets/text_box.dart';
import 'package:mbl/app/view/widgets/theme_button.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/core/navigation/route_name.dart';
import 'package:mbl/core/utils/custom_form_validator.dart';
import 'package:mbl/feature/auth/presentation/changeNotifier/authNotifier.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var canSubmit = false;

  late StreamController<String> _emailStreamController;
  late StreamController<String> _pinStreamController;

  final emailFocus = FocusNode();
  final pinFocus = FocusNode();

  final emailController = TextEditingController();
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailStreamController = StreamController<String>.broadcast();
    _pinStreamController = StreamController<String>.broadcast();

    emailController.addListener(() {
      _emailStreamController.sink.add(emailController.text.trim());
      validateInputs();
    });

    pinController.addListener(() {
      _pinStreamController.sink.add(pinController.text.trim());
      validateInputs();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _pinStreamController.close();
    emailFocus.dispose();
    pinFocus.dispose();
  }

  void validateInputs() {
    final emailError = CustomFormValidation.errorEmailMessage(
      emailController.text.trim(),
      'Email is required',
    );

    final pinError = CustomFormValidation.errorMessagePassword2(
      pinController.text.trim(),
      'Password is required',
    );

    // Check if email and password fields are non-empty and have no validation errors
    setState(() {
      canSubmit = emailController.text.trim().isNotEmpty &&
          pinController.text.trim().isNotEmpty &&
          emailError.isEmpty &&
          pinError.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, toolbarHeight: 2),
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(46.h),
                TextSemiBold(
                  'Login your ',
                  fontSize: 32.sp,
                ),
                TextSemiBold(
                  'Account',
                  fontSize: 32.sp,
                ),
                Gap(8.h),
                TextBody(
                  'Please login to your account',
                  fontSize: 14.sp,
                  color: AppColors.textSmallColor,
                ),
                Gap(33.h),
                TextBody(
                  'Email Address',
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                ),
                Gap(8.h),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: StreamBuilder<String>(
                    stream: _emailStreamController.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        fieldFocusNode: emailFocus,
                        label: 'Email',
                        validationColor: snapshot.data == null
                            ? AppColors.white
                            : CustomFormValidation.getColor(
                          snapshot.data,
                          emailFocus,
                          CustomFormValidation.errorEmailMessage(
                            snapshot.data,
                            'Email is required',
                          ),
                        ),
                        controller: emailController,
                        placeholder: 'Email',
                        validationMessage:
                        CustomFormValidation.errorEmailMessage(
                          snapshot.data,
                          'Email is required',
                        ),
                      );
                    },
                  ),
                ),
                Gap(10.h),
                TextBody(
                  'Password',
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: StreamBuilder<String>(
                    stream: _pinStreamController.stream,
                    builder: (context, snapshot) {
                      return InputField(
                        password: true,
                        label: 'Password',
                        fieldFocusNode: pinFocus,
                        textInputType: TextInputType.text,
                        validationColor: snapshot.data == null
                            ? AppColors.white
                            : CustomFormValidation.getColor(
                          snapshot.data,
                          pinFocus,
                          CustomFormValidation.errorMessagePassword2(
                            snapshot.data,
                            'Password is required',
                          ),
                        ),
                        validationMessage: CustomFormValidation.errorMessagePassword2(
                          snapshot.data,
                          'Password is required',
                        ),
                        controller: pinController,
                        placeholder: 'Password',
                      );
                    },
                  ),
                ),
                Gap(33.h),
                BusyButton(
                  title: 'Login',
                  onTap: () async {
                    await di<AuthNotifier>().login(
                      context,
                      username: emailController.text.trim(),
                      password: pinController.text.trim(),
                    );
                  },
                  disabled: !canSubmit,
                ),
                Gap(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpandTapWidget(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.forgotPassword);
                      },
                      tapPadding: const EdgeInsets.all(50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextBody(
                            'Forgot Password? ',
                            fontSize: 14.sp,
                          ),
                          TextBody(
                            'Reset',
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ),
                    ExpandTapWidget(
                      tapPadding: const EdgeInsets.all(50),
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.signup);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextBody(
                          'Sign Up',
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
