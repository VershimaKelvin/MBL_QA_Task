import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/presentation/changeNotifier/item_notifier.dart';
import 'package:mbl/feature/items/presentation/pages/update_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({
    required this.item,
    super.key});

  final ItemEntity item;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.item.createdAt!);
    String formattedDate = DateFormat('d MMMM yyyy').format(date);
    DateTime date2 = DateTime.parse(widget.item.createdAt!);
    String updatedAt = DateFormat('d MMMM yyyy').format(date);
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.white,),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBody('Details about this item'),
                ],
              ),
              Gap(40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBody('Name:'),
                  Container(width: 100.w,
                      child: TextSmall(
                        widget.item.name!,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBody('Description:'),
                  Container(
                      width: 200.w,
                      child: TextSmall(
                        maxLines: 10,
                          widget.item.description!))
                ],
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBody('CreatedAt:'),
                  TextSmall(formattedDate)
                ],
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBody('UpdatedAt:'),
                  TextSmall(updatedAt)
                ],
              ),
              Gap(50.h),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateScreen(item: widget.item),
                        ),
                      );
                    },
                    child: Container(
                      height: 40.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: TextBody('Update',color: AppColors.white,),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      di<ItemNotifier>().deleteitem(context, id: widget.item.id!);
                    },
                    child: Container(
                      height: 40.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: TextBody(
                            'Delete',
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
