import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbl/app/view/app.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/feature/items/presentation/changeNotifier/item_notifier.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {

  void runbackground()async{
   await di<ItemNotifier>().getAllItems(context);
  }

  @override
  @override
  void initState() {
    runbackground();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15.w,vertical: 20.h
            ),
          child: Column(
            children: [
              TextBody(
                  'All items will be listed below'
              ),
            ],
          ),
        ),
      ),
    );
  }
}
