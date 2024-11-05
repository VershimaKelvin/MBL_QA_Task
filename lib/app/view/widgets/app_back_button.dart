import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/core/constants/app_assets.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        Navigator.pop(context);
      },
      child: Transform.scale(
        scale: 0.8,
        child: Container(
          width: 36.w,
          height: 36.h,
          margin: EdgeInsets.only(left: 15.w),
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           border: Border.all(
             color: AppColors.appBarGrey
           )
         ),
         // padding: EdgeInsets.all(12),
          child: Center(
            child: SvgPicture.asset(
              fit: BoxFit.scaleDown,
              AppAssets.appBarBack,
            ),
          ),
        ),
      ),
    );
  }
}
