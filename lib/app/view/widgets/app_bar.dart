import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/widgets/app_back_button.dart';

class OccupyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OccupyAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.centerTitle = false,
    this.wantBackButton = true,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final bool centerTitle;
  final bool wantBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:wantBackButton? AppBackButton() :Container(),
      backgroundColor: AppColors.white,
      forceMaterialTransparency: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
      elevation: 1,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
