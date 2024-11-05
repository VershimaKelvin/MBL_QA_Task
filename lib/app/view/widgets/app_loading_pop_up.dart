import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/app/view/styles/app_colors.dart';

@lazySingleton
class AppLoadingPopup {
  Future<dynamic> show(
    BuildContext context, {
    String? text,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1,
            sigmaY: 1,
          ),
          child: const Center(
            child:CircularProgressIndicator(
              color: AppColors.primaryColor,
            )
          ),
        );
      },
    );
  }
}
