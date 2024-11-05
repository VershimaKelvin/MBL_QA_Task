import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/app/view/styles/fonts.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({
    required this.anItem,
    super.key});

  final ItemEntity anItem;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.anItem.createdAt!);
    String formattedDate = DateFormat('d MMMM yyyy').format(date);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: InkWell(
        onTap: (){

        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBody(widget.anItem.name!),
                    Gap(8.h),
                    Container(
                      width:150.w,
                      child: TextSmall(
                        widget.anItem.description!,
                        fontSize: 10.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextSmall(
                          'Created By:',
                          fontSize: 8.sp,
                        ),
                        Gap(8.w),
                        TextSmall(
                          widget.anItem.user!.username!,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Gap(8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextSmall(
                          'Date Created: ',
                          fontSize: 8.sp,
                        ),
                        TextSmall(
                          formattedDate,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    )
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
