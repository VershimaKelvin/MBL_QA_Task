import 'dart:async';

import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:provider/provider.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  Future<void> runBackgroundData() async {
    try {
    } catch (e) {}
  }

  bool isChecked = false;
  var canSubmit = false;

  late StreamController<String> _lastNameStreamController;
  late StreamController<String> _emailStreamController;
  late StreamController<String> _firstNameStreamController;
  late StreamController<String> _passwordStreamController;
  late StreamController<String> _repeatPasswordStreamController;

  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final firstNameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final repeatPasswordFocus = FocusNode();

  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    runBackgroundData();
    _lastNameStreamController = StreamController<String>.broadcast();
    _firstNameStreamController = StreamController<String>.broadcast();
    _emailStreamController = StreamController<String>.broadcast();
    _passwordStreamController = StreamController<String>.broadcast();
    _repeatPasswordStreamController = StreamController<String>.broadcast();


    firstNameController.addListener(() {
      _firstNameStreamController.sink.add(
        firstNameController.text.trim(),
      );
      validateInputs();
    });


    lastNameController.addListener(() {
      _lastNameStreamController.sink.add(
        lastNameController.text.trim(),
      );
      validateInputs();
    });

    emailController.addListener(() {
      _emailStreamController.sink.add(
        emailController.text.trim(),
      );
      validateInputs();
    });

    passwordController.addListener(() {
      _passwordStreamController.sink.add(
        passwordController.text.trim(),
      );
      validateInputs();
    });

    repeatPasswordController.addListener(() {
      _repeatPasswordStreamController.sink.add(
        repeatPasswordController.text.trim(),
      );
      validateInputs();
    });

    // firstNameFocus.addListener();
  }

  @override
  void dispose() {
    super.dispose();
    _lastNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _repeatPasswordStreamController.close();
    _firstNameStreamController.close();

    lastNameFocus.dispose();
    firstNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    repeatPasswordFocus.dispose();
  }

  void validateInputs() {
    final lastNameError = CustomFormValidation.errorEmailMessage(
      lastNameController.text.trim(),
      'last Name is required',
    );

    final firstNameError = CustomFormValidation.errorEmailMessage(
      firstNameController.text.trim(),
      'first Name is required',
    );

    final emailError = CustomFormValidation.errorEmailMessage(
      emailController.text.trim(),
      'Email is required',
    );

    final passwordError = CustomFormValidation.errorMessagePassword2(
      passwordController.text.trim(),
      'Password is required',
    );

    final confirmPasswordError =
    CustomFormValidation.errorMessageConfirmPassword(
      repeatPasswordController.text.trim(),
      'Re-enter password',
      passwordController.text,
    );

    // Check if the checkbox is checked and there are no validation errors
    setState(() {
      canSubmit = isChecked &&
          emailError.isEmpty &&
          lastNameError.isEmpty &&
          firstNameError.isEmpty &&
          passwordError.isEmpty &&
          // di<AuthNotifier>().selectedEstateID != null &&
          confirmPasswordError.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthNotifier>(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(50.h),
                      TextSemiBold(
                        'Create your new account',
                        fontSize: 32.sp,
                      ),
                      Gap(8.h),
                      TextBody(
                        'Create an account to start shopping within your estate',
                        fontSize: 14.sp,
                        color: AppColors.textSmallColor,
                      ),
                      Gap(33.h),
                      TextBody(
                        'First Name',
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                      ),
                      StreamBuilder<String>(
                        stream: _firstNameStreamController.stream,
                        builder: (context, snapshot) {
                          return InputField(
                            fieldFocusNode: firstNameFocus,
                            label: 'first name',
                            validationColor: snapshot.data == null
                                ? AppColors.white
                                : CustomFormValidation.getColor(
                              snapshot.data,
                              firstNameFocus,
                              CustomFormValidation.errorMessage(
                                snapshot.data,
                                'first name is required',
                              ),
                            ),
                            controller: firstNameController,
                            placeholder: 'first name',
                            validationMessage:
                            CustomFormValidation.errorMessage(
                              snapshot.data,
                              'first name is required',
                            ),
                          );
                        },
                      ),
                      Gap(8.h),
                      TextBody(
                        'Last Name',
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                      ),
                      StreamBuilder<String>(
                        stream: _lastNameStreamController.stream,
                        builder: (context, snapshot) {
                          return InputField(
                            fieldFocusNode: lastNameFocus,
                            label: 'last name',
                            validationColor: snapshot.data == null
                                ? AppColors.white
                                : CustomFormValidation.getColor(
                              snapshot.data,
                              lastNameFocus,
                              CustomFormValidation.errorMessage(
                                snapshot.data,
                                'last name is required',
                              ),
                            ),
                            controller: lastNameController,
                            placeholder: 'last name',
                            validationMessage:
                            CustomFormValidation.errorMessage(
                              snapshot.data,
                              'last name is required',
                            ),
                          );
                        },
                      ),
                      Gap(8.h),
                      TextBody(
                        'Email Address',
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                      ),
                      StreamBuilder<String>(
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
                            placeholder: 'Enter Email Address',
                            validationMessage:
                            CustomFormValidation.errorEmailMessage(
                              snapshot.data,
                              'Email is required',
                            ),
                          );
                        },
                      ),
                      Gap(8.h),
                      Gap(10.h),
                      TextBody(
                        'Password',
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                      ),
                      Gap(8.h),
                      StreamBuilder<String>(
                        stream: _passwordStreamController.stream,
                        builder: (context, snapshot) {
                          return InputField(
                            label: 'Password',
                            fieldFocusNode: passwordFocus,
                            textInputType: TextInputType.text,
                            password: true,
                            validationColor: snapshot.data == null
                                ? AppColors.white
                                : CustomFormValidation.getColor(
                              snapshot.data,
                              passwordFocus,
                              CustomFormValidation
                                  .errorMessagePassword(
                                snapshot.data,
                                'Password is required',
                              ),
                            ),
                            validationMessage:
                            CustomFormValidation.errorMessagePassword(
                              snapshot.data,
                              'Password is required',
                            ),
                            controller: passwordController,
                            placeholder: 'Enter Password',
                          );
                        },
                      ),
                      Gap(10.h),
                      TextBody(
                        'Confirm Password',
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                      ),
                      Gap(8.h),
                      StreamBuilder<String>(
                        stream: _repeatPasswordStreamController.stream,
                        builder: (context, snapshot) {
                          return InputField(
                            fieldFocusNode: repeatPasswordFocus,
                            label: 'Confirm password',
                            validationColor: snapshot.data == null
                                ? AppColors.white
                                : CustomFormValidation.getColor(
                              snapshot.data,
                              repeatPasswordFocus,
                              CustomFormValidation
                                  .errorMessageConfirmPassword(
                                snapshot.data,
                                're-enter password',
                                passwordController.text,
                              ),
                            ),
                            controller: repeatPasswordController,
                            placeholder: 'Re-enter password',
                            password: true,
                            validationMessage: CustomFormValidation
                                .errorMessageConfirmPassword(
                              snapshot.data,
                              'Re-enter password',
                              passwordController.text,
                            ),
                            textInputType: TextInputType.text,
                          );
                        },
                      ),
                      Gap(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Transform.scale(
                              scale: 0.7,
                              child: Checkbox(
                                value: isChecked,
                                side: const BorderSide(
                                    color: AppColors.primaryColor),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                    validateInputs();
                                  });
                                },
                                activeColor: AppColors
                                    .primaryColor, // Make the actual checkbox transparent
                                // Set the check color to orange
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: 'I Agree with ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms of Service ',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'and',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Privacy Policy ',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(33.h),
                      BusyButton(
                        title: 'Register',
                        onTap: () {
                          di<AuthNotifier>().register(
                              context,
                              password: repeatPasswordController.text.trim(),
                              username: ''
                          );
                        },
                        disabled: !canSubmit,
                      ),
                      Gap(50.h),
                      Padding(
                          padding: EdgeInsets.only(bottom: 57.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBody(
                                'Already have an Account?',
                                fontSize: 14.sp,
                              ),
                              ExpandTapWidget(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteName.login);
                                },
                                tapPadding: EdgeInsets.all(40),
                                child: TextBody(
                                  'Sign In',
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
