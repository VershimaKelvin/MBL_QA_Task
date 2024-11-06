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


  late StreamController<String> _usernameStreamController;
  late StreamController<String> _passwordStreamController;
  late StreamController<String> _repeatPasswordStreamController;


  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final repeatPasswordFocus = FocusNode();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameStreamController = StreamController<String>.broadcast();
    _passwordStreamController = StreamController<String>.broadcast();
    _repeatPasswordStreamController = StreamController<String>.broadcast();


    usernameController.addListener(() {
      _usernameStreamController.sink.add(
        usernameController.text.trim(),
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

  }

  @override
  void dispose() {
    super.dispose();
    _passwordStreamController.close();
    _repeatPasswordStreamController.close();
    _usernameStreamController.close();
    usernameFocus.dispose();
    passwordFocus.dispose();
    repeatPasswordFocus.dispose();
  }

  void validateInputs() {

    final firstNameError = CustomFormValidation.errorUsernameMessage(
      usernameController.text.trim(),
      'first Name is required',
    );


    final passwordError = CustomFormValidation.errorUsernameMessage(
      passwordController.text.trim(),
      'Password is required',
    );

    final confirmPasswordError =
    CustomFormValidation.errorMessageConfirmPassword(
      repeatPasswordController.text.trim(),
      'Re-enter password',
      passwordController.text,
    );

    setState(() {
      canSubmit =
          firstNameError.isEmpty &&
          passwordError.isEmpty &&
          confirmPasswordError.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthNotifier>(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: GestureDetector(
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
                          'Create An account',
                          fontSize: 32.sp,
                        ),
                        Gap(8.h),
                        TextBody(
                          'Create an account to see items',
                          fontSize: 14.sp,
                          color: AppColors.textSmallColor,
                        ),
                        Gap(33.h),
                        TextBody(
                          'Username',
                          fontSize: 14.sp,
                          color: AppColors.textColor,
                        ),
                        StreamBuilder<String>(
                          stream: _usernameStreamController.stream,
                          builder: (context, snapshot) {
                            return InputField(
                              fieldFocusNode: usernameFocus,
                              label: 'username',
                              validationColor: snapshot.data == null
                                  ? AppColors.white
                                  : CustomFormValidation.getColor(
                                snapshot.data,
                                usernameFocus,
                                CustomFormValidation.errorMessage(
                                  snapshot.data,
                                  'Username is required',
                                ),
                              ),
                              controller: usernameController,
                              placeholder: 'Enter Username',
                              validationMessage:
                              CustomFormValidation.errorMessage(
                                snapshot.data,
                                'username is required',
                              ),
                            );
                          },
                        ),
                        Gap(8.h),
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
                                    .errorUsernameMessage(
                                  snapshot.data,
                                  'Password is required',
                                ),
                              ),
                              validationMessage:
                              CustomFormValidation.errorUsernameMessage(
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
                                    .errorUsernameMessage(
                                  snapshot.data,
                                  're-enter password',
                                  passwordController.text,
                                ),
                              ),
                              controller: repeatPasswordController,
                              placeholder: 'Re-enter password',
                              password: true,
                              validationMessage: CustomFormValidation
                                  .errorUsernameMessage(
                                snapshot.data,
                                'Re-enter password',
                                passwordController.text,
                              ),
                              textInputType: TextInputType.text,
                            );
                          },
                        ),
                        Gap(33.h),
                        BusyButton(
                          title: 'Register',
                          onTap: () {
                            di<AuthNotifier>().register(
                                context,
                                password: repeatPasswordController.text.trim(),
                                username: usernameController.text.trim(),
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
      ),
    );
  }
}
