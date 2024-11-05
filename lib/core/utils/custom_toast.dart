import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:motion_toast/motion_toast.dart';


class MyCustomToast{
  static void displaySuccessMotionToast(BuildContext context,String message) {
    MotionToast toast = MotionToast.success(
      animationType: AnimationType.fromLeft,
      height: 50.h,
      description: TextBody(message,color: Color(0xff013220),),
      dismissable: true,
      position: MotionToastPosition.top,
      opacity: .8,
    );
    toast.show(context);
  }

  static  void displayWarningMotionToast(BuildContext context,String message) {
    MotionToast.warning(
      // title: const Text(
      //   'Warning Motion Toast',
      //   style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      description: Text(message),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
      opacity: .9,
    ).show(context);
  }

  static  void displayErrorMotionToast(BuildContext context,String message) {
    MotionToast.error(
      displaySideBar: false,
      title: TextBody(message),
      description: const Text(''),
      position: MotionToastPosition.top,
      barrierColor: Colors.black.withOpacity(0.3),
      width: 300.w,
      height: 50.h,
      opacity: 1,
      dismissable: false,
    ).show(context);
  }

  static void displayInfoMotionToast(BuildContext context,String message) {
    MotionToast.info(
      title:  Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      position: MotionToastPosition.center,
     description: const Text(''),
    ).show(context);
  }

  static void displayResponsiveMotionToast(BuildContext context,String message) {
    MotionToast(
      icon: Icons.rocket_launch,
      primaryColor: Colors.purple,
      title:  Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(
        '',
      ),
    ).show(context);
  }

  static void displayCustomMotionToast(BuildContext context,String message) {
    MotionToast(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.10,
      primaryColor: Colors.pink,
      title:  Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      dismissable: false,
      description: const Text(
        '',
      ),
      opacity: .5
    ).show(context);
  }

  static  void displayMotionToastWithoutSideBar(BuildContext context,String message,) {
    MotionToast(
      primaryColor: Colors.yellow[900]!,
      title: TextSmall(message,color: AppColors.textColor,),
      description: const Text(''),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      displayBorder: false,
      width: 350.w,
      height: 90.h,
      opacity: .4,
      margin: const EdgeInsets.only(
        top: 30,
      ),
    ).show(context);
  }

 static void displayMotionToastWithBorder(BuildContext context,String message) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.yellow,
      title: Text(message),
      description: const Text(''),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      displayBorder: false,
      width: 350.w,
      height: 80.h,
      margin: const EdgeInsets.only(
        top: 30,
      ),
    ).show(context);
  }

  static void displayTwoColorsMotionToast(BuildContext context,String message) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.orange[500]!,
      secondaryColor: Colors.grey,
      title: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(''),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      width: 350,
      height: 100,
    ).show(context);
  }

  static void displayTransparentMotionToast(BuildContext context,String message) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.yellow,
      title: const Text(
        '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(message),
      position: MotionToastPosition.center,
      width: 350,
      height: 100,
    ).show(context);
  }

  static void displaySimultaneouslyToasts(BuildContext context,String message) {
    MotionToast.warning(
      title:  Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(''),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
    ).show(context);
    MotionToast.error(
      title: const Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('Please enter your name'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 80,
    ).show(context);
  }
}
