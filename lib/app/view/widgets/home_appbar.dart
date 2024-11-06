import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/core/constants/app_assets.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.centerTitle = false,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90.h,
      leading: Padding(
        padding:  EdgeInsets.only(left: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextSmall(
                  'Location',
                ),
              ],
            ),
            Gap(9.h),
            Row(
              children: [
                SvgPicture.asset(AppAssets.locator),
                Gap(12.w),
                TextSemiBold(
                  'Efab Estate, Abuja',
                  fontSize: 14.sp,
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: AppColors.white,
      forceMaterialTransparency: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 19),
          child: SvgPicture.asset(AppAssets.barNotification),
        ),
      ],
      elevation: 1,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
